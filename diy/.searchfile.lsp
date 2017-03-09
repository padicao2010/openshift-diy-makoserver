<?lsp
    active = { stringlist =  true }

    local data = request:data()
    filePattern = data.filepattern
    
    if not filePattern or #filePattern == 0 then
        errorMsg = "没有匹配字符串"
        response:forward(app.root .. ".error.lsp")
        return
    end
    
    ts = {}
    matchCount = 0
    for i, strs in ipairs(app.stringtable) do
        if string.find(strs.path, filePattern) then
            ts[i] = strs
            matchCount = matchCount + 1
        end
    end

    
    response:include(app.root .. ".header.lsp")
?>
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3>模式："<?lsp= filePattern ?>"</h3>
                    <hr />
                    <form action="<?lsp= app.root .. 'searchfile'?>" class="form-inline">
                        <input type="text" class="form-control" name="filepattern" placeholder="Example: a1_root">
                        <button type="submit" class="btn btn-default">查找</button>
                    </form>
                    <hr />
                    <p>共找到 <?lsp= matchCount ?> 文件</p>

<?lsp
    for i, strs in pairs(ts) do
?>
                    <div class="list-group">
                      <a href="<?lsp= string.format('%sstringfile/%d', app.root, i) ?>" class="list-group-item">
                        <h4 class="list-group-item-heading">
                            <?lsp= i?>.
                            <?lsp= strs.parent ?> 
                            <strong class="text-primary">/</strong> 
                            <?lsp= strs.path ?>
                            <strong class="text-primary">:</strong> 
                            <small>共 <strong class="text-success"><?lsp= #strs ?></strong> 行，
                            已翻译 <strong class="text-success"><?lsp= strs.translated ?></strong> 行</small>
                        </h4>
                        <p>
                            <?lsp= strs.desc or "无描述" ?>
                        </p>
                      </a>
                    </div>
<?lsp
    end
?>
                    
                </div>
            </div>
        </div>
<?lsp
    response:include(app.root .. ".footer.lsp")
?>
