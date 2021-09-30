local dap = require'dap'
local dap_install = require("dap-install")
local di_api = require("dap-install.api.debuggers")
local dbg_list = di_api.get_installed_debuggers()
local function attach()
	print("attaching")
	dap.run({
		type = "node2",
		request = "attach",
		pid = require'dap.utils'.pick_process,
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		skipFiles = { "<node_internals>/**/*.js" }
	})
end

dap_install.setup({
	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
	verbosely_call_debuggers = false,
})

for _, debugger in ipairs(dbg_list) do
	dap_install.config(debugger, {})
end

require("dapui").setup()

return {
	attach = attach,
}
