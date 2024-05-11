local vertices = {
  { -0.5, -0.5,  0, 0 }, -- Vertex 1: position (-0.5, -0.5), texture coordinates (0, 0)
  {  0.5, -0.5,  1, 0 }, -- Vertex 2: position (0.5, -0.5), texture coordinates (1, 0)
  { -0.5,  0.5,  0, 1 }, -- Vertex 3: position (-0.5, 0.5), texture coordinates (0, 1)
  {  0.5,  0.5,  1, 1 }, -- Vertex 4: position (0.5, 0.5), texture coordinates (1, 1)
}

-- Define the triangles
local triangles = { 4, 3, 1, 4, 1, 2 }

-- Create the mesh
local mesh = love.graphics.newMesh(vertices, "triangles")

-- Set the mesh's vertex map
mesh:setVertexMap(triangles)

return mesh