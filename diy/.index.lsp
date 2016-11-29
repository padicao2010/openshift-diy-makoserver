<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Translate Ren'Py Scripts</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/css/highlight.min.css" rel="stylesheet">
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
                        <li class="active"><a href="#"><span class="glyphicon glyphicon-dashboard" aria-hidden="true"></span> Dashboard</a></li>
                        <li><a href="index.lsp?r=filemanager"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> File Manager</a></li>
                        <li><a href="index.lsp?r=logout"><span class="glyphicon glyphicon-off" aria-hidden="true"></span> Logout</a></li>
                    </ul>
                </div>
                </div>
            </nav>
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
<?lsp
    cur = app.CURRENT
    if not cur then
        response:write("<h3>No active file!</h3>")
    else
        local startline = tonumber(request:data().linenumber or cur.line or 1)
        if startline == -1 then
            for i, s in ipairs(cur) do
                if string.find(s, '""') and (not string.find(s, "^%s*#")) and (not string.find(s, "^%s*old")) then
                    startline = i - 5
                    break
                end
            end
            if startline < 0 then
                startline = 1
            end
        end
        cur.line = startline
        local totalline = #(cur)
        if startline < 1 or startline > totalline then
            startline = 1
        end
        local function getTargetLine(sl)
            while true do
                if sl > totalline then
                    return nil
                end
                local s = cur[sl]
                if string.find(s, '".*"') and (not string.find(s, "^%s*#")) and (not string.find(s, "^%s*old")) then
                    return sl
                end
                sl = sl + 1
            end
        end

        local sl = startline
        contents = {}
        hasNext = true
        for i = 1, 5 do
            local targetline = getTargetLine(sl)
            if not targetline then
                hasNext = false
                break;
            end
            local stext = string.match(cur[targetline], '"(.*)"')
            table.insert(contents, { start=sl, tail = targetline, text = stext })
            sl = targetline + 1
        end
        hasContent = #contents > 0
        if hasNext then
            nextLine = contents[#contents].tail + 1
        end

        response:write(string.format([[
                <form class="form-inline text-right">
                    <a role="button" class="btn btn-primary" href="index.lsp?linenumber=-1">Jump to EMPTY</a>
                    <input type="number" class="form-control" name="linenumber" value="%d">
                    <button type="submit" class="btn btn-primary">Jump to LINE</button>
                ]], nextLine or 1))
         response:write([[
                </form>
                ]])
    end
?>
                <form action='index.lsp?r=update' method='post'>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Line</th>
                                <th>Content</th>
                            </tr>
                        </thead>
                        <tbody>
<?lsp
    if hasContent then
        for i, c in ipairs(contents) do
            response:write(string.format([[
                                <tr>
                                    <td>%d</td>
                                    <td><pre style="word-break: normal;"><code class="python">]], c.start))
            for j = c.start, c.tail do
               print(cur[j])
            end
            response:write(string.format([[</pre></code>
                                        <textarea class="form-control" name="line%d">%s</textarea>
                                    </td>
                                </tr>
                    ]], c.tail, c.text))
        end
    
        response:write(string.format([[
                            <tr>
                                <td></td>
                                <td class="text-right">
                                  <input type="hidden" name="gonext" value=%d>
                                  <button type="submit" class="btn btn-primary">%s</button>
                                </td>
                            </tr>
                ]], hasNext and 1 or 0, hasNext and "Update and Next" or "Update"))
     end
?>
                        </tbody>
                    </table>
                </form>
                </div>
            </div>
        </div>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/spark-md5.min.js"></script>
        <script src="assets/js/trpy.js"></script>
        <script src="assets/js/highlight.min.js"></script>
        <script>hljs.initHighlightingOnLoad();</script>
    </body>
</html>
