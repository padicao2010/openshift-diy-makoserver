<?lsp
    active = { dictionary =  true }
    
    local data = request:data()
    
    local k = data.keyword
    local v = data.valueword
    
    if not k or #k == 0 then
        errorMsg = "无源词。"
        response:forward(app.root .. ".error.lsp")
        return
    end
    
    if #k > 0x1000 then
        errorMsg = "源词太长。"
        response:forward(app.root .. ".error.lsp")
        return
    end
    
    if not v or #v == 0 then
        errorMsg = "无译词。"
        response:forward(app.root .. ".error.lsp")
        return
    end
    
    if #v > 0x1000 then
        errorMsg = "译词太长。"
        response:forward(app.root .. ".error.lsp")
        return
    end
    
    local outs = string.pack(string.format("<I2I2c%dc%d", #k, #v), #k, #v, k, v)
    local output = _G.io.open(string.format("%s/%s", app.DATADIR, app.DICTFILE), "ab")
    output:write(outs)
    output:close()
    
    if not app.dictMap[k] then
        app.dictCount = app.dictCount + 1
    end
    app.dictMap[k] = v

    response:sendredirect(app.root .. "dictionary")
?>
