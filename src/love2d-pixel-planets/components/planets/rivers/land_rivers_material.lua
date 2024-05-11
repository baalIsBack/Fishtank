local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/rivers/land_rivers.fp")


  


  


material.transform = {4.6,100.0,0.2,0.0,}
material.shader:send("transform", material.transform)


material.generic = {8.98,0.0,0.1,6.0,}
material.shader:send("generic", material.generic)


material.lights = {0.39,0.39,0.0,0.0,}
material.shader:send("lights", material.lights)


material.modify = {0.0,0.0,3.951,0.0,}
material.shader:send("modify", material.modify)


material.border = {0.287,0.476,0.0,0.0,}
material.shader:send("border", material.border)


material.extras = {0.0,0.0,0.476,0.0,}
material.shader:send("extras", material.extras)


material.col1 = {0.39,0.67,0.25,1.0,}
material.shader:send("col1", material.col1)


material.col2 = {0.23,0.49,0.31,1.0,}
material.shader:send("col2", material.col2)


material.col3 = {0.18,0.34,0.33,1.0,}
material.shader:send("col3", material.col3)


material.col4 = {0.16,0.21,0.25,1.0,}
material.shader:send("col4", material.col4)


material.river_col = {0.31,0.64,0.72,1.0,}
material.shader:send("river_col", material.river_col)


material.river_col_dark = {0.25,0.29,0.45,1.0,}
material.shader:send("river_col_dark", material.river_col_dark)

return material