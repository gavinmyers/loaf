--https://github.com/big-tacos/love2d-networking/blob/master/network.lua
-- Useful resources:
-- http://w3.impa.br/~diego/software/luasocket/tcp.html
-- http://w3.impa.br/~diego/software/luasocket/socket.html#select

require "socket"

-- namespaces
network = {}
network.tcp = {}

-- maximum number of reconnection tries
network.tcp.max_try = 5
network.tcp.max_timeout = 1/50 -- in s (socket.select takes ms, socket:settimeout takes secs)

-- turn an existing socket into a network.tcp.client
-- assuming it's open
function network.tcp.convert(sock)
  local new = network.tcp.client()

  new.closed = false
  new.host, new.port = sock:getpeername()
  new.socket = sock
  new.try = 0
  
  return new
end

-- create a new client socket (connect using :connect(host, port))
function network.tcp.client()
  local new = {}

  -- new instance is closed by default
  new.closed = true

  -- this is an internal function
  -- DO NOT call this function
  function new:callback(type, msg)
    if type == "open" then
      if self.on_open then
        self:on_open()
      end
    elseif type == "close" then
      if self.on_close then
        self:on_close()
      end
    elseif type == "message" then
      if self.on_message then
        self:on_message(msg)
      end
    elseif type == "error" then
      if self.on_error then
        self:on_error(msg)
      end
      
      self:close() -- close on any error?
    end
  end

  -- connects TCP socket to host@port
  function new:connect(host, port)
    -- don't connect while still open
    if not self.closed then
      self:callback("error", "can't connect while connected")
      return
    end

    -- create a new TCP socket instance
    self.socket = socket.tcp()

    -- check if connection can be made
    if not self.socket:connect(host, port) then
      self:callback("error", "couldn't connect (probably not listening)")
      return
    end

    self.host = host
    self.port = port
    self.closed = false
    self.try = 0

    self:callback("open")
  end

  -- closes the TCP socket
  function new:close()
    -- close only if not already closed
    if not self.closed then
      self.closed = true
      -- self.socket:close() -- should I?
      self:callback("close")
    end
  end

  -- tries to reconnect the TCP socket based on the original host address and port number
  function new:reconnect()
    -- socket was never open
    if not self.host and not self.port then
      self:callback("error", "can't reconnect without connecting first")
      return
    end

    -- socket still open
    if not self.closed then
      self:callback("error", "can't reconnect while still connected")
      return
    end

    -- too many reconnects
    if self.try > (self.max_try or network.tcp.max_try) then
      self:callback("error", "can't reconnect (maximum number of tries exceeded (" .. tostring(self.try) .. "))")
      self.try = 0 -- reset tries
      return
    end

    -- can't use socket:connect again on a once-closed socket - must create new instance
    self.socket = socket.tcp()

    if self.socket:connect(self.host, self.port) then
      self.closed = false
      self.try = 0
      self:callback("open")
    else
      -- for now it's running recursively, but I might turn this into a for (try = 0; try < max_try; try++) loop
      self.try = self.try + 1
      self:reconnect()
    end
  end

  -- sends a message through the TCP socket
  function new:send(msg)
    -- don't send message if socket is closed
    if self.closed then
      return
    end

    -- append "\n" if it's not there
    -- if string.sub(msg, -1, -1) ~= "\n" then
    --  msg = msg .. "\n"
    -- end

    -- send message
    self.socket:send(msg)
  end

  -- the update() function receives messages if there are any
  -- you should put this in the love.update() loop and pass the delta time as a parameter
  function new:update()
    -- don't receive messages if socket is closed
    if self.closed then
      return
    end

    -- quasi-non-blocking receive
    -- this line might be a bad idea - untested
    self.socket:settimeout(network.tcp.max_timeout)

    local message, status, partial = self.socket:receive()

    -- continue if received message is partial
    if partial then
      message = partial
    end

    -- set "closed" flag if socket is closed
    if status == "closed" then
      self:close()
    end

    -- callback with message if length > 0
    if #message > 0 then
      self:callback("message", message)
    end
  end

  return new
end

-- create a new server socket
function network.tcp.server()
  local new = {}

  new.clients = {} -- add functions for all open & closed sockets

  new.closed = true

  function new:callback(type, msg, socket)
    if type == "bind" then
      if self.on_bind then
        self:on_bind()
      end
    elseif type == "unbind" then
      if self.on_unbind then
        self:on_unbind()
      end
    elseif type == "open" then
      if self.on_open then
        self:on_open(msg) -- actually socket
      end
    elseif type == "close" then
      if self.on_close then
        self:on_close(msg) -- actually socket
      end
    elseif type == "message" then
      -- define self:reply(msg) or set self.currentSocket
      if self.on_message then
        self:on_message(msg, socket)
      end
    elseif type == "error" then
      if self.on_error then
        self:on_error(msg)
      end

      self:close() -- close on any error?
    end
  end

  function new:bind(host, port)
    -- create a new TCP socket instance
    self.socket = socket.bind(host, port)

    -- check if connection can be made
    if not self.socket then
      self:callback("error", "couldn't bind (probably address occupied)")
      return
    end

    self.host = host
    self.port = port
    self.closed = false

    self:callback("bind")
  end

  function new:send(msg, sock)
    if self.closed then
      return
    end

    if sock.closed then
      return
    end

    -- append "\n" if it's not there
    -- if string.sub(msg, -1, -1) ~= "\n" then
    --  msg = msg .. "\n"
    -- end

    -- send message
    sock:send(msg)
  end

  function new:reply(msg)
    if self.current then
      self:send(msg, self.current)
    else
      -- no current socket
      -- error?
    end
  end

  function new:unbind()
    if self.closed then
      return
    end

    -- close every open client in self.clients

    -- self.socket:close() -- should I?
    self:callback("unbind")
  end

  function new:broadcast(msg, except)
    -- TODO fix except-ing

    -- if not except then
    --  except = {}
    -- end

    -- if not type(except) == "table" then
    --  except = {except}
    -- end

    for index, client in pairs(self.clients) do
      local okay = not client.closed

      -- for except_index, except_client in pairs(except) do
      --  -- TODO test if this table comparison actually works
      --  if client == except_client then
      --    okay = false
      --  end
      -- end

      if okay then
        client:send(msg)
      end
    end
  end

  function new:updateServer()   
    -- we'll be only using settimeout() here, because according to:
    -- http://w3.impa.br/~diego/software/luasocket/tcp.html#accept
    -- "Note: calling socket.select with a server object in the recvt parameter before a call to accept does not guarantee accept will return immediately. Use the settimeout method or accept might block until another client shows up."

    if self.closed then
      return
    end

    -- quasi-non-blocking receive
    -- this line might be a bad idea - untested
    self.socket:settimeout(network.tcp.max_timeout)

    local client, status = self.socket:accept()

    if client then
      -- convert socket to network.tcp.client
      client = network.tcp.convert(client)

      -- add callbacks
      client.on_open = self.on_open
      client.on_close = self.on_close
      client.on_message = self.on_message
      client.on_error = self.on_error

      -- add to array of all clients
      table.insert(self.clients, client)
      
      -- callback on_open
      client:callback("open")
    end
  end

  function new:updateClients()
    for index, client in pairs(self.clients) do
      client:update()
    end
  end

  function new:update()
    if self.closed then
      return
    end

    -- update server part of socket
    self:updateServer()

    -- update clients
    self:updateClients()
  end

  return new
end
