" Copyright 2023 Sunny Blake-Webber, All Rights Reserved.


"	MESA-TOOLS AUTO VIM (UNREAL SPECIFIC) CONFIGURATION

"-----------------------------------------------------------
"	REQUIRED PLUGINS
"-----------------------------------------------------------

" Give init vim required plugins - e.g vimspector for debugging.
let g:modular_plugins += [
\	'mfussenegger/nvim-dap'
\]

"-----------------------------------------------------------
"	REQUIRED UNREAL ENGINE FUNCTIONALITY
"-----------------------------------------------------------

let g:unrealterm = 0
let g:unrealterm_win = 0
let g:unrealterm_bufnr = 0
let g:unrealterm_cmptimer_id = 0
let g:unrealterm_compiling = 0

"	LOCATE DIRECTORIES

function! LocateProject()
	let g:unrealproject = glob('*.uproject')
endfunction

function! LocateEditor()
	let g:unrealeditor = glob('UnrealEditor*.exe')
endfunction

"	TERMINAL FUNCTIONALITY

function! OpenUnrealTerm()
	botright new
	exec "resize " . 25
	let g:unrealterm = termopen('powershell.exe', {"detach": 0})
	let g:unrealterm_win = win_getid()
	let g:unrealterm_bufnr = bufnr('%')
	call chansend(g:unrealterm, '& "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat"' . "\<CR>")
	set nonumber
	set norelativenumber
	set signcolumn=no
	sleep 100m
endfunction

function! FocusUnrealTerm()
	if !win_gotoid(g:unrealterm_win)
		call OpenUnrealTerm()
	endif
endfunction

function! ClearUnrealTerm()
	call chansend(g:unrealterm, 'cls' . "\<CR>")
endfunction

"	PROJECT ACTIONS

function! RegenerateProject()
	call FocusUnrealTerm()
	call chansend(g:unrealterm, '& "C:\Program Files (x86)\Epic Games\Launcher\Engine\Binaries\Win64\UnrealVersionSelector.exe" /projectfiles "$(Get-Location)\Eden.uproject"' . "\<CR>")
endfunction

function! BuildProject()

	if g:unrealterm_compiling == 0
		call FocusUnrealTerm()
		call ClearUnrealTerm()
		call chansend(g:unrealterm, '& "D:\UE_5.2\Engine\Build\BatchFiles\Build.bat" -Target="EdenEditor Win64 DebugGame -Project="E:\Desktop\Mesa\MESA-Client\Eden.uproject" -WaitMutex -FromMsBuild"' . "\<CR>")
		normal! G
		let g:unrealterm_cmptimer_id = timer_start(100, 'CheckCompileStatus', {'repeat': -1})
		let g:unrealterm_compiling = 1
	endif
endfunction

function! CheckCompileStatus(timer)

	let lines = getbufline(g:unrealterm_bufnr, 1, '$')
	for line in lines
		if line =~ "Total execution time:"
			echom "Finished Compiling."
			call timer_stop(g:unrealterm_cmptimer_id)
			let g:unrealterm_cmptimer_id = 1
			let g:unrealterm_compiling = 0
			"call StartVS()
			"call VSSetConfig()
			call VSRun()
			break
		else
			echom "Compiling Unreal Project."
		endif
	endfor
endfunction

" Begin debugging project in current directory
function! StartDebugging()
	call BuildProject()
	"call StartVS()
endfunction

"	VS 2022

function! StartVS()
	" Check if VS is already running, if not, launch it!
	let l:tasklist = system('tasklist /FI "IMAGENAME eq devenv.exe"')
	if matchstr(l:tasklist, 'No tasks are running which match the specified criteria.') != ""
		call FocusUnrealTerm()
		call chansend(g:unrealterm, '& "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe" "E:\Desktop\Mesa\MESA-Client\Eden.sln"' . "\<CR>")
		echom "Launching Visual Studio 2022."
	else
		echom "Trigger debugging for running Visual Studio 2022."
		call chansend(g:unrealterm, 'devenv /debugexe Test.exe' . "\<CR>")
	endif
endfunction

function! VSRun()
	call FocusUnrealTerm()
	call chansend(g:unrealterm, '& "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe" /run "E:\Desktop\Mesa\MESA-Client\Eden.sln" "DebugGame Editor|Win64" /project "Eden" /projectConfig "DebugGame_Editor|x64"' . "\<CR>")
endfunction

function! VSSetConfig()
	call FocusUnrealTerm()
	"call chansend(g:unrealterm, '& "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe" "D:\badlads\BadLads.sln" "DebugGame Editor"' . "\<CR>")
endfunction

"	VS CODE

let g:compilecmds = 0
function! GetCompileCommands()
	if !isdirectory('.vscode')
		echo "No vscode workspace found, generating one."
		call RegenerateProject()
	endif

	let g:compilecmds = '/.vscode/compileCommands_Default.json'
	if filereadable(g:compilecmds)
		call StartDebugging()
	endif
endfunction

"-----------------------------------------------------------
"	C++ CONVENIENCE
"-----------------------------------------------------------

function! ToggleHeaderSource()
	let l:ext = expand("%:e)
	let l:new_ext = l:ext ==

	if l:curr_file_ext == 'cpp'

		" Open headers on the right
	elseif l:curr_file_ext == 'h'

		" Open source on the left
	endif

endfunction

"-----------------------------------------------------------
"	KEYBINDING
"-----------------------------------------------------------

noremap <F2> :call RegenerateProject()<CR>
noremap <F5> :call StartDebugging()<CR>
noremap <A-o> :call ToggleHeaderSource()<CR>

"-----------------------------------------------------------
"	INIT VIM FOR UNREAL
"-----------------------------------------------------------

"call GetCompileCommands()
