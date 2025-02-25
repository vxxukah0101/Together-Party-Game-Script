local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")

-- Function to teleport to a random door
local function teleportToRandomDoor(character)
    if character and character:FindFirstChild("HumanoidRootPart") then
        local level = workspace:FindFirstChild("Level")
        
        if level then
            local groups = {}
            for _, v in pairs(level:GetChildren()) do
                if v:IsA("Model") and v:FindFirstChild("Door") then
                    table.insert(groups, v)
                end
            end

            if #groups > 0 then
                local randomGroup = groups[math.random(1, #groups)]
                local door = randomGroup:FindFirstChild("Door")

                if door then
                    character.HumanoidRootPart.CFrame = door.CFrame
                end
            end
        end
    end
end

-- Function to handle key press input
local function onInputBegan(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.P and not gameProcessed then
        local character = player.Character or player.CharacterAdded:Wait()
        teleportToRandomDoor(character)
    end
end

-- Function to set up key press listener on character spawn
local function setupInputListener()
    userInputService.InputBegan:Connect(onInputBegan)
end

-- Bind the listener to when the player character spawns
player.CharacterAdded:Connect(function(character)
    setupInputListener()
end)

-- Initialize listener for the first time (in case the character is already loaded)
if player.Character then
    setupInputListener()
end
