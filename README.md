# chasingmaxwell dotvim

This is my ~/.vim directory containing vim configuration primarily for working
in JavaScript, PHP, and Drupal. Feel free to use it! If you do, please find ways
to make it better and contribute back!

![chasingmaxwell dotvim screenshot](/screenshot.png?raw=true "Schreenshot")

## Prerequisites

1. You must have [Node.js](https://nodejs.org/en/) installed. I recommend using [NVM](https://github.com/creationix/nvm).

2. You must have [exuberant ctags](http://ctags.sourceforge.net) installed in order to make use of plugins like tagbar. The easiest way to install exuberant ctags is through a package manager.

  Using apt-get (linux):
  ```
  sudo apt-get install ctags-exuberant
  ```

  Using homebrew (Mac OS X):
  ```
  brew install ctags-exuberant
  ```

3. Install jsctags.

  ```
  npm install -g jsctags
  ```

## Installation

_Note:_ These directions are for unix-like operating systems. Some features
(like [phpctags](https://github.com/vim-php/phpctags)) are not compatible with
Windows.

1. Clone this repository into ~/.vim. If you already have a ~/.vim directory,
you should move it to ~/.vim-old before completing this step.
  ```
  git clone git@github.com:chasingmaxwell/dotvim.git ~/.vim
  ```

2. Run the build script.
  ```
  ~/.vim/build
  ```

3. Create a symlink from ~/.vimrc to ~/.vim/.vimrc. If you already have a
~/.vimrc file, you should rename it to ~/.vimrc-old before completing this step.
  ```
  ln -s ~/.vim/.vimrc ~/.vimrc
  ```

4. Open vim or gvim/macvim. You may see a few error messages because plugins aren't
installed yet. You won't see them anymore after NeoBundle does its thing.

5. When prompted to install bundles, enter "y" (or click "Yes" in gvim/macvim).

6. If you are using a shell other than bash, add `~/.vim/bundle/phpctags_v0_5_1`
to your PATH. If you are using bash, this was done for you when you ran the
build script.

7. Source your .bashrc file (or equivalent if you're using a different shell).
  ```
  source ~/.bashrc
  ```

8. Close and reopen vim or gvim/macvim.

## Plugins used

1. [AutoClose](https://github.com/vim-scripts/AutoClose) - Close brackets,
parenthesis, etc. automatically.
2. [bufexplorer](https://github.com/jlanzarotta/bufexplorer) - Commands for
navigating buffers.
3. [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim) - Quickly navigate between
files using the Ctrl+p shortcut.
4. [drupal-vimrc](https://drupal.org/project/vimrc) - Provides a set of
Drupal-specific configuration and features.
5. [grep.vim](https://github.com/vim-scripts/grep.vim) - Search files for
string.
6. [molokai](https://github.com/tomasr/molokai) - My favorite color scheme. If
it doesn't look great out-of-the-box, try gvim/macvim or use a terminal that supports
256 colors.
7. [neobundle](https://github.com/Shougo/neobundle.vim) - Manage plugins.
8. [neocomplcache](https://github.com/Shougo/neocomplcache.vim) - Cached keyword
completion.
9. [neosnippet-snippets](https://github.com/Shougo/neosnippet-snippets) -
Snippets for neosnippet.
10. [neosnippet](https://github.com/Shougo/neosnippet.vim) - Provides snippet
support.
11. [nerdcommenter](https://github.com/scrooloose/nerdcommenter) - Provides
keyboard shortcuts for commenting and uncommenting.
12. [nerdtree](https://github.com/scrooloose/nerdtree) - Directory tree viewer.
13. [phpctags](https://github.com/vim-php/phpctags) - An enhanced php ctags
index file generator.
14. [php.vim](https://github.com/StanAngeloff/php.vim) - Better php syntax support.
15. [syntastic](https://github.com/scrooloose/syntastic) - Syntax checking.
16. [tagbar](https://github.com/majutsushi/tagbar) - Tag viewer.
17. [tagbar-phpctags](https://github.com/vim-php/tagbar-phpctags.vim) - Add
better php support for tagbar.
18. [vdebug](https://github.com/joonty/vdebug) - Step debugging.
19. [vim-css3-syntax](https://github.com/hail2u/vim-css3-syntax) - Better css3
and sass syntax support.
20. [vim-fugitive](https://github.com/tpope/vim-fugitive) - A wrapper for some
common git commands.
21. [vim-javascript](https://github.com/pangloss/vim-javascript) - Add better
JavaScript syntax and indentation handling.
22. [vim-json](https://github.com/elzr/vim-json) - Add better JSON handling.
23. [vimproc](https://github.com/Shougo/vimproc.vim) - An asynchronous execution
library for vim.
24. [vim-sensible](https://github.com/tpope/vim-sensible) - Provide sensible
default configuration for vim.
25. [vim-signify](https://github.com/mhinz/vim-signify) - Indicate changed lines
in version-controlled files.

## Private configuration

You can set private configuration in .vimrc-private which is not tracked by git.
There are two variables in particular that are used by .vimrc and useful to set
here:

- g:private_vdebug_server - The address of the remote server for which you'd
  like to utilize step debugging with Vdebug.
- g:private_vdebug_path_maps - The path mapping between the remote server and
  local file system when step debugging with Vdebug.

Here's an example of what your .vimrc-private might look like:

```VimL
"
" Private Vim Configuration
" =========================

" Vdebug Servers
let s:server_one='192.168.1.5'
let s:server_two='192.168.1.6'

" Set the value of vdebug_server to whatever above server you will be
" debugging.
let g:private_vdebug_server=s:server_one

" Vdebug Paths
let g:private_vdebug_path_maps={
\  "/home/remote_user/www": "/home/" . $USER . "/www"
\}

" Use phpmd ruleset for Drupal.
let g:syntastic_php_phpmd_post_args='/home/' . $USER . '/.phpmd/drupal-ruleset.xml'

" Run rsync when saving a file in specific directories.
augroup rsyncTestServer
  au! BufWritePost ~/www/some_project/* call RsyncTestServer(s:server_one, "~/www/some_project/", "/home/remote_user/www/some_project/", "~/www/some_project/rsyncExclude")
augroup END
```  
