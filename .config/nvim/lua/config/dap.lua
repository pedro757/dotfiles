local dap_install = require("dap-install")
local dbg_list = require("dap-install.debuggers_list").debuggers
local dbg_path = require("dap-install.debuggers_list").debuggers["jsnode_dbg"][2]

dap_install.setup({
	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
	verbosely_call_debuggers = false,
})

for debugger, _ in pairs(dbg_list) do
	if debugger ~= 'jsnode_dbg' then
		dap_install.config(debugger, {})
	end
end

dap_install.config("jsnode_dbg", {
	adapters = {
		type = "executable",
		command = "node",
		args = {dbg_path .. "vscode-node-debug2/out/src/nodeDebug.js"}
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
