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
                    <a class="navbar-brand" href=".">Personal Finance Manager</a>
                </div>
                <div class="collapse navbar-collapse bs-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="."><span class="glyphicon glyphicon-dashboard" aria-hidden="true"></span> Dashboard</a></li>
                        <li><a href="index.lsp?r=wallet"><span class="glyphicon glyphicon-briefcase" aria-hidden="true"></span> Wallets</a></li>
                        <li><a href="index.lsp?r=entry"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Entries</a></li>
                        <li><a href="index.lsp?r=transfer"><span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span> Transfers</a></li>
                        <li><a href="#"><span class="glyphicon glyphicon-stats" aria-hidden="true"></span> Analysis</a>
                        <li class="dropdown active">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Yvan Hom <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li class="active"><a href="#"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span> Settings</a></li>
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
                    <form>
                        <div class="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                            <h3 class="text-center">Change Password</h3>
                            <div class="form-group">
                                <label for="curPassword2">Current Password</label>
                                <input type="password" class="form-control" id="curPassword2" placeholder="Password">
                            </div>
                            <div class="form-group">
                                <label for="newPassword2">New Password</label>
                                <input type="password" class="form-control" id="newPassword2" placeholder="Password">
                            </div>
                            <div class="form-group">
                                <label for="againPassword">Password Again</label>
                                <input type="password" class="form-control" id="againPassword" placeholder="Password">
                            </div>
                            <input type="hidden" name="curPassword">
                            <input type="hidden" name="newPassword">
                            <input type="hidden" name="username" value="<?lsp=request:user() ?>">
                            <input type="hidden" name="realm" value="<?lsp= app.REALM ?>">
                            <p class="text-warning" id="ba_info"><?lsp= ba_info or "" ?></p>
                            <div class="form-group">
                                <button type="submit" id="ba_changepw" class="btn btn-default">Update</button>
                            </div>
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
