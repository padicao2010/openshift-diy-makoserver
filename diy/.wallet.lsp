<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Personal Finance Manager</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="shortcut icon" href="assets/imgs/favicon.ico">
    </head>
    <body>
        <nav class="navbar navbar-default navbar-static-top" role="navigation">
            <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".bs-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">Personal Finance Manager</a>
            </div>
            <div class="collapse navbar-collapse bs-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="."><span class="glyphicon glyphicon-dashboard" aria-hidden="true"></span> Dashboard</a></li>
                    <li class="active"><a href="#"><span class="glyphicon glyphicon-briefcase" aria-hidden="true"></span> Wallets</a></li>
                    <li><a href="index.lsp?r=entry"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Entries</a></li>
                    <li><a href="index.lsp?r=transfer"><span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span> Transfers</a></li>
                    <li><a href="#"><span class="glyphicon glyphicon-stats" aria-hidden="true"></span> Analysis</a>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Yvan Hom <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="index.lsp?r=settings"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span> Settings</a></li>
                            <li><a href="index.lsp?r=logout"><span class="glyphicon glyphicon-off" aria-hidden="true"></span> Log Out</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            </div>
        </nav>
<?lsp
    local sqenv, sqcon = app.PFM.openDB(app)
    
    walletCount = app.PFM.getWalletCount(sqcon)
    pageIndex, pageCount, walletOffset = app.PFM.getPageInfo(
                request:data().page, app.PERPAGE, walletCount)
                
    wallets = app.PFM.getWallets(sqcon, walletOffset, app.PERPAGE)
    
    app.PFM.closeDB(sqenv, sqcon)
?>
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2">
                    <h3>Your have <strong><?lsp= walletCount ?></strong> Wallets <a 
                            class="btn btn-default" href="index.lsp?r=addwallet" role="button"
                            ><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></a></h3>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Money</th>
                            </tr>
                        </thead>
                        <tbody>
<?lsp
    for i, t in ipairs(wallets) do
        print("<tr>")
        print(string.format("<td>%s</td>", t.name))
        print(string.format("<td>%.2f</td>", t.money))
        print("</tr>")
    end
?>
                        </tbody>
                    </table>
                    <nav>
                      <ul class="pagination">
<?lsp
    local prevPage = (pageIndex > 1) and pageIndex - 1
    local nextPage = (pageIndex < pageCount) and pageIndex + 1
    if prevPage then
        response:write(string.format([[<li><a href="index.lsp?r=wallet&page=%d"><span>&laquo</span></a></li>]],  
            prevPage))
    end
    response:write(string.format([[<li><a href="#"><span>%d / %d</span></a></li>]],
            pageIndex, pageCount))
    if nextPage then
        response:write(string.format([[<li><a href="index.lsp?r=wallet&page=%d"><span>&raquo</span></a></li>]], 
            nextPage))
    end
?>
                    </ul>
                  </nav>
                </div>
            </div>
        </div>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/spark-md5.min.js"></script>
        <script src="assets/js/pfm.js"></script>
    </body>
</html>
