---@type LazySpec
return {
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      cursor_color = "#8be9fd",

      -- Gyorsabb, reszponzívabb mozgás → kevesebb lag érzet + shadow is kevésbé látható
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      trailing_exponent = 3,
      damping = 0.92,

      -- Gradient
      gradient_exponent = 1.0,

      -- Particles KIKAPCSOLVA → ez volt a lag fő forrása
      particles_enabled = true,

      -- Shadow fix: ha Cascadia Code vagy más legacy-symbol fontot használsz, állítsd true-ra
      legacy_computing_symbols_support = false, -- → true ha a fontod támogatja

      -- Neighbor line smear opcionálisan kikapcsolható további gyorsításhoz
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,

      -- Framerate növelés (default 17ms ~60fps, csökkentve gyorsabb lesz)
      time_interval = 17,

      -- Animáció korábban leáll → kevesebb CPU
      distance_stop_animating = 0.5,
    },
  },
}
