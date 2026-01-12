local UTCClock = {
  enableClock = true,
  enableEpoch = true
}

ClockMenuItem = hs.menubar.new()
EpochMenuItem = hs.menubar.new()

local function setClockDisplay()
  local time = os.date('!%H:%M:%S')
  if ClockMenuItem then
    ClockMenuItem:setTitle(time .. ' UTC')
  end
end

local function setEpochDisplay()
  local time = os.time()
  if EpochMenuItem then
    EpochMenuItem:setTitle(time)
  end
end

local function onClockClicked()
  local convertButton = 'Convert'
  local cancelButton = 'Cancel'
  local button, input = hs.dialog.textPrompt(
    'Translate Unix Timestamp',
    '',
    '',
    convertButton,
    cancelButton)
  if button == convertButton then
    input = tonumber(input)
    if input then
      local utctime = os.date('!%c', input)
      local localtime = os.date('%c', input)
      hs.dialog.alert(1, 1, nil,
        'UTC time: ' .. utctime .. '\nLocal time: ' .. localtime
      )
    end
  end
end

local function onEpochClicked()
  hs.pasteboard.setContents(os.time())
  hs.alert('Copied timestamp to clipboard', { textSize = 19, }, hs.screen.mainScreen(), 1)
end

function UTCClock:start()
  if UTCClock.enableClock then
    _UTCClockTimer = hs.timer.doEvery(0.1, setClockDisplay)
    ClockMenuItem:setClickCallback(onClockClicked)
  else
    ClockMenuItem:removeFromMenuBar()
  end
  if UTCClock.enableEpoch then
    _EpochClockTimer = hs.timer.doEvery(0.1, setEpochDisplay)
    EpochMenuItem:setClickCallback(onEpochClicked)
  else
    EpochMenuItem:removeFromMenuBar()
  end
end

return UTCClock
