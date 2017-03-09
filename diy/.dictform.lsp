                    <form action="<?lsp= app.root .. 'searchdict'?>" class="form-inline">
                        <input type="text" class="form-control" name="dictpattern" placeholder="源词">
                        <button type="submit" class="btn btn-default">查找</button>
                        <a role="button" class="btn" href="<?lsp= app.root .. "dictlist" ?>">查看列表</a>
                    </form>
                    <hr />
                    <form action="<?lsp= app.root .. 'adddict'?>" class="form-inline">
                        <input type="text" class="form-control" name="keyword" placeholder="源词"> 
                        译为
                        <input type="text" class="form-control" name="valueword" placeholder="译词">
                        <button type="submit" class="btn btn-default">修改或增加</button>
                    </form>
