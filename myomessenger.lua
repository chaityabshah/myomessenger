scriptId = 'com.chaityashah.rotation'
scriptTitle = "MyoMessenger"
scriptDetailsUrl = "" -- We don't have this until it's submitted to the Myo Market

centerYaw = 0
fist = false
inputMethod = -1 --1 = morse, 0 = rotary

function onForegroundWindowChange(app, title)
    return app == "chrome.exe" and title == "mm - Google Chrome"
end

function onPoseEdge(pose, edge)
	myo.unlock("hold")
    if(inputMethod == -1) then
        if(pose == "waveOut" and edge == "on") then
            inputMethod = 1
            myo.debug("morse!")
        end
        if (pose == "waveIn" and edge == "on") then
            inputMethod = 0
            myo.debug("rotary")
        end
    end
    if(inputMethod == 0) then
        if (pose == "fist" and edge == "on") then
    	   center()
            fist = true
        end
        if (pose == "fist" and edge == "off") then
    	   centerYaw = 0
            myo.keyboard("return", "press")
        end

        if (pose == "waveOut" and edge == "on") then
            myo.keyboard("left_control", "down", "win")
            myo.keyboard("l", "press")
            myo.keyboard("left_control", "up", "win")
            myo.keyboard("tab", "press")
            myo.keyboard("tab", "press")
            myo.keyboard("tab", "press")
            myo.keyboard("return", "press")
        end

    end
    if(inputMethod == 1) then
        if (pose == "fist" and edge == "on") then
            startTime = myo.getTimeMilliseconds()
        end
        if (pose == "fist" and edge == "off") then
            stopTime = myo.getTimeMilliseconds()
            if (startTime+1000 > stopTime) then
                myo.keyboard("period", "press")
            else
                myo.keyboard("minus", "press")
            end
        end
        if (pose == "fingersSpread" and edge == "on") then
            myo.keyboard("space", "press")
        end
        if (pose == "waveOut" and edge == "on") then
            myo.keyboard("tab", "press")
            myo.keyboard("return", "press")
            myo.keyboard("return", "press")
        end
    end
end

function center()
	myo.debug("Centered")
	centerYaw = myo.getYaw()
end

function onPeriodic()
    if (fist == true) then
	    testYaw = myo.getYaw()
	    deltaYaw = testYaw - centerYaw
	    if(deltaYaw ~= testYaw) then
	        myo.debug(deltaYaw)
            if(deltaYaw > .5) then
                myo.keyboard("tab", "press")
            end
            if(deltaYaw < -.25) then
                myo.keyboard("tab", "press", "shift")
            end
	   end
    end
end

function activeAppName()
end

function onActiveChange(isActive)
end