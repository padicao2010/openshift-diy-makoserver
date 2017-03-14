<?lsp
    active = { stringlist = true }

    pageIndex = 1
    fileCount = #(app.stringtable)
    perPage = app.FILESPERPAGE
    pageCount = math.ceil(fileCount / perPage)
    pageUrl = app.root .. "stringlist"
    
    if queries[2] then
        pageIndex = tonumber(queries[2])
        if pageIndex and pageIndex == -1 then
            for i, strs in ipairs(app.stringtable) do
                if strs[4] < (#strs - 5) then
                    for j = 6, #strs do
                        if strs[j][2] == 0 then
                            response:sendredirect(string.format("%sstringfile/%d/-1", app.root, i))
                            return
                        end
                    end
                end
            end
            errorMsg = "所有文件已翻译，无法跳转。"
            response:forward(app.root .. ".error.lsp")
            return
        end
        if not pageIndex or pageIndex <=0 or pageIndex > pageCount then
            if not pageIndex then
                errorMsg = string.format("无效页号 '%s'。", queries[2])
            else
                errorMsg = string.format("页号 '%d' 不在范围之内 [%d, %d]。", pageIndex, 1, pageCount)
            end
            response:forward(app.root .. ".error.lsp")
            return
        end
    end
    fileFrom = pageIndex * perPage - perPage + 1
    fileTo = math.min(fileCount, pageIndex * perPage)
    
    response:include(app.root .. ".header.lsp")
?>
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3>文件列表（总共 <?lsp= fileCount ?> 文件，共 <?lsp= pageCount ?> 页，第 <?lsp= pageIndex ?> 页）</h3>
                    <hr />
                    
                    <form action="<?lsp= app.root .. 'searchfile'?>" class="form-inline">
                        <input type="text" class="form-control" name="filepattern" placeholder="Example: a1_root">
                        <button type="submit" class="btn btn-default">查找</button>
                        <a role="button" class="btn" href="<?lsp= string.format("%sstringlist/-1", app.root) ?>">直达未翻译的文件</a>
                    </form>
                    <hr />
<?lsp
    for i = fileFrom, fileTo do
        file = app.stringtable[i]
?>
                    <div class="list-group">
                      <a href="<?lsp= string.format('%sstringfile/%d', app.root, i) ?>" class="list-group-item">
                        <h4 class="list-group-item-heading">
                            <?lsp= i ?>.
                            <?lsp= file[1] ?> 
                            <strong class="text-primary">/</strong> 
                            <?lsp= file[2] ?>
                            <strong class="text-primary">:</strong> 
                            <small>共 <strong class="text-success"><?lsp= #file - 5 ?></strong> 行，
                            已翻译 <strong class="text-success"><?lsp= file[4] ?></strong> 行</small>
                        </h4>
                        <p>
                            <?lsp= file[3] or "无描述" ?>
                        </p>
                      </a>
                    </div>
<?lsp
    end
?>

                    <nav aria-label="...">
                      <ul class="pager">
                        <li <?lsp= pageIndex<=1 and "class='disabled'" or "" ?>><a <?lsp= pageIndex > 1 and string.format("href='%s/%d'", pageUrl, pageIndex - 1) or "" ?>>上一页</a></li>
                        <li <?lsp= pageIndex>=pageCount and "class='disabled'" or "" ?>><a <?lsp= pageIndex < pageCount and string.format("href='%s/%d'", pageUrl, pageIndex + 1) or "" ?>>下一页</a></li>
                      </ul>
                    </nav>
                    
                </div>
            </div>
        </div>
<?lsp
    response:include(app.root .. ".footer.lsp")
?>
