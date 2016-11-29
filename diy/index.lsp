<?lsp
    local rs = app.REDIRECT_URLS
    local data = request:data()
    if data.r and rs[data.r] then
        response:forward(rs[data.r])
    else
        response:forward(".index.lsp")
    end
?>
