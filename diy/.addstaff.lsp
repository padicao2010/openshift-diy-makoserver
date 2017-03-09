<?lsp
    active = { contact =  true }
    
    local data = request:data()
    
    local name = data.username
    local role = data.userrole
    
    if not name or #name == 0 then
        errorMsg = "无用户名。"
        response:forward(app.root .. ".error.lsp")
        return
    end
    
    if #name > 0x1000 then
        errorMsg = "用户名太长。"
        response:forward(app.root .. ".error.lsp")
        return
    end
    
    if role ~= "tester" and role ~= "translator" then
        errorMsg = "无效角色。"
        response:forward(app.root .. ".error.lsp")
        return
    end
    
    if app.staff[role][name] then
        errorMsg = "用户已经加入，或许需要使用新的用户名。"
        response:forward(app.root .. ".error.lsp")
        return
    end
    
    local outs = string.pack(string.format("<I2I2c%d", #name), 
        role == "translator" and 0 or 1,
        #name, name)
    local output = _G.io.open(string.format("%s/%s", app.DATADIR, app.STAFFFILE), "ab")
    output:write(outs)
    output:close()
    app.staff[role][name] = true

    response:sendredirect(app.root .. "contact")
?>
