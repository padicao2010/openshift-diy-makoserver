<?lsp
    if pfm then
        pfm.hello()
    end
    if app.pfm then
        app.pfm.hello()
    end
redirectURI = { 
    ["logout"] = ".logout.lsp",
    ["settings"] = ".settings.lsp",
    ["changepw"] = ".changepw.lsp",
    ["wallet"] = ".wallet.lsp",
    ["addwallet"] = ".addwallet.lsp",
    ["entry"] = ".entry.lsp",
    ["addentry"] = ".addentry.lsp",
    ["transfer"] = ".transfer.lsp",
    ["addtransfer"] = ".addtransfer.lsp",
}
    local data = request:data()
    if data.r then
        response:forward(redirectURI[data.r])
    else
        response:forward(".index.lsp")
    end
?>
