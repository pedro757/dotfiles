local dap_install = require("dap-install")
local di_api = require("dap-install.api.debuggers")
local dbg_list = di_api.get_installed_debuggers()
local dbg_path = require("dap-install.config.settings").options["installation_path"]

dap_install.setup({
	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
	verbosely_call_debuggers = false,
})

for _, debugger in ipairs(dbg_list) do
	if debugger ~= 'jsnode' then
		dap_install.config(debugger, {})
	end
end

dap_install.config("jsnode", {
	adapters = {
		type = "executable",
		command = "node",
		args = { dbg_path .. "jsnode/" .. "vscode-node-debug2/out/src/nodeDebug.js" }
	},
	configurations = {
		{
			type = "node2",
			request = "launch",
			program = "${workspaceFolder}/${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal"
		}
	}
})

require("dapui").setup()
