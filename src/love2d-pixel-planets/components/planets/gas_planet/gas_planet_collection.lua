return { --default
{
  id = "gas_planet",
  component = require("love2d-pixel-planets.components.planets.gas_planet.gas_planet_go"),
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
  id = "clouds",
  component = require("love2d-pixel-planets.components.planets.gas_planet.clouds_go"),
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
--scale_along_z: 0
--[[embedded_instances {
  id = "scripts",
  data = "components {\n",
  "  id = \"gas_planet\"\n",
  "  component = \"love2d-pixel-planets.components.planets.gas_planet.gas_planet.script\"\n",
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