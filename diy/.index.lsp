<?lsp
    active = { home =  true }
    response:include(app.root .. ".header.lsp")
?>
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <img src="/assets/imgs/a<?lsp= math.random(5) ?>.jpg" class="img-responsive" alt="青城CG图" />
                    <h3 class="text-center">
                        <a href="https://tr.fanfanfan.online/project/p3/files">开始吧……</a>
                    </h3>
                </div>
            </div>
        </div>
<?lsp
    response:include(app.root .. ".footer.lsp")
?>
