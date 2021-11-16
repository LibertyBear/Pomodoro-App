
system.setIdleTimer( false )
local currentState = "REST"
local currentTime = 600
local timeWork = audio.loadSound( "ttwt.mp3" )
local timeRest = audio.loadSound( "ttrt.mp3" )

local currentStateText = display.newText("REST", 50, 20)
currentStateText.x, currentStateText.y = display.contentWidth/2, 100
currentStateText.size = 60
currentStateText:setFillColor(0,1,0)

local currentTimeText = display.newText("2:60", 50, 20)
currentTimeText.x, currentTimeText.y = display.contentWidth/2, 200
currentTimeText.size = 30

local timesWork = 0
local timesWorkText = display.newText("Full work times: 0", 50, 20)
timesWorkText.x, timesWorkText.y = display.contentWidth/2,300
timesWorkText.size = 15

function subtractSecond()
    timer.performWithDelay(1000, function() 
        currentTime = currentTime - 1 
        local minuteValue = math.floor(currentTime/60)
        local secondValue =math.floor(((math.floor(((currentTime/60) - minuteValue) * 100)) * 60) / 100)
        currentTimeText.text = (tostring(minuteValue) .. " : " .. tostring(secondValue))
        

        if (currentTime <= 0) then
            
            if (currentState == "REST") then
                currentState = "WORK"
                currentStateText.text = "WORK" currentStateText:setFillColor(1, 0, 0)
                currentTime = 1200
                local playWork = audio.play( timeWork, { channel=1, loops=0, fadein=50 } )

            else
                timesWork = timesWork + 1
                timesWorkText.text = ("Full work times: " .. tostring(timesWork))
                currentState = "REST"
                currentStateText.text = "REST" currentStateText:setFillColor(0, 1, 0)
                currentTime = 600
                local playRest = audio.play( timeRest, { channel=1, loops=0, fadein=50 } )
            end
        end
        subtractSecond()

    end)

end

subtractSecond()
