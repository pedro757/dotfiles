local dap = require'dap'
-- local dap_install = require("dap-buddy")
-- local di_api = require("dap-install.debuggers")
-- local dbg_list = di_api.get_installed_debuggers()
dap.adapters.node2 = {
	command = "node",
	type = "executable",
	args = { os.getenv('HOME') .. "/vscode-node-debug2/out/src/nodeDebug.js" }
}
local function attach()
	print("attaching")
	dap.run({
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require'dap.utils'.pick_process,
	})
end


-- dap_install.setup({
-- 	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
-- 	verbosely_call_debuggers = false,
-- })

-- for _, debugger in ipairs(dbg_list) do
-- 	dap_install.config(debugger, {})
-- end

require("dapui").setup()

vim.fn.sign_define('DapBreakpoint', {text='●', texthl='LspDiagnosticsDefaultError', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='●', texthl='LspDiagnosticsDefaultError', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='▶', texthl='', linehl='LspDiagnosticsDefaultError', numhl=''})
vim.fn.sign_define('DapBreakpointRejected,', {text='⁕', texthl='LspDiagnosticsDefaultError', linehl='', numhl=''})

return {
	attach = attach,
}
