local M = {}

M.t = function(key)
  return vim.api.nvim_replace_termcodes(key, true, true, true)
end

M.prequire = function(...)
    local status, lib = pcall(require, ...)
    if not status then return nil, lib end
    return lib
end

M.executable = function (command)
  return vim.fn.executable(command) > 0
end

return M
