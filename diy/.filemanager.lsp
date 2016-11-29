<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Translate Ren'Py Scripts</title>
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
                    <a class="navbar-brand" href="#">Translate Ren'Py Scripts</a>
                </div>
                <div class="collapse navbar-collapse bs-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="."><span class="glyphicon glyphicon-dashboard" aria-hidden="true"></span> Dashboard</a></li>
                        <li class="active"><a href="#"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> File Manager</a></li>
                        <li><a href="index.lsp?r=logout"><span class="glyphicon glyphicon-off" aria-hidden="true"></span> Logout</a></li>
                    </ul>
                </div>
                </div>
            </nav>
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3>You have <strong>0</strong> files</h3>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Filename</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
<?lsp
    for f in app.UPLOADIO:files() do
        if string.match(f, "%.rpy$") then
            response:write(string.format([[
                            <tr>
                                <td>%s</td>
                                <td>
                                    <div class="btn-group" role="group">
                    ]], f))
            if app.CURRENT and app.CURRENT.file == f then
                response:write([[
                                        <a role="button" class="btn btn-default" href="#">
                                            <span class="glyphicon glyphicon-fire" aria-hidden="true"></span> Actived
                                        </a>
                    ]])
            else
                response:write(string.format([[
                                      <a role="button" class="btn btn-default" href="index.lsp?r=active&file=%s">
                                            <span class="glyphicon glyphicon-fire" aria-hidden="true"></span> Active 
                                      </a>
                    ]], f))
             end
             response:write(string.format([[
                                      <a role="button" class="btn btn-default" href="index.lsp?r=download&file=%s" target="_blank">
                                            <span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> Download
                                       </a>
                                      <a role="button" class="btn btn-default" href="index.lsp?r=remove&file=%s">
                                             <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> Remove
                                      </a>
                                    </div>
                                </td>
                            </tr>
            ]], f, f))
        end
    end
?>
                        </tbody>
                    </table>
                </div>
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3>Upload a file</h3>
                    <form action="index.lsp?r=upload" method="post" enctype="multipart/form-data" >
                        <div class="form-group">
                            <input type="file" name="uploadfile">
                        </div>
                        <div class="form-group">
                            <button type="submit" id="ba_upload" class="btn btn-default">Upload</button>
                            <button type="reset" id="reset" class="btn btn-default">Reset</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/spark-md5.min.js"></script>
        <script src="assets/js/trpy.js"></script>
    </body>
</html>
