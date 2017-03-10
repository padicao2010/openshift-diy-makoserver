<?lsp
    active = { home =  true }
    response:include(app.root .. ".header.lsp")
?>
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3>关于本站</h3>
                    <p>本站给有些许闲暇，喜爱《青城》的人提供的合作汉化《青城》的平台。日语达人，英语达人可以到<a href="<?lsp= app.root .. 'stringlist' ?>">文本列表</a>中进行游戏文本的翻译，志愿测试者可以到<a href="<?lsp= app.root .. 'contact' ?>">其他</a>页面下载测试补丁，帮助测试。本站尽量保证长时在线，但如果效果不好，经常受到攻击，或者《青城》汉化已出，则本站将关闭。</p>
                    <h3>网站使用注意</h3>
                    <ul>
                        <li>网站是小站，不参与汉化、测试的请尽量不要来给小站增加负担。</li>
                        <li>如果操作没有报错，那么就认定操作成功，请不要重复操作。</li>
                        
                        <li>不要宣传本站，毕竟是无版权的活动。</li>
                        <li>有建议请到其它页面留言。</li>
                    </ul>
                    <h3>翻译者注意</h3>
                    <ul>
                        <li>在<a href="<?lsp= app.root .. 'stringlist' ?>">文本列表</a>页面翻译文本。</li>
                        <li>可在<a href="<?lsp= app.root .. 'dictionary' ?>">用语词典</a>页面增加名词翻译，供自己或其他翻译者查看。</li>
                        <li>所做修改会不经审查直接接受，但所有修改都会记录下来，由站长抽时间逐条过滤。</li>
                        <li>翻译文本请尽量自己保存一份，以免万一。</li>
                        <li>目前有少数文本有不识别文字，可留言通知站长</li>
                        <li>游戏文本中，<mark>#cr0</mark>表示换行，<mark>#cXX</mark>表示给后边的文字带上色彩，<mark>#c00</mark>表示清空色彩。换行标记可以不用，颜色的标记请保留</li>
                    </ul>
                    <h3>测试者注意</h3>
                    <ul>
                        <li>网站每隔一段时间会生成现有翻译的可用补丁，注意看补丁的时间，避免重复下载。</li>
                        <li>若测试中发现少数文本乱码，可留言通知站长</li>
                    </ul>
                </div>
            </div>
        </div>
<?lsp
    response:include(app.root .. ".footer.lsp")
?>
