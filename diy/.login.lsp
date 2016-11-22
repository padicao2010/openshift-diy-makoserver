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
                    <a class="navbar-brand" href="#">Personal Finance Manager</a>
                </div>
            </div>
        </nav>
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                    <form method="post">
                        <h3 class="text-center">Login to access</h3>
                        <div class="form-group">
                            <label for="inputEmail">Email address</label>
                            <input type="email" class="form-control" id="inputEmail" name="ba_username" placeholder="Email">
                        </div>
                        <div class="form-group">
                            <label for="ba_password2">Password</label>
                            <input type="password" class="form-control" id="ba_password2"  placeholder="Password">
                        </div>
                        <input type="hidden" name="ba_password">
                        <input type="hidden" name="ba_realm" value="<?lsp= app.REALM ?>">
                        <input type="hidden" name="ba_seed" value="<?lsp= authinfo.seed ?>">
                        <input type="hidden" name="ba_seedkey" value="<?lsp= authinfo.seedkey ?>">
                        <p class="text-warning" id="ba_info"><?lsp= ba_info or "" ?></p>
                        <div class="form-group">
                            <button type="submit" id="ba_loginbut" class="btn btn-default">Login</button>
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
