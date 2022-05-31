local M = {}

M.t = function(key)
  return vim.api.nvim_replace_termcodes(key, true, true, true)
end

M.prequire = function(...)
    local status, lib = pcall(require, ...)
    if not status then return lib end
    return nil
end

M.executable = function (command)
  return vim.fn.executable(command) > 0
end

return M
