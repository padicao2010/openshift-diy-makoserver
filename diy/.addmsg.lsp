<?lsp
    active = { contact =  true }
    
    local data = request:data()
    
    local msg = data.content
    
    if not msg or #msg == 0 then
        errorMsg = "无内容。"
        response:forward(app.root .. ".error.lsp")
        return
    end
    
    if #msg > 0x1000 then
        errorMsg = "内容太长。"
        response:forward(app.root .. ".error.lsp")
        return
    end
    
    local outs = string.pack(string.format("<I2c%d", #msg), #msg, msg)
    local output = _G.io.open(string.format("%s/%s", app.DATADIR, app.MSGFILE), "ab")
    output:write(outs)
    output:close()

    response:sendredirect(app.root .. "contact")
?>
