<?lsp
    active = { notice =  true }
    response:include(app.root .. ".header.lsp")
?>
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <h3>关于本站</h3>
                    <ul>
                        <li> 本站给有些许闲暇、喜爱《青城》的人提供的汉化合作服务。欢迎语言达人们到<a href="<?lsp= app.root .. 'stringlist' ?>">文本列表</a>中进行游戏文本的翻译、润色。有事告知站长，可以到<a href="<?lsp= app.root .. 'contact' ?>">其它</a>页面留言。如果有想汉化的游戏，需要程序支持，也可以留言，能帮忙，站长会尽力而为。</li>
                        <li> 本站尽量保证长时在线，但如果效果不好，或是常常受到攻击，或是已有给力组织接手汉化《青城》，则本站遗憾地难以存活。</li>
                    </ul>
                    <h3>网站使用注意</h3>
                    <ul>
                        <li>网站是小站，不参与汉化的请尽量不要来给小站增加负担。</li>
                        <li>如果操作没有报错，那么就认定操作成功，请不要重复操作。</li>
                        <li>不要宣传本站，毕竟是无版权的活动。</li>
                        <li>有建议请到其它页面留言。</li>
                        <li>在<a href="<?lsp= app.root .. 'stringlist' ?>">文本列表</a>页面翻译文本。</li>
                        <li>在<a href="<?lsp= app.root .. 'dictionary' ?>">用语词典</a>页面增加名词翻译，供自己或其他翻译者查看。</li>
                        <li>所做修改会不经审查直接接受，但所有修改都会记录下来，有可能会对这些修改进行筛选。</li>
                        <li>翻译文本请尽量自己保存一份，以免万一。</li>
                        <li>目前有少数文本包含不识别文字，可留言告知站长。</li>
                        <li>游戏文本中，<mark>#cr0</mark>表示换行，<mark>#cXX</mark>表示给后边的文字带上色彩，<mark>#c00</mark>表示清空色彩。换行标记可以不用，颜色的标记请保留。</li>
                        <li>翻译尽量简短，至少要比原文短，这样可以给程序员减负很多工作。</li>
                        <li>翻译进行到某些进度后，网站会放出测试补丁。</li>
                    </ul>
                    <h3>网站后续计划</h3>
                    <ul>
                        <li>加入需要翻译的图片资源。</li>
                        <li>补全缺失的文本</li>
                    </ul>
                </div>
            </div>
        </div>
<?lsp
    response:include(app.root .. ".footer.lsp")
?>
