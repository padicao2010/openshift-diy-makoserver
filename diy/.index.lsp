<?lsp
    active = { home =  true }
    response:include(app.root .. ".header.lsp")
?>
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3>进度：共 <?lsp= app.numAllStr ?> 行，
                    已翻译 <?lsp= app.numTranslatedStr ?> 行，
                    更新但未合并 <?lsp= app.numUpdateStr ?> 行
                    </h3>
                </div>
            </div>
        </div>
<?lsp
    response:include(app.root .. ".footer.lsp")
?>
