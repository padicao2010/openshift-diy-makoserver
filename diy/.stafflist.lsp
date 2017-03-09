<?lsp
    active = { contact =  true }
    response:include(app.root .. ".header.lsp")
    staff = app.staff
?>
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3>翻译者</h3>
                    <p>
<?lsp
    for n, _ in pairs(staff.translator) do
?>
                        <span class="glyphicon glyphicon-user"></span><?lsp= n ?>
<?lsp
    end
?>
                    </p>
                    <h3>测试者</h3>
<?lsp
    for n, _ in pairs(staff.tester) do
?>
                        <span class="glyphicon glyphicon-user"></span><?lsp= n ?>
<?lsp
    end
?>
                </div>
            </div>
        </div>
<?lsp
    response:include(app.root .. ".footer.lsp")
?>
