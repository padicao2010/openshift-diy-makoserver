<?lsp
    local function uploadStart(_ENV, up)
    end
    
    local function uploadCompleted(_ENV, up)
        local response = up:response()
        response:setstatus(302)
        response:setheader("Location", "index.lsp?r=filemanager")
        response:setcontentlength(0)
        response:close()
    end
    
    local function uploadFailed(_ENV, up, error, extra)
        local response = up:response()
        response:setStatus(302)
        response:setheader("Location", "index.lsp?r=filemanager")
        response:setcontentlength(0)
        response:close()
    end
    
    app.UPLOADER(request, tostring(os.time()) .. "-", uploadStart, uploadCompleted, uploadFailed)
?>
