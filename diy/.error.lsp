<?lsp
    errorMsg = errorMsg or "无错误。"
    response:include(app.root .. ".header.lsp")
?>
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3>错误发生</h3>
                    <hr />
                    <p class="text-danger"><?lsp= errorMsg ?></p>
                </div>
            </div>
        </div>
<?lsp
    response:include(app.root .. ".footer.lsp")
?>
