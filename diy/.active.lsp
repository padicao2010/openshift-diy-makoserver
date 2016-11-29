<?lsp
    local data = request:data()
    local file = data.file
    
    local cur = app.CURRENT
    if cur then
        if cur.file == file then
            response:sendredirect(".")
            return;
        else
            app.SAVE_FILE(app)
            cur = nil
        end
    end
    
    cur = { file = file, line = 1 }
    app.CURRENT = cur
    app.LOAD_FILE(app)
    app.LOAD_DIFF(app)
        
    response:sendredirect(".")
?>