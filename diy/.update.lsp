<?lsp
    local cur = app.CURRENT
    
    if not cur then
        response:sendredirect("index.lsp?r=filemanager")
        return
    end
    
    local data = request:data()
    local maxno = 0
    cur.diff = cur.diff or {}   
    for k, v in pairs(data) do
        local line = string.match(k, "line(%d+)")
        if line then
            line = tonumber(line)
            maxno = math.max(line, maxno)
            cur[line] = string.gsub(cur[line], '"(.*)"', '"' .. v .. '"')
            table.insert(cur.diff, {line = line, text = v})
        end
    end

    app.SAVE_DIFF(app)
    
    if #(cur.diff) >=10 then
        app.SAVE_FILE(app)
    end
    
    if data.gonext == "1" then
        response:sendredirect(string.format("index.lsp?linenumber=%d", maxno + 1))
    else
        response:sendredirect(string.format("index.lsp?linenumber=%d", cur.line))
    end
?>
