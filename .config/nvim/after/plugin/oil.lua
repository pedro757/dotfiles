if not pcall(require, "oil") then
  return
end

vim.keymap.set("n", "<leader>e", require"oil".toggle_float)
