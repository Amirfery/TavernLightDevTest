-- Function to print names of guilds with less than a specified maximum member count
function printSmallGuildNames(memberCount)
    -- Prepare the SQL query to select guild names with less than the specified max member count
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    
    -- Execute the SQL query with the provided memberCount parameter
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    
    -- Check if the query execution was successful
    if resultId ~= false then
        -- Iterate over each row in the result set
        repeat
            -- Fetch the guild name from the current row
            local guildName = result.getString("name")
            
            -- Print the guild name
            print(guildName)
        until not result.next(resultId)
        
        -- Free the result set
        result.free(resultId)
    end 
end

-- In the previous script there was no iteration on the results rows and it won't print all the guild names
