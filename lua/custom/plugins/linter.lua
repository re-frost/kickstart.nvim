return {
  'mfussenegger/nvim-lint',
  config = function()
    require('lint').linters_by_ft = {
      python = { 'flake8' },
      cpp = { 'clangtidy' },  --- pacman clang-tidy
      cpplint = {'cpplint'},
      cppcheck = {'cppcheck'},
    }
  end
}
