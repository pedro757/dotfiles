local dap = require "dap"

dap.adapters.node2 = {
  command = "node",
  type = "executable",
  args = { os.getenv "HOME" .. "/vscode-node-debug2/out/src/nodeDebug.js" },
}

local function attach()
  print "attaching"
  dap.run {
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = require("dap.utils").pick_process,
  }
end

vim.fn.sign_define(
  "DapBreakpoint",
  {
    text = " ",
    texthl = "LspDiagnosticsDefaultError",
    linehl = "",
    numhl = "",
  }
)
vim.fn.sign_define(
  "DapBreakpointCondition",
  {
    text = " ",
    texthl = "LspDiagnosticsDefaultError",
    linehl = "",
    numhl = "",
  }
)
vim.fn.sign_define(
  "DapStopped",
  {
    text = " ",
    texthl = "",
    linehl = "LspDiagnosticsDefaultError",
    numhl = "",
  }
)
vim.fn.sign_define(
  "DapBreakpointRejected,",
  {
    text = " ",
    texthl = "LspDiagnosticsDefaultError",
    linehl = "",
    numhl = "",
  }
)

return {
  attach = attach,
}
