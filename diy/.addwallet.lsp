<?lsp
    if request:method() == "POST" then
        local data = request:data()
        local name = data.walletName
        local money = tonumber(data.walletMoney or 0)
        if name ~= nil and name ~= "" then
            local sqenv, sqcon = app.PFM.openDB(app)
            local flag = app.PFM.addWallet(sqcon, name, money)
            if flag then
                app.WALLETS = app.PFM.updateCache(app, sqcon)
            else
                ba_info = name .. " already exists!"
            end
            app.PFM.closeDB(sqenv, sqcon)
            if flag then
                response:sendredirect("index.lsp?r=wallet&page=-1")
                return
            end
        else
            ba_info = "Name must no be empty!"
        end
    end
?>
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
                    <li class="active"><a href="index.lsp?r=wallet"><span class="glyphicon glyphicon-briefcase" aria-hidden="true"></span> Wallets</a></li>
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
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                    <form method="post">
                        <h3 class="text-center">Add a new wallet</h3>
                        <div class="form-group">
                            <label for="walletName">Name</label>
                            <input type="text" class="form-control" id="walletName" name="walletName" placeholder="wallet">
                        </div>
                        <div class="form-group">
                            <label for="walletMoney">Money</label>
                            <input type="number" class="form-control" id="walletMoney"  name="walletMoney" value="0" step="0.01">
                        </div>
                        <p class="text-warning" id="ba_info"><?lsp= ba_info or "" ?></p>
                        <div class="form-group">
                            <button type="submit" id="ba_addwallet" class="btn btn-default">Add</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/spark-md5.min.js"></script>
        <script src="assets/js/pfm.js"></script>
    </body>
</html>
