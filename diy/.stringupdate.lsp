<?lsp
    active = { stringlist =  true }
    if request:method() ~= "POST" then
        errorMsg = "只支持 POST。"
        response:forward(app.root .. ".error.lsp")
        return
    end
    
    local data = request:data()
    
    local fileIndex = tonumber(data.fileindex or 0)
    if not fileIndex or fileIndex <= 0 or fileIndex > #(app.stringtable) then
        errorMsg = "文件编号参数错误: " .. tostring(fileIndex)
        response:forward(app.root .. ".error.lsp")
        return
    end
    local strs = app.stringtable[fileIndex]
    
    local stringIndex = tonumber(data.lineindex or 0)
    if not stringIndex or stringIndex <=0 or stringIndex > #strs then
        errorMsg = "行编号错误：" .. tostring(stringIndex)
        response:forward(app.root .. ".error.lsp")
        return
    end
    
    local index = stringIndex
    local output, err
    while true do
        local key = "line" .. index
        local s = data[key]
        if not s then
            break
        end
        
        local trgts = strs[index]
        if trgts[#trgts] ~= s then
            local outs = string.pack(string.format("<I2I2I2c%d", #s), fileIndex, index, #s, s)
            if not output then
                output, err = _G.io.open(string.format("%s/%s", app.DATADIR, app.LOGFILE), "a")
                if not output then
                    errorMsg = "打开文件错误：" .. err
                    response:forward(app.root .. ".error.lsp")
                    return
                end
            end
            assert(output:write(outs))
            app.numUpdateStr = app.numUpdateStr + 1
            trgts[#trgts] = s
            if not trgts.translated then
                _G.print("Translated " .. index)
                trgts.translated = true
                strs.translated = strs.translated + 1
            else
                _G.print("Update " .. index)
            end
        end
        index = index + 1
    end
    if output then
        output:close()
    end
    
    local pageIndex = math.ceil(stringIndex / app.STRINGSPERPAGE)
    response:sendredirect(string.format("%sstringfile/%d/%d", app.root, fileIndex, pageIndex))
?>
