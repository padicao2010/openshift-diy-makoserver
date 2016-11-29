<?lsp
    local file = request:data().file
    if not file then
        response:sendredirect("index.lsp?r=filemanager")
        return
    end
    
    local cur = app.CURRENT
    if cur and cur.file == file then
        app.SAVE_FILE(app)
    end
    
    response:reset()
    response:setheader("Content-Type","text/plain")
    response:setheader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0")

    local f = app.UPLOADIO:open(file, "r")
    if f then
        local c = f:read()
        while c do
            response:write(c)
            c = f:read()
        end
        f:close()
    else
        response:write("No such file: " .. file)
    end
?>