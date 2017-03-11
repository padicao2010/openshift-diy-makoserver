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
                            <option value="tester">测试者</option>
                        </select>
                      </div>
                      <button type="submit" class="btn btn-primary">志愿加入</button>
                      <a role="button" class="btn" href="<?lsp= app.root .. "stafflist" ?>">查看名单列表</a>
                    </form>
                    <hr />
                </div>
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3>下载</h3>
                    <p>下载补丁文件，解压，然后复制文件夹里的内容到游戏目录，会有文件的覆盖（SCRIPT 目录下的 SCRIPT.AFS，EXE_CEL.AFS 和 FONT.AFS），没有覆盖，说明操作有问题。用日语还原补丁覆盖，则恢复原版；用汉化测试补丁覆盖，则可测试汉化补丁；用英化补丁覆盖，则可运行英文版。</p>
                    <p>注意，英文补丁跟以前的版本的不同，只是修改了字体文件，换了种字体而已。</p>
                    <ul>
                        <li>日语还原补丁：</li>
                        <li>汉化测试补丁：</li>
                        <li>英化补丁：</li>
                    </ul>
                    <hr />
                </div>
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3>网站下阶段改进</h3>
                    <ul>
                        <li>加入游戏的图片资源。</li>
                    </ul>
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
