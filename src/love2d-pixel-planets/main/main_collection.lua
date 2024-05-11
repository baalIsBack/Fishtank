return { --main
{
  id = "lowrez",
  component = require("love2d-pixel-planets.components.lowrez.lowrez_go"),
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
{
  id = "background",
  component = require("love2d-pixel-planets.components.background.background_go"),
  position = {
    x = 320.0,
    y = 180.0,
    z = 0.0,
  },
  rotation = {
    x = 0.0,
    y = 0.0,
    z = 0.0,
    w = 1.0,
  },
  scale3 = {
    x = 640.0,
    y = 360.0,
    z = 1.0,
  }
},
--scale_along_z: 0
--[[embedded_instances {
  id = "target",
  data = "",
  position = {
    x = 190.0,
    y = 180.0,
    z = 0.1,
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
--[[embedded_instances {
  id = "scripts",
  data = "components {\n",
  "  id = \"main\"\n",
  "  component = \".scripts.main.script\"\n",
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
--[[embedded_instances {
  id = "particles",
  data = "components {\n",
  "  id = \"stars\"\n",
  "  component = \".assets.particles.stars.particlefx\"\n",
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
    x = 320.0,
    y = 180.0,
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
--[[embedded_instances {
  id = "gui",
  data = "components {\n",
  "  id = \"settings\"\n",
  "  component = \"love2d-pixel-planets.components.gui.settings.gui\"\n",
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
--[[embedded_instances {
  id = "collections",
  data = "embedded_components {\n",
  "  id = \"planet_1\"\n",
  "  type = \"collectionfactory\"\n",
  "  data: \"prototype = \\\"love2d-pixel-planets.components.planets.rivers.rivers.collection\\\"\\n",
  "load_dynamically = false\\n",
  "\"\n"
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
  "embedded_components {\n"
  "  id = \"planet_2\"\n",
  "  type = \"collectionfactory\"\n",
  "  data: \"prototype = \\\"love2d-pixel-planets.components.planets.dry_terran.dry_terran.collection\\\"\\n",
  "load_dynamically = false\\n",
  "\"\n"
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
  "embedded_components {\n"
  "  id = \"planet_4\"\n",
  "  type = \"collectionfactory\"\n",
  "  data: \"prototype = \\\"love2d-pixel-planets.components.planets.no_atmosphere.no_atmosphere.collection\\\"\\n",
  "load_dynamically = false\\n",
  "\"\n"
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
  "embedded_components {\n"
  "  id = \"planet_3\"\n",
  "  type = \"collectionfactory\"\n",
  "  data: \"prototype = \\\"love2d-pixel-planets.components.planets.land_masses.land_masses.collection\\\"\\n",
  "load_dynamically = false\\n",
  "\"\n"
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
  "embedded_components {\n"
  "  id = \"planet_5\"\n",
  "  type = \"collectionfactory\"\n",
  "  data: \"prototype = \\\"love2d-pixel-planets.components.planets.gas_planet.gas_planet.collection\\\"\\n",
  "load_dynamically = false\\n",
  "\"\n"
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
  "embedded_components {\n"
  "  id = \"planet_9\"\n",
  "  type = \"collectionfactory\"\n",
  "  data: \"prototype = \\\"love2d-pixel-planets.components.planets.asteroids.asteroid.collection\\\"\\n",
  "load_dynamically = false\\n",
  "\"\n"
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
  "embedded_components {\n"
  "  id = \"planet_6\"\n",
  "  type = \"collectionfactory\"\n",
  "  data: \"prototype = \\\"love2d-pixel-planets.components.planets.gas_giant.gas_giant.collection\\\"\\n",
  "load_dynamically = false\\n",
  "\"\n"
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
  "embedded_components {\n"
  "  id = \"planet_7\"\n",
  "  type = \"collectionfactory\"\n",
  "  data: \"prototype = \\\"love2d-pixel-planets.components.planets.ice_world.ice_word.collection\\\"\\n",
  "load_dynamically = false\\n",
  "\"\n"
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
  "embedded_components {\n"
  "  id = \"planet_8\"\n",
  "  type = \"collectionfactory\"\n",
  "  data: \"prototype = \\\"love2d-pixel-planets.components.planets.lava_world.lava_world.collection\\\"\\n",
  "load_dynamically = false\\n",
  "\"\n"
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
  "embedded_components {\n"
  "  id = \"planet_10\"\n",
  "  type = \"collectionfactory\"\n",
  "  data: \"prototype = \\\"love2d-pixel-planets.components.planets.star.star.collection\\\"\\n",
  "load_dynamically = false\\n",
  "\"\n"
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