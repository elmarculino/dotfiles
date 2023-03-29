local themes = require('telescope.themes')

local no_preview = function()
  return require('telescope.themes').get_dropdown({
    borderchars = {
      { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
      prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
      results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
      preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    },
    width = 0.8,
    previewer = false,
    prompt_title = false
  })
end

local M = {}

function M.project_files()
  local opts = {
    find_command = { "fd", "--type", "f", "--hidden" }
  }
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

function M.find_dotfiles()
  local opts = {
    find_command = { "fd", "--type", "f", "--hidden" },
    shorten_path = false,
    hidden = true,
    cwd = "~/.dotfiles/",
    prompt_title = "~ dotfiles ~",
    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.35,
    }
  }
  require("telescope.builtin").find_files(opts)
end

function M.current_buffer()
  require("telescope.builtin").current_buffer_fuzzy_find(no_preview())
end

function M.buffers()
  require("telescope.builtin").buffers(no_preview())
end

function M.fd()
  local opts = themes.get_ivy { hidden = true }
  require("telescope.builtin").fd(opts)
end

return M
