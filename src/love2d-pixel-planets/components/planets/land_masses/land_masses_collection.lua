return { --land_masses
{
  id = "water",
  component = require("love2d-pixel-planets.components.planets.land_masses.water_go"),
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
  id = "land",
  component = require("love2d-pixel-planets.components.planets.land_masses.land_go"),
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
  id = "clouds",
  component = require("love2d-pixel-planets.components.planets.land_masses.clouds_go"),
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
  "  id = \"land_masses\"\n",
  "  component = \"love2d-pixel-planets.components.planets.land_masses.land_masses.script\"\n",
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