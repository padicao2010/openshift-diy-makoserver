<?lsp
    active = { contact =  true }
    
    response:include(app.root .. ".header.lsp")
?>
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3>诚信为本，志愿为主，加入名单……</h3>
                    <form action="<?lsp= app.root .. 'addstaff' ?>">
                      <div class="form-group">
                        <label for="username">用户昵称</label>
                        <input class="form-control" name="username" id="username" placeholder="名字">
                      </div>
                      <div class="form-group">
                        <label for="userrole">用户角色</label>
                        <select class="form-control" id="userrole" name="userrole">
                            <option value="translator">翻译者</option>
                        </select>
                      </div>
                      <button type="submit" class="btn btn-primary">志愿加入</button>
                      <a role="button" class="btn" href="<?lsp= app.root .. "stafflist" ?>">查看名单列表</a>
                    </form>
                    <hr />
                </div>
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3>留下信息、建议、批评给站长看……</h3>
                    <form action="<?lsp= app.root .. 'addmsg' ?>" method='post'>
                        <textarea class="form-control" name="content" rows="10" placeholder="（建议少于1000字）"></textarea>
                        <button type="submit" class="btn btn-primary">提交</button>
                    </form>
                </div>
            </div>
        <div>
<?lsp
    response:include(app.root .. ".footer.lsp")
?>
