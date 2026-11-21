setlocal shiftwidth=8
setlocal tabstop=8
setlocal softtabstop=0
setlocal noexpandtab
setlocal cinoptions=(0,W16

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ . '|setlocal shiftwidth< tabstop< softtabstop< expandtab< cinoptions<'
