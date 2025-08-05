-- !!! This file is not how you configure the mod !!!
-- Config files are generated after loading the mod for the first time
-- at AbioticFactor/Binaries/Win64/ResourceMultiplier_###.toml
-- (restart the game to apply changes)

---@diagnostic disable: redefined-local

local config = require("config")

config.load()

-- If true, pressing F5 will respawn all depleted resource nodes, and F6 will make NPC spawners have no cooldown (for debugging)
-- WARNING: this is meant for debugging and may cause memory leaks and other side effects which may lead to crashes
local debugKeybinds = false

local ignoreHook = false

local entitiesReadyToGib = {}

ExecuteInGameThread(function ()
    LoadAsset("/Game/Blueprints/Environment/Nodes/ResourceNode_ParentBP.ResourceNode_ParentBP_C")

    RegisterHook("/Game/Blueprints/Environment/Nodes/ResourceNode_ParentBP.ResourceNode_ParentBP_C:DropLoot", function(this, TryToPlaceInInventory, inventoryOwner, IsNotReceivingDamage)
        if ignoreHook then
            return
        end

        local this = this:get()
        local TryToPlaceInInventory, inventoryOwner, IsNotReceivingDamage = TryToPlaceInInventory:get(), inventoryOwner:get(), IsNotReceivingDamage:get()

        local key = this.SalvageDropRow.RowName:ToString()
        local mult = config.node_multiplier(key)
        print("[ResourceMultiplier] Multiplying ResourceNode drops: \"" .. key .. "\" (" .. mult .. "x)\n")

        Duplicate(mult - 1.0, function()
            this:DropLoot(TryToPlaceInInventory, inventoryOwner, IsNotReceivingDamage)
        end)
    end)

    LoadAsset("/Game/Blueprints/Characters/NPCs/NPC_Base_ParentBP.NPC_Base_ParentBP_C")

    RegisterHook("/Game/Blueprints/Characters/NPCs/NPC_Base_ParentBP.NPC_Base_ParentBP_C:DropLoot", function(this)
        if ignoreHook then
            return
        end

        local this = this:get()

        entitiesReadyToGib[this:GetFName():ToString()] = true

        local key = this.NPCDataTableRow.RowName:ToString()
        local mult = config.drop_multiplier(key)
        print("[ResourceMultiplier] Multiplying NPC drops: \"" .. key .. "\" (" .. mult .. "x)\n")

        Duplicate(mult - 1.0, function()
            this:DropLoot()
        end)
    end)

    RegisterHook("/Game/Blueprints/Characters/NPCs/NPC_Base_ParentBP.NPC_Base_ParentBP_C:TryGibbingNPC", function(this, DamageType, Attacker, ForceOnlyScrap, ForceGibNPC)
        if ignoreHook then
            return
        end

        local this = this:get()

        if entitiesReadyToGib[this:GetFName():ToString()] == nil then
            return
        end

        local DamageType, Attacker, ForceOnlyScrap, ForceGibNPC = DamageType:get(), Attacker:get(), ForceOnlyScrap:get(), ForceGibNPC:get()
        if this.IsGibbed and DamageType.CanGib then
            entitiesReadyToGib[this:GetFName():ToString()] = nil

            local key = this.NPCDataTableRow.RowName:ToString()
            local mult = config.corpse_multiplier(key)
            print("[ResourceMultiplier] Multiplying corpse drops: \"" .. key .. "\" (" .. mult .. "x)\n")

            Duplicate(mult - 1.0, function()
                if this.IsGibbed then
                    this.IsGibbed = false
                    this:TryGibbingNPC(DamageType, Attacker, ForceOnlyScrap, true)
                end
            end)
        end
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
                node:ToggleSpawnDebug(true)
            end
        end
    end)
end

print("[ResourceMultiplier] Mod loaded\n")