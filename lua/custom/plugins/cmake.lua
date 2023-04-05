return {
  'Shatur/neovim-cmake',
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
  },
  config = function()
    require('cmake').setup {
      cmake_executable = 'cmake',                                                -- CMake executable to run.
      save_before_build = true,                                                  -- Save all buffers before building.
      parameters_file = 'neovim.json',                                           -- JSON file to store information about selected target, run arguments and build type.
      default_parameters = { args = {"j6"}, build_type = 'Debug' },                  -- The default values in `parameters_file`. Can also optionally contain `run_dir` with the working directory for applications.
      build_args = {},                                                           -- Default arguments that will be always passed at cmake build step.
      on_build_output = nil,                                                     -- Callback that will be called each time data is received by the current process. Accepts the received data as an argument.
      quickfix = {
        pos = 'botright',                                                        -- Where to open quickfix
        height = 20,                                                             -- Height of the opened quickfix.
        only_on_error = false,                                                   -- Open quickfix window only if target build failed.
      },
      copy_compile_commands = true,                                              -- Copy compile_commands.json to current working directory.
      dap_configurations = {
                                                                                 -- Table of different DAP configurations.
        lldb_vscode = { type = 'lldb', request = 'launch' },
        cppdbg_vscode = { type = 'cppdbg', request = 'launch' },
      },
      dap_configuration = 'lldb_vscode',                              -- DAP configuration to use if the projects `parameters_file` does not specify one.
      dap_open_command = function(...) require('dap').repl.open(...) end, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
    }
  end,
}
