-- Detect files with the `.tmux` extension as `tmux` filetype
vim.filetype.add({
  extension = {
    tmux = "tmux", -- Match files with the `.tmux` extension
  },
})
