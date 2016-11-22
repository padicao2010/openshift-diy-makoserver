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
                    <li><a href="index.lsp?r=wallet"><span class="glyphicon glyphicon-briefcase" aria-hidden="true"></span> Wallets</a></li>
                    <li><a href="index.lsp?r=entry"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Entries</a></li>
                    <li class="active"><a href="#"><span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span> Transfers</a></li>
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
    local data = request:data()
    filterFrom = app.PFM.getFilterNumber(data.filterfrom)
    filterTo = app.PFM.getFilterNumber(data.filterto)
    filterStr = ""
    if filterFrom > 0 then
        filterStr = string.format("&filterfrom=%d", filterFrom)
    end
    if filterTo > 0 then
        filterStr = string.format("%s&filterto=%d", filterStr, filterTo)
    end
    
    local sqenv, sqcon = app.PFM.openDB(app)
    transferCount = app.PFM.getTransferCount(sqcon, filterFrom, filterTo)
    local cur = assert(sqcon:execute(string.format([[
SELECT COUNT(*) FROM pfm_transfer %s;
    ]], where)));
    pageIndex, pageCount, transferOffset = app.PFM.getPageInfo(
                request:data().page, app.PERPAGE, transferCount)
    transfers = app.PFM.getTransfers(sqcon, filterFrom, filterTo, transferOffset, app.PERPAGE)
    app.PFM.closeDB(sqenv, sqcon)
?>
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2">
                    <h3>Your have <strong><?lsp= transferCount ?></strong> Transfers <a 
                            class="btn btn-default" href="index.lsp?r=addtransfer" role="button"
                            ><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></a></h3>
                     <form class="form-inline text-right" action="index.lsp" method="get">
                        <div class="form-group">
                            <input type="hidden" name="r" value="transfer">
                            <label for="filterfrom">From</label>
                            <select class="form-control" id="filterfrom" name="filterfrom">
<?lsp
    local selectedStr = [[selected = "selected"]]
    print(string.format([[<option value="0"%s>ALL</option>]], filterFrom == 0 and selectedStr or ""))
    for id, name in pairs(app.WALLETS) do
        print(string.format([[<option value="%d"%s>%s</option>]], id, filterFrom == tonumber(id) and  selectedStr or "", name))
    end
?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="filterto">To</label>
                            <select class="form-control" id="filterto" name="filterto">
<?lsp
    local selectedStr = [[selected = "selected"]]
    print(string.format([[<option value="0"%s>ALL</option>]], filterTo == 0 and selectedStr or ""))
    for id, name in pairs(app.WALLETS) do
        print(string.format([[<option value="%d"%s>%s</option>]], id, filterTo == tonumber(id) and  selectedStr or "", name))
    end
?>
                            </select>
                        </div>
                        <div class="form-group">
                            <button type="submit" id="ba_filterentry" class="btn btn-inverse">Filter</button>
                        </div>
                    </form>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>From</th>
                                <th>To</th>
                                <th>When</th>
                                <th>For</th>
                                <th>Money</th>
                            </tr>
                        </thead>
                        <tbody>
<?lsp
    for i, t in ipairs(transfers) do
        print("<tr>")
        print(string.format("<td>%s</td>", app.WALLETS[t.source]))
        print(string.format("<td>%s</td>", app.WALLETS[t.dest]))
        print(string.format("<td>%s</td>", os.date("%Y-%m-%d", t.time)))
        print(string.format("<td>%s</td>", t.aim or ""))
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
        response:write(string.format([[<li><a href="index.lsp?r=transfer&page=%d%s"><span>&laquo</span></a></li>]],  
            prevPage, filterStr))
    end
    response:write(string.format([[<li><a href="#"><span>%d / %d</span></a></li>]],
            pageIndex, pageCount))
    if nextPage then
        response:write(string.format([[<li><a href="index.lsp?r=transfer&page=%d%s"><span>&raquo</span></a></li>]], 
            nextPage, filterStr))
    end
?>
                    </ul>
                  </nav>
                </div>
            </div>
        </div>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
    </body>
</html>
