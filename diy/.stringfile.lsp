<?lsp
    active = { stringlist =  true }

    fileIndex = 1
    if queries[2] then
        fileIndex = tonumber(queries[2])
        if not fileIndex or fileIndex <=0 or fileIndex > #(app.stringtable) then
            if not fileIndex then
                errorMsg = string.format("无效文件编号 '%s'。", queries[2])
            else
                errorMsg = string.format("文件编号 '%d' 不在范围之内 [%d, %d]。", fileIndex, 1, #(app.stringtable))
            end
            response:forward(app.root .. ".error.lsp")
            return
        end
    end
    strs = app.stringtable[fileIndex]
    
    pageIndex = 1
    stringCount = #(strs)
    perPage = app.STRINGSPERPAGE
    if queries[3] then
        pageIndex = tonumber(queries[3])
        if pageIndex == -1 then
            if strs.translated == #strs then
                errorMsg = "所有行都已翻译，无法跳转。"
                response:forward(app.root .. ".error.lsp")
                return
            end
            for i = 1, #strs do
                if not strs[i].translated then
                    pageIndex = math.ceil(i / perPage);
                    break
                end
            end
        end
        if not pageIndex or pageIndex <=0 or pageIndex > stringCount then
            if not pageIndex then
                errorMsg = string.format("无效页号 '%s'。", queries[3])
            else
                errorMsg = string.format("页号 '%d' 不在范围之内 [%d, %d]。", pageIndex, 1, stringCount)
            end
            response:forward(app.root .. ".error.lsp")
            return
        end
    end

    pageCount = math.ceil(stringCount / perPage)
    pageUrl = string.format("%sstringfile/%d", app.root, fileIndex)
    
    stringFrom = pageIndex * perPage - perPage + 1
    stringTo = math.min(stringCount, pageIndex * perPage)
    
    response:include(app.root .. ".header.lsp")
?>
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3>
                        <?lsp= strs.parent ?> 
                        <strong class="text-primary">/</strong> 
                        <?lsp= strs.path ?>
                    </h3>
                    <p>
                    （总共 <?lsp= stringCount ?> 行，已翻译 <?lsp= strs.translated ?> 行，共 <?lsp= pageCount ?> 页，第 <?lsp= pageIndex ?> 页）
                    </p>
                    <p>
                        <?lsp= strs.desc or "无描述" ?>
                    <hr />
                    <form action="<?lsp= app.root .. 'stringupdate' ?>" method='post'>
<?lsp
    for i = stringFrom, stringTo do
        local s = strs[i]
?>
                        <ul class="list-group">
                            <li class="list-group-item">
                                <?lsp= i ?>:
                                <?lsp= s.desc or "无描述" ?>
                                <mark><?lsp= s.translated and "已翻译" or "未翻译" ?></mark> 
                            </li>
                            <li class="list-group-item">原：<mark class="bg-danger"><?lsp= s[1] ?></mark></li>
<?lsp
    if #s == 3 then
?>
                            <li class="list-group-item">英：<mark class="bg-danger"><?lsp=  s[2] ?></mark></li>
<?lsp
    end
?>
                            <li class="list-group-item"><textarea class="form-control" name="line<?lsp= i ?>"><?lsp= s[#s] ?></textarea></li>
                        </ul>
<?lsp
    end
?>
<td class="text-right">
                        <input type="hidden" name="fileindex" value="<?lsp= fileIndex ?>">
                        <input type="hidden" name="lineindex" value="<?lsp= stringFrom ?>">
                        <div class="btn-group" role="group">
                            <a role="button" class="btn" href="<?lsp= string.format("%sstringfile/%d/-1", app.root, fileIndex) ?>">跳转到未翻译行</a>
                            <button type="submit" class="btn btn-primary">提交更改</button>
                         </div>
                    </form>

<?lsp 
    response:include(app.root .. ".pages.lsp")
?>
                    
                </div>
            </div>
        </div>
<?lsp
    response:include(app.root .. ".footer.lsp")
?>
