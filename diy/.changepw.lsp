<?lsp
    local data = request:data()
    local u = data.username
    local curPW = data.curPassword
    local newPW = data.newPassword
    
    local status
    local sqenv, sqcon = app.PFM.openDB(app)
    if app.PFM.checkPassword(sqcon, u, curPW) then
        app.PFM.changePassword(sqcon, u, newPW)
        request:logout(true)
        status = true
    else
        status = false
    end
    app.PFM.closeDB(sqenv, sqcon)
    response:json({status=status})
?>
