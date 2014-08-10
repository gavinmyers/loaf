require "lib/network"

token = "ac709186-85ec-4478-8355-f079ddcd8f22"


-- create a new TCP client socket
connection = network.tcp.client()

-- this function gets run if the connection is successful
function connection:on_open()
    print("Connected")
    --connection:send("Ping")
end

-- this function gets run when the connection is closed
function connection:on_close()
    print("Closed")
    love.event.quit()
    -- or you could do:
    -- print("Connection lost, reconnecting...")
    -- connection:reconnect()
    -- print("Reconnected")
end

-- this function gets run if the socket receives a message (passing the message's data)
function connection:on_message(msg)
  local jsn = json.decode(msg)
  if jsn.Action ~= nil then
    print(jsn.Token .. '[' .. jsn.Action .. ']')
  end
end

-- this function gets run if something bad happens (passing a short message explaining the error)
function connection:on_error(msg)
    print("Error: " .. msg)
    love.event.quit()
end

