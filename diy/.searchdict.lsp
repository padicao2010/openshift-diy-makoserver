<?lsp
    active = { dictionary =  true }

    local data = request:data()
    dictPattern = data.dictpattern
    
    if not dictPattern or #dictPattern == 0 then
        errorMsg = "没有源词。"
        response:forward(app.root .. ".error.lsp")
        return
    end
    
    ts = {}
    matchCount = 0
    for k, v in pairs(app.dictMap) do
        if string.find(k, dictPattern) then
            ts[k] = v
            matchCount = matchCount + 1
        end
    end

    
    response:include(app.root .. ".header.lsp")
?>
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3>模式："<?lsp= dictPattern ?>"</h3>
                    <hr />
                    <?lsp response:include(app.root .. ".dictform.lsp") ?>
                    <hr />
                    <p>共找到 <?lsp= matchCount ?> 个词</p>
                    <table class="table">
                        <tr>
                            <th>源词</th>
                            <th>译词</th>
                        </tr>
<?lsp
    for k, v in pairs(ts) do
?>
                        <tr>
                            <td><?lsp= k ?></td>
                            <td><?lsp= v ?></td>
                        </tr>
<?lsp
    end
?>
                    </table>
                    
                </div>
            </div>
        </div>
<?lsp
    response:include(app.root .. ".footer.lsp")
?>
