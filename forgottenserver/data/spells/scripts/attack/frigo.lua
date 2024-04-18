-- Create a new combat object
local combat = Combat()

-- Set the combat parameter to represent ice damage
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)

-- Define the area in which the spell will affect
local area = {
	{0, 0, 0, 1, 0, 0, 0},
	{0, 0, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 0, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 0, 0},
	{0, 0, 0, 1, 0, 0, 0}
}
-- Set the combat area based on the defined area
combat:setArea(createCombatArea(area))

-- Define a function to calculate the minimum and maximum damage values
function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50
	return -min, -max
end

-- Set the callback for level and magic value calculation
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

-- Create a function to calcualte the middle row index of the area table
local function calculateCenterPos()
    local manualCount = 0
    for _ in pairs(area) do
        manualCount = manualCount + 1
    end
    return math.floor(manualCount / 2 + 1)
end

-- Define a function to execute when the spell casts
function onCastSpell(creature, variant)
    -- Get the position of caster
    local position = creature:getPosition()
    -- Make a for to cast spell in 3 iterations
	for k = 1, 3 do
        -- Make an event to set the delay of 1 second between each spell cast iteration
		addEvent(function()
            -- Loop through each row and column of the defined area
			for i, row in ipairs(area) do
				for j, value in ipairs(row) do
                    -- If the value in the area is 1, create the spell effect with a random delay between 0.1 and 0.5 seconds
					if value == 1 then
						addEvent(doSendMagicEffect, math.random(100, 500), {x = position.x - (j - calculateCenterPos()), y = position.y - (i - calculateCenterPos()), z = position.z}, CONST_ME_ICETORNADO)
					end
				end
			end
		end, (k - 1) * 1000) -- Introduce a delay between each iteration of the spell casting
	end	
    -- Execute the combat with the provided creature and variant
    return combat:execute(creature, variant)
end
