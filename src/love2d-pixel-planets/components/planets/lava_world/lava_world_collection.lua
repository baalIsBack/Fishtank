return { --default
{
  id = "planet_under",
  component = require("love2d-pixel-planets.components.planets.lava_world.planet_under_go"),
  position = {
    x = 0.0,
    y = 0.0,
    z = 0.0,
  },
  rotation = {
    x = 0.0,
    y = 0.0,
    z = 0.0,
    w = 1.0,
  },
  scale3 = {
    x = 100.0,
    y = 100.0,
    z = 1.0,
  }
},
{
  id = "craters",
  component = require("love2d-pixel-planets.components.planets.lava_world.craters_go"),
  position = {
    x = 0.0,
    y = 0.0,
    z = 0.1,
  },
  rotation = {
    x = 0.0,
    y = 0.0,
    z = 0.0,
    w = 1.0,
  },
  scale3 = {
    x = 100.0,
    y = 100.0,
    z = 1.0,
  }
},
{
  id = "rivers",
  component = require("love2d-pixel-planets.components.planets.lava_world.rivers_go"),
  position = {
    x = 0.0,
    y = 0.0,
    z = 0.2,
  },
  rotation = {
    x = 0.0,
    y = 0.0,
    z = 0.0,
    w = 1.0,
  },
  scale3 = {
    x = 100.0,
    y = 100.0,
    z = 1.0,
  }
},
--scale_along_z: 0
--[[embedded_instances {
  id = "scripts",
  data = "components {\n",
  "  id = \"lava_world\"\n",
  "  component = \"love2d-pixel-planets.components.planets.lava_world.lava_world.script\"\n",
  "  position {\n"
  "    x = 0.0\n",
  "    y = 0.0\n",
  "    z = 0.0\n",
  "  }\n"
  "  rotation {\n"
  "    x = 0.0\n",
  "    y = 0.0\n",
  "    z = 0.0\n",
  "    w = 1.0\n",
  "  }\n"
  "}\n"
  ""
  position = {
    x = 0.0,
    y = 0.0,
    z = 0.0,
  },
  rotation = {
    x = 0.0,
    y = 0.0,
    z = 0.0,
    w = 1.0,
  },
  scale3 = {
    x = 1.0,
    y = 1.0,
    z = 1.0,
  }
},
]]}