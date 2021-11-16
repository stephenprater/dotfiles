hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
        local serviceList = hs.execute("/usr/local/bin/brew services list")
        hs.notify.new({title="ChunkWM", informativeText="Toggling ChunkWM"}):send()
        for line in serviceList:gmatch("[^\r\n]+") do
                if string.find(line, "chunkwm[ ]+started") then
                        hs.execute("/usr/local/bin/brew services stop chunkwm")
                        hs.notify.new({title="ChunkWM", informativeText="ChunkWM stopped"}):send()
                        return
                elseif string.find(line, "chunkwm[ ]+stopped") then
                        hs.execute("/usr/local/bin/brew services start chunkwm")
                        hs.notify.new({title="ChunkWM", informativeText="ChunkWM started"}):send()
                        return
                end
        end
end)

function reloadConfig(files)
        doReload = false
        for _,file in pairs(files) do
                if file:sub(-4) == ".lua" then
                        doReload = true
                end
        end

        if doReload then
                hs.reload()
                hs.alert.show("Config reloaded")
        end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "./hammerspoon/", reloadConfig):start()

hs.hotkey.bind({"shift", "cmd"}, "left", function()
        local currentApp = hs.application.frontmostApplication()
        local kitabu = hs.application('Kitabu')
        kitabu:activate()
        hs.timer.doAfter(0.25, function()
                hs.eventtap.keyStroke({},"left")
                currentApp:activate()
        end)
end)

hs.hotkey.bind({"shift", "cmd"}, "right", function()
        local currentApp = hs.application.frontmostApplication()
        local kitabu = hs.application('Kitabu')
        kitabu:activate()
        hs.timer.doAfter(0.25, function()
                hs.eventtap.keyStroke({},"right")
                currentApp:activate()
        end)
end)
