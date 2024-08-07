return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = function(_, opts)
    return require("indent-rainbowline").make_opts(opts, {
      -- How transparent should the rainbow colors be. 1 is completely opaque, 0 is invisible. 0.07 by default
      color_transparency = 0.12,
      -- The 24-bit colors to mix with the background. Specified in hex.
      colors = { 0xffff40, 0x79ff79, 0xff79ff, 0x4fecec, } -- by default
    })
  end,
  dependencies = {
    "TheGLander/indent-rainbowline.nvim",
    "shaunsingh/nord.nvim",
  },
}
