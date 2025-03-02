
-- If you're looking to configure the mod, you should edit the config files
-- located in AbioticFactor/Binaries/Win64/ResourceMultiplier_###.toml

local config = require("config")

config.load()

-- If true, pressing F5 will respawn all depleted resource nodes, and F6 will make NPC spawners have no cooldown (for debugging)
-- WARNING: this is meant for debugging and may cause memory leaks and other side effects which may lead to crashes
local debugKeybinds = false

local ignoreHook = false

ExecuteInGameThread(function ()
    LoadAsset("/Game/Blueprints/Environment/Nodes/ResourceNode_ParentBP.ResourceNode_ParentBP_C")

    RegisterHook("/Game/Blueprints/Environment/Nodes/ResourceNode_ParentBP.ResourceNode_ParentBP_C:DropLoot", function(this, a, b, c)
        if ignoreHook then
            return
        end

        local this = this:get()
        local a,b,c = a:get(),b:get(),c:get()

        local key = this.SalvageDropRow.RowName:ToString()
        local mult = config.node_multiplier(key)
        print("[ResourceMultiplier] Multiplying ResourceNode drops: \"" .. key .. "\" (" .. mult .. "x)\n")

        Duplicate(mult - 1.0, function()
            this:DropLoot(a, b, c)
        end)
    end)

    LoadAsset("/Game/Blueprints/Characters/NPCs/NPC_Base_ParentBP.NPC_Base_ParentBP_C")

    RegisterHook("/Game/Blueprints/Characters/NPCs/NPC_Base_ParentBP.NPC_Base_ParentBP_C:DropLoot", function(this)
        if ignoreHook then
            return
        end

        local this = this:get()

        local key = this.NPCDataTableRow.RowName:ToString()
        local mult = config.drop_multiplier(key)
        print("[ResourceMultiplier] Multiplying NPC drops: \"" .. key .. "\" (" .. mult .. "x)\n")

        Duplicate(mult - 1.0, function()
            this:DropLoot()
        end)
    end)

    RegisterHook("/Game/Blueprints/Characters/NPCs/NPC_Base_ParentBP.NPC_Base_ParentBP_C:TryGibbingNPC", function(this, a, b, c, d)
        if ignoreHook then
            return
        end

        local this = this:get()
        local a,b,c,d = a:get(),b:get(),c:get(),d:get()

        local key = this.NPCDataTableRow.RowName:ToString()
        local mult = config.corpse_multiplier(key)
        print("[ResourceMultiplier] Multiplying corpse drops: \"" .. key .. "\" (" .. mult .. "x)\n")

        Duplicate(mult - 1.0, function()
            if this.IsGibbed then
                this.IsGibbed = false
                this:TryGibbingNPC(a, b, c, true)
            end
        end)
    end)
end)

function Duplicate(chance, fn)
    if math.random() < chance then
        -- for some reason without this delay it sometimes doesn't work
        ExecuteWithDelay(20, function()
            ExecuteInGameThread(function()
                ignoreHook = true
                fn()
                ignoreHook = false
                Duplicate(chance - 1.0, fn)
            end)
        end)
    end
end

if debugKeybinds then
    RegisterKeyBind(Key.F5, function()
        local nodes = FindAllOf("ResourceNode_ParentBP_C")
        if not nodes then
            print("[ResourceMultiplier] No 'ResourceNode_ParentBP_C's found\n")
        else
            for i, node in pairs(nodes) do
                if node.IsDepleted then
                    print(string.format("[ResourceMultiplier] Respawning [%d] %s\n", i, node:GetFullName()))
                    node:RespawnResourceNode()
                end
            end
        end
    end)
    RegisterKeyBind(Key.F6, function()
        local nodes = FindAllOf("Abiotic_NPCSpawn_ParentBP_C")
        if not nodes then
            print("[ResourceMultiplier] No 'Abiotic_NPCSpawn_ParentBP_C's found\n")
        else
            for i, node in pairs(nodes) do
                print(string.format("[ResourceMultiplier] Respawning [%d] %s\n", i, node:GetFullName()))

                node.SpawnCooldown_Default = 0.0
                node.SpawnCooldownDays_Default = 0
                node:SetSpawnOnCooldown(0.0, 0)
                node:DebugSpawn()
            end
        end
    end)
end

print("[ResourceMultiplier] Mod loaded\n")