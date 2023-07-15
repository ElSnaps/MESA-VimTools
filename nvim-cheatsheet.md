# VIM

Some of these settings assume usage of vimrc profile created by `Coombszy/ansible-cheats` repo

### Normal Shortcuts
`i` - Insert before cursor
`a` - Append after cursor
`h` - Move left (By Default)
`l` - Move right (By Default)
`j` - Move down (By Default)
`k` - Move up (By Default)
`y` - Copy (Yank)
`p` - Paste
`d` - Cut (Delete)
`yy` - Copy line
`dd` - Cut Line
`.` - Repeat last insert/append action

## Window Shortcuts
`^ww` - Toggle windows
`^w + DIRECTION` - Move towards window 
`^w + v` - Vertical split
`^w + h` - Horizontal split

### Commands
`:s/foo/bar/` - the first occurrence of 'foo' in the current line and replace with 'bar'
`:s/foo/bar/g` - replace all occurrences of the search pattern in the current line
`:%s/foo/bar/g` - search and replace the pattern in the entire file
`:s/foo//g` - Delete all instances of 'foo'