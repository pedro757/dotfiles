if not pcall(require, "nvim-treesitter") then
  return
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { "smali", "t32" },
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  autopairs = {
    enable = true
  },
  matchup = {
    enable = true
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-big',
    }
  },
}
