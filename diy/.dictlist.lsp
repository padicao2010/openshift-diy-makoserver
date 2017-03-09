<?lsp
    active = { dictionary =  true }
    response:include(app.root .. ".header.lsp")
    dictMap = app.dictMap
    dictCount = app.dictCount
?>
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3> 共记录 <?lsp= dictCount ?> 词
                    </h3>
                    <hr />
                    <?lsp response:include(app.root .. ".dictform.lsp") ?>
                    <hr />
                    <table class="table">
                        <tr>
                            <th>源词</th>
                            <th>译词</th>
                        </tr>
<?lsp
    for k, v in pairs(dictMap) do
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
