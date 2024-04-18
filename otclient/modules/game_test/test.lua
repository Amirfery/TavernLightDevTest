-- Initialize some parameter
local topOffset = 40; -- Offset from the top of the window
local botOffset = 10; -- Offset from the bottom of the window
local horizontalOffset = 10; -- Horizontal offset for button movement
local intervalTime = 20 -- Time interval for button movement
local moveSteps = 2 -- Number of steps to move the button at a time

local testWindow = nil; -- Variable to store the test window
local reset = false; -- Flag to indicate if button needs to be reset

-- Function to calculate the x position for resetting the button
local function getResetXPos()
    return testWindow:getX() + testWindow:getWidth() - horizontalOffset - startButton:getWidth()
end

-- Function to calculate the y position for resetting the button
local function getResetYPos()
    return math.random(testWindow:getY() + topOffset, testWindow:getY() + testWindow:getHeight() - botOffset - startButton:getHeight())
end

-- Function to move the button
local function moveButton()
    -- Check if the test window is active
    if testWindow:isOn() then
        -- Check if the button has reached the end of the frame
        if startButton:getX() <= testWindow:getX() + horizontalOffset then
            reset = true -- Set the reset flag to true
        end
        -- If reset flag is true, reset the button's position
        if reset then
            startButton:move(getResetXPos(), getResetYPos())
            reset = false -- Reset the flag
        end
        -- Move the button horizontally
        startButton:move(startButton:getX() - moveSteps, startButton:getY())
    end
end

-- Initialize function
function init()
    -- Create and display the test window
    testWindow = g_ui.displayUI('test', modules.game_interface.getRightPanel())
    testWindow:hide() -- Hide the window initially
    -- Add a toggle button to the top menu and assign toggle function to it
    testButton = modules.client_topmenu.addRightGameToggleButton('testButton', tr('test'), '/images/topbuttons/spelllist', toggle)
    -- Get the start button inside the test window which is defined in the test.otui file
    startButton = testWindow:getChildById('startButton')
    reset = true -- Set the reset flag to true initially
    startButton.onClick = turnOnReset -- Set onclick event for startButton
    cycleEvent(moveButton, intervalTime) -- Set up a repeating event to move the button
end

-- Toggle function to show/hide the test window
function toggle()
    if testWindow:isOn() then
        testButton:setOn(false) -- Turn off the toggle button
        testWindow:setOn(false) -- Deactivate the test window
        testWindow:hide() -- Hide the test window
    else
        testButton:setOn(true) -- Turn on the toggle button
        testWindow:setOn(true) -- Activate the test window
        testWindow:show() -- Show the test window
    end
end

-- Function to turn on the reset flag, its assigned to the Jump button so when it gets clicked reset the buttons position
function turnOnReset()
    reset = true -- Set the reset flag to true
end

-- Terminate function to clean up resources
function terminate()
    testWindow:destroy() -- Destroy the exit window
    testWindow = nil -- Clear the reference to the exit window
end
