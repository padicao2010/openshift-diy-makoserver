<?lsp
    local data = request:data()
    if data.r and app.REDIRECT_URIS[data.r] then
        response:forward(app.REDIRECT_URIS[data.r])
    else
        response:forward(".index.lsp")
    end
?>
