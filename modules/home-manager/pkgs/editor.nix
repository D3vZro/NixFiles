{ config, pkgs, lib, ... }:

# A general-purpose neovim-config I recommend

{
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        vim-nix
        vim-gitgutter
        vim-easymotion
        vim-surround
        vim-visual-multi
        vim-airline
        nord-vim

        { plugin = vim-auto-save;
          config = ''
            let g:auto_save = 1
          '';
        }
        { plugin = nerdtree;
          config = ''
            nnoremap <C-e> :NERDTreeToggle<CR>
            let g:NERDTreeWinPos = "right"

            " Auto-open Nerdtree
            autocmd VimEnter * NERDTree | wincmd p

            " Close Nerdtree if no buffer; one window
            autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

            " Close Nerdtree if no buffer in tab
            autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

            " Open Nerdtree in a new tab
            autocmd BufWinEnter * if getcmdwintype() == "" | silent NERDTreeMirror | endif
          '';
        }
      ];

      extraConfig = ''
      let mapleader=","
      set number relativenumber
      set ignorecase
      set smartcase
      set clipboard=unnamed
      set expandtab shiftwidth=2
      set mouse=a
      set conceallevel=0

      map <C-_> :noh<CR>
      map <C-O> o<Esc>

      colorscheme nord
      '';
    };
  };
}
