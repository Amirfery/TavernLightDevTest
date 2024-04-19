-- Function to remove a specific member from a player's party
function removeMemberFromPlayerPartyByName(playerId, memberName)
    -- Retrieve the player object based on the player ID
    local player = Player(playerId) 
    -- print an Error if the player id is wrong
    if not player then
        print("Error: Invalid player ID.")
        return false
    end
    -- Retrieve the party object that the player belongs to
    local party = player:getParty() 
    
    -- Iterate through each member of the party
    for _, member in pairs(party:getMembers()) do
        -- Check if the name of the current member matches the specified memberName
        if member:getName() == memberName then
            -- Remove the matching member from the party
            party:removeMember(member)
        end 
    end 
    return true
end

-- This function is used to remove a member from a specific player's party by the member's name