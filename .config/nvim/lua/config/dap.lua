local dap_install = require("dap-install")
local di_api = require("dap-install.api.debuggers")
local dbg_list = di_api.get_installed_debuggers()

dap_install.setup({
	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
	verbosely_call_debuggers = false,
})

for _, debugger in ipairs(dbg_list) do
	dap_install.config(debugger, {})
end

require("dapui").setup()
