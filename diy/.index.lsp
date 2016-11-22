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
                        <li class="active"><a href="#"><span class="glyphicon glyphicon-dashboard" aria-hidden="true"></span> Dashboard</a></li>
                        <li><a href="index.lsp?r=wallet"><span class="glyphicon glyphicon-briefcase" aria-hidden="true"></span> Wallets</a></li>
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
                <div class="col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2">
<?lsp
    local su = require "sqlutil"
    local sqenv, sqcon = su.open(app.DBFILE)
    local cur = assert(sqcon:execute([[
SELECT money FROM pfm_wallet WHERE id=1;
    ]]))
    income = -tonumber(cur:fetch() or 0)
    cur = assert(sqcon:execute([[
SELECT SUM(money) FROM pfm_wallet WHERE id!=1;
    ]]))
    remain = tonumber(cur:fetch() or 0)
    cur = assert(sqcon:execute([[
SELECT SUM(money) FROM pfm_entry;
    ]]))
    outcome = tonumber(cur:fetch() or 0)

    cur = assert(sqcon:execute([[
SELECT * FROM pfm_month
ORDER BY year, month;
    ]]))
    local y, m, inc, out, rem = cur:fetch()
    months = {}
    while y do
        y, m, inc, out, rem = cur:fetch()
        table.insert(months, {year = y, month = m, income = inc, outcome = out, remain = rem })
    end
    su.close(sqenv, sqcon)
?>
                    <h2>Summary</h2>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th></th>
                                <th>Last Month</th>
                                <th>Current Month<th>
                                <th>Summary<th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th>Income</th>
                                <td></td>
                                <td></td>
                                <td><?lsp= income ?></td>
                            </tr>
                            <tr>
                                <th>Outcome</th>
                                <td></td>
                                <td></td>
                                <td><?lsp= outcome ?></td>
                            </tr>
                            <tr>
                                <th>Remain</th>
                                <td></td>
                                <td></td>
                                <td><?lsp= remain ?></td>
                            </tr>
                        <tbody>
                    </table>
                </div>
            </div>
        </div>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/spark-md5.min.js"></script>
        <script src="assets/js/pfm.js"></script>
    </body>
</html>
