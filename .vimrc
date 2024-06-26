""
"" Basic Setup
""

set nocompatible                    " Must be first line
set relativenumber number           " Line numbers on
set ruler                           " Show the ruler
set laststatus=2                    " Always show the status line
set showmode                        " Display the current mode
set showcmd                         " Show partial commands in status line and
set cursorline                      " Highlight current line
set hidden                          " Allow buffer switching without saving
filetype plugin indent on           " Automatically detect file types
syntax on                           " Syntax highlighting
set shortmess+=c                    " Don't give ins-completion-menu messages
set wildmenu                        " Show list instead of just completing

" Neovim disallow changing 'enconding' option after initialization
if !has('nvim')
  set encoding=utf-8                " Set default encoding to UTF-8
endif

" Always show the signcolumn, otherwise it would shift the text each time
set signcolumn=yes

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

""
"" Whitespace
""

set nowrap                          " Do not wrap long lines
set tabstop=2                       " An indentation every two columns
set softtabstop=2                   " Let backspace delete indent
set shiftwidth=2                    " Use indents of 2 spaces
set expandtab                       " Tabs are spaces, not tabs
set list                            " Show invisible characters
set backspace=indent,eol,start      " Backspace for dummies

" Highlight problematic whitespace
set listchars=""                    " Reset the listchars
set listchars=tab:\ \               " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.              " show trailing spaces as dots
set listchars+=extends:>            " The character to show in the last column when wrap is
                                    " off and the line continues beyond the right of the screen
set listchars+=precedes:<           " The character to show in the last column when wrap is
                                    " off and the line continues beyond the left of the screen

""
"" Searching
""

set hlsearch                        " Highlight search terms
set incsearch                       " Find as you type search
set ignorecase                      " Case insensitive search
set smartcase                       " Case sensitive when uc present

""
"" Backup and swap files
""

set backupdir^=~/.vim/_backup//     " Where to put backup files
set directory^=~/.vim/_temp//       " Where to put swap files
set undodir^=~/.vim/_undo//         " Where to put undo files

" Some servers have issues with backup files, see neoclide/coc.nvim#649.
set nobackup
set nowritebackup
set undofile
set noswapfile

""
"" Key (re)Mappings
""

" Mapleader
let mapleader = ','

" Wrapped lines goes down/up to next row, rather than next line in file
noremap j gj
noremap k gk

" Clear search
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Autoformat
noremap <leader>f :Autoformat<CR>

""
"" Plugins
""

" Matchit
packadd! matchit

" Minpac
packadd minpac
call minpac#init()

call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-fugitive')
call minpac#add('preservim/nerdcommenter')
call minpac#add('ctrlpvim/ctrlp.vim')
call minpac#add('bronson/vim-trailing-whitespace')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('tomtom/tlib_vim')
call minpac#add('marcweber/vim-addon-mw-utils')
call minpac#add('garbas/vim-snipmate')
call minpac#add('honza/vim-snippets')
call minpac#add('mileszs/ack.vim')
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
call minpac#add('vim-autoformat/vim-autoformat')
call minpac#add('jiangmiao/auto-pairs')
call minpac#add('ap/vim-css-color')
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('thinca/vim-visualstar')
call minpac#add('vim-ruby/vim-ruby')
call minpac#add('pangloss/vim-javascript')
call minpac#add('HerringtonDarkholme/yats.vim')
call minpac#add('MaxMEllon/vim-jsx-pretty')
call minpac#add('elzr/vim-json')
call minpac#add('bfrg/vim-cpp-modern')
call minpac#add('puremourning/vimspector')
call minpac#add('bfrg/vim-jqplay')
call minpac#add('lifepillar/vim-colortemplate', {'type':'opt'})
call minpac#add('k-takata/minpac', {'type':'opt'})

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

" SnipMate
:imap <C-J> <Plug>snipMateNextOrTrigger
:smap <C-J> <Plug>snipMateNextOrTrigger

" Fugitive
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gl :Gclog<CR>
nnoremap <silent> <leader>gc :Git commit<CR>
nnoremap <silent> <leader>gp :Git push<CR>

" CtrlP
if executable('rg')
  " Use rg over Grep
  set grepprg=rg\ --vimgrep
  " Use rg in CtrlP for listing files.
  let g:ctrlp_user_command = 'rg %s --files'
  " rg is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
endif

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" JSON
let g:vim_json_syntax_conceal = 0

" SnipMate
let g:snipMate = { 'snippet_version' : 1 }

" Color
colorscheme tokyonight256_moon
if (has('termguicolors'))
  set termguicolors
endif

" ACK
cnoreabbrev Ack Ack!
nnoremap <Leader>F :Ack!<Space>
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

" COC
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

" mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

nmap <LocalLeader><F11> <Plug>VimspectorUpFrame
nmap <LocalLeader><F12> <Plug>VimspectorDownFrame
nmap <LocalLeader>B     <Plug>VimspectorBreakpoints
nmap <LocalLeader>D     <Plug>VimspectorDisassemble

" NERD Commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
