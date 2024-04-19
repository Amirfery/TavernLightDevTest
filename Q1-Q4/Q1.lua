-- Function to release the storage value for a player
local function releaseStorage(player)
    -- Set the storage value with key 1000 to -1 for the specified player
    player:setStorageValue(1000, -1)
end

-- Function called when a player logs out
function onLogout(player)
    -- Check if the player has a specific storage value (1000) equal to 1
    if player:getStorageValue(1000) == 1 then
        -- Call the releaseStorage function to reset the storage value
        releaseStorage(player)
    end
    -- Return true to indicate that the logout event was handled successfully
    return true
end

-- In the previous script the value of storage was changed after 1 second 
-- and this delay is unnecessary and would cause major bugs
