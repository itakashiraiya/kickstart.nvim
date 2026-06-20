local latex_build_path = 'latex'
vim.g.vimtex_compiler_latexmk = {
  out_dir = latex_build_path,
  executable = 'latexmk',
  options = {
    '-pdf',
    '-interaction=nonstopmode',
    '-synctex=1',
    '-outdir=' .. latex_build_path, -- keep your folder clean
  },
}
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_progname = 'nvr'
