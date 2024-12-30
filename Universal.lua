local Plr = game:GetService("Players").LocalPlayer
local PlotObjects = workspace.Plots:WaitForChild("Plot_" .. "" .. Plr.Name):WaitForChild("House"):WaitForChild("Objects"):GetChildren()
local WaitTime = 2.6

local RemoteName = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("DataService"):GetChildren()[1].Name
local Remote = False

local function FindRemote(Item, args)
    local newFound = False
    for _, Folder in pairs(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("DataService"):GetChildren()) do
        --print("Folder: "..tostring(Folder))
        if Folder:IsA("Folder") and Folder.Name == RemoteName then
            --print("Ok Folder: "..tostring(Folder))
            for _, v in pairs(Folder:GetChildren()) do
                --print("Remote: "..tostring(v))
                if v:IsA("RemoteEvent") and v.Name == RemoteName then
                    --print("Ok Remote: "..tostring(v))
                    v:FireServer(unpack(args))
                    wait(0.5)
                    --print(tostring(#Item:GetChildren()).."|"..tostring(Item:FindFirstChild("_attachOccupied")))
                    if Item:FindFirstChild("_attachOccupied") ~= nil or #Item:GetChildren() == 3 then
                        Remote = v
                        print("Remote found...")
                        newFound = True
                        break
                    else
                        newFound = False
                   end
                end
                print(tostring(newFound))
            end
        end
        wait(0.01)
        print(tostring(newFound))
        if newFound then
            print("Remote found, exiting loop.")
            break
        end
    end
    print("Checked all...")
end

for _, Obj in pairs(PlotObjects) do
    if Obj.Name == "Large Ordinary Planter" then
        local ItemHolder = Obj:FindFirstChild("ItemHolder")
        if ItemHolder then
            for _, Item in pairs(ItemHolder:GetChildren()) do
                if Item.Name == "Berry Bush" and #Item.ObjectData:GetChildren() <= 0 then
                    Plr.Character.HumanoidRootPart.CFrame = Obj.CFrame + Vector3.new(0, 5.5, 0)
                    local args = {
                        [1] = {
                            ["Target"] = Item,
                            ["Path"] = "6"
                        }
                    }
                    if Remote then
                        print("Using saved remote.")
                        Remote:FireServer(unpack(args))
                        wait(0.5)
                        if Item:FindFirstChild("_attachOccupied") == nil then
                            print("Saved remote didn't work, finding remote...")
                            FindRemote(Item, args)
                        end
                    else
                        print("No saved remote, finding remote...")
                        FindRemote(Item, args)
                    end
                    wait(WaitTime)
                end
           end
        end
    end
end
