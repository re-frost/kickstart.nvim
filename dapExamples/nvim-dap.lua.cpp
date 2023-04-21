-- install codelldb
local dap = require('dap')

dap.adapters.cpp = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'cpp',
    request = "launch",
    program = "${workspaceFolder}/build/bin/pb-calib-registration",
    cwd = '${workspaceFolder}/build/bin/',
    args = { "../../config/config.json" },
  },
}
