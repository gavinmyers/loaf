lighting = {}
lighting._shaders = {}

function lighting.init() 
  local cld01 = love.graphics.newShader([[
    vec4 effect(vec4 color, Image texture, vec2 vTexCoord, vec2 pixel_coords)
      {
         vec4 sum = vec4(0.0);
         number blurSize = 0.09;
         //number d = distance(vTexCoord, mousePos/screenSize);
         //number blurSize = clamp(1/d/screenSize.x, 0, 1.0);
         // blur in y (vertical)
         // take nine samples, with the distance blurSize between them
         sum += texture2D(texture, vec2(vTexCoord.x - 4.0*blurSize, vTexCoord.y)) * 0.05;
         sum += texture2D(texture, vec2(vTexCoord.x - 3.0*blurSize, vTexCoord.y)) * 0.09;
         sum += texture2D(texture, vec2(vTexCoord.x - 2.0*blurSize, vTexCoord.y)) * 0.12;
         sum += texture2D(texture, vec2(vTexCoord.x - blurSize, vTexCoord.y)) * 0.15;
         sum += texture2D(texture, vec2(vTexCoord.x, vTexCoord.y)) * 0.16;
         sum += texture2D(texture, vec2(vTexCoord.x + blurSize, vTexCoord.y)) * 0.15;
         sum += texture2D(texture, vec2(vTexCoord.x + 2.0*blurSize, vTexCoord.y)) * 0.12;
         sum += texture2D(texture, vec2(vTexCoord.x + 3.0*blurSize, vTexCoord.y)) * 0.09;
         sum += texture2D(texture, vec2(vTexCoord.x + 4.0*blurSize, vTexCoord.y)) * 0.05;
         
         
         return sum * 0.9;
      }
    ]])
  lighting.setShader("cld01",cld01)
end

function lighting.setShader(k,v) 
  lighting._shaders[k] = v
end

function lighting.getShader(k) 
  return lighting._shaders[k]
end
