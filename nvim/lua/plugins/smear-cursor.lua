---@type LazySpec
return {
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      cursor_color = "#8be9fd",

      stiffness = 0.5,
      trailing_stiffness = 0.2,
      trailing_exponent = 5,
      damping = 0.6,
      gradient_exponent = 0,

      particles_enabled = true,
      particle_max_num = 200,
      particle_spread = 1,
      particles_per_second = 80,
      particles_per_length = 25,
      particle_max_lifetime = 900,
      particle_max_initial_velocity = 8,
      particle_velocity_from_cursor = 0.4,
      particle_random_velocity = 160,
      particle_damping = 0.2,
      particle_gravity = -20,
    },
  },
}
