local UTCClock = {}

ClockMenuItem = hs.menubar.new()
EpochMenuItem = hs.menubar.new()

local function setClockDisplay()
    local time = os.date("!%H:%M:%S")
    if ClockMenuItem then
        ClockMenuItem:setTitle(time)
    end
end

local function setEpochDisplay()
    local time = os.time()
    if EpochMenuItem then
        EpochMenuItem:setTitle(time)
    end
end

function UTCClock:start()
    _UTCClockTimer = hs.timer.doEvery(1, setClockDisplay)
    _EpochClockTimer = hs.timer.doEvery(1, setEpochDisplay)
end

local function onClockClicked()
    local convertButton = "Convert"
    local cancelButton = "Cancel"
    local button, input = hs.dialog.textPrompt(
        "hello world",
        "info text",
        "default text",
        convertButton,
        cancelButton)
    if button == convertButton then
        input = tonumber(input)
        if input then
            local utctime = os.date("!%c", input)
            local localtime = os.date("%c", input)
            hs.dialog.alert(1, 1, nil,
                "UTC time: " .. utctime .. "\nLocal time: " .. localtime
            )
        end
    end
end

local function onEpochClicked()
    hs.pasteboard.setContents(os.time())
end

ClockMenuItem:setClickCallback(onClockClicked)
EpochMenuItem:setClickCallback(onEpochClicked)

return UTCClock
