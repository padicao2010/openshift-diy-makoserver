<?lsp
    local file = request:data().file
    if file == nil or file == "" then
        response:sendredirect("index.lsp?r=filemanager")
        return
    end
    local cur = app.CURRENT
    if cur.file == file then
        cur = nil
        app.CURRENT = nil
    end
    app.WORKIO:remove(file)
    app.UPLOADIO:remove(file)
    
    response:sendredirect("index.lsp?r=filemanager")
?>