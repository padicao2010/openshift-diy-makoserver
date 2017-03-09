<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>捭阖翻翻翻 之 青城</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="/assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="shortcut icon" href="/assets/imgs/favicon.ico">
    </head>
    <body>
        <nav class="navbar navbar-default navbar-static-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".bs-navbar-collapse-1">
                        <span class="sr-only">捭阖翻翻翻 之 青城</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">捭阖翻翻翻 之 <strong>青城</strong></a>
                </div>
                <div class="collapse navbar-collapse bs-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li <?lsp= active.home and 'class="active"' or '' ?>><a href="<?lsp= app.root ?>"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> 首页</a></li>
                        <li <?lsp= active.stringlist and 'class="active"' or '' ?>><a href="<?lsp= app.root .. 'stringlist' ?>"><span class="glyphicon glyphicon-dashboard" aria-hidden="true"></span> 文本列表</a></li>
                        <li <?lsp= active.dictionary and 'class="active"' or '' ?>><a href="<?lsp= app.root .. 'dictionary'?>"><span class="glyphicon glyphicon-dashboard" aria-hidden="true"></span> 用语词典</a></li>
                        <li <?lsp= active.notice and 'class="active"' or '' ?>><a href="<?lsp= app.root .. 'notice' ?>"><span class="glyphicon glyphicon-dashboard" aria-hidden="true"></span> 注意事项</a></li>
                        <li <?lsp= active.contact and 'class="active"' or '' ?>><a href="<?lsp= app.root .. 'contact' ?>"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> 其它</a></li>
                    </ul>
                </div>
            </div>
        </nav>
