How to use custom keyboard layout http://osxnotes.net/keylayout-files-and-ukelele.html

### Ports:

* aspell
* aspell-dict-en
* coreutils
* curl
* editorconfig-core-c
* emacs-app
* findutils
* git
* kdiff3
* ranger
* rsync
* stow
* the_silver_searcher
* tig
* tree
* vim
* wget

### Optional ports:

* apache-ant
* nodejs
* npm


# [Emacs font rendering on mac](https://www.reddit.com/r/emacs/comments/2jwxbl/fix_font_rendering_on_osx_emacs_244/)

I noticed Emacs 24.4 on OSX seems to break (or improve, YMMV) font rendering with some themes, including Zenburn.

To fix it, use your preferred OSX terminal and do this:

`defaults write org.gnu.Emacs FontBackend ns`

Restart Emacs and everything should be fine again.
