local dap_install = require("dap-install")
local dbg_list = require("dap-install.debuggers_list").debuggers

dap_install.setup({
	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
	verbosely_call_debuggers = false,
})

for debugger, _ in pairs(dbg_list) do
	dap_install.config(debugger, {})
end
