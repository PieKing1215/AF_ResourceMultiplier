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
    -- resource nodes

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

    -- NPC drops

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

    -- corpse drops

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

    -- fishing

    LoadAsset("/Game/Blueprints/Items/Weapons/Guns/Weapon_FishingRod.Weapon_FishingRod_C")
    LoadAsset("/Game/Blueprints/Libraries/AbioticFunctionLibrary.AbioticFunctionLibrary_C")

    -- fishing junk multiplication disabled for now due to ue4ss limitations (impossible to pass FDataTableRowHandle to function)

    -- RegisterHook("/Game/Blueprints/Items/Weapons/Guns/Weapon_FishingRod.Weapon_FishingRod_C:Server_GrantJunkReward", function(this, Player, Reward)
    --     if ignoreHook then
    --         return
    --     end

    --     local this = this:get()
    --     local Player, Reward = Player:get(), Reward:get()

    --     print(this:GetFullName()) -- Weapon_FishingRod_C /Game/Maps/Facility.Facility:PersistentLevel.Weapon_FishingRod_C_2147456697
    --     print(Player:GetFullName()) -- Abiotic_PlayerCharacter_C /Game/Maps/Facility.Facility:PersistentLevel.Abiotic_PlayerCharacter_C_2147471698
    --     print(Reward:GetFullName()) -- ScriptStruct /Script/Engine.DataTableRowHandle
    --     -- print(Reward.DataTable:GetFullName()) -- DataTable /Game/Blueprints/DataTables/DT_Salvage.DT_Salvage
    --     print("AAA")
    --     -- print(FindObject(nil, "/Game/Blueprints/DataTables/DT_Salvage.DT_Salvage"):get())


    --     local key = Reward.RowName:ToString()
    --     -- local mult = config.node_multiplier(key)
    --     local mult = 10.0
    --     print("[ResourceMultiplier] Multiplying Server_GrantFishingReward drops: \"" .. key .. "\" (" .. mult .. "x)\n")

    --     local r = {
    --         RowName = Reward.RowName,
    --         DataTable = Reward.DataTable
    --     }
    --     Duplicate(mult - 1.0, function()
    --         -- this should be how you do it but seems like it's still impossible to pass FDataTableRowHandle due to the DataTable field (`Value must be UObject or nil`)
    --         -- this:Server_GrantJunkReward(Player, r)

    --         -- alt that might break if they touch fishing
    --         -- this:ExecuteUbergraph_Weapon_FishingRod(2925)
    --     end)
    -- end)

    RegisterHook("/Game/Blueprints/Libraries/AbioticFunctionLibrary.AbioticFunctionLibrary_C:Server_GrantFishingReward", function(this, Player, Reward, Lucky, __WorldContext)
        if ignoreHook then
            return
        end

        local this = this:get()
        local Player, Reward, Lucky, __WorldContext = Player:get(), Reward:get(), Lucky:get(), __WorldContext:get()
        -- ue4ss requires passing struct params as a lua table, luckily this function uses a custom struct instead of FDataTableRowHandle (which is unusable from lua)
        local Reward = {
            RowName = Reward.RowName,
            DataTablePath = Reward.DataTablePath
        }

        local key = Reward.RowName:ToString()
        local mult = config.fish_multiplier(key)
        print("[ResourceMultiplier] Multiplying fish drops: \"" .. key .. "\" (" .. mult .. "x)\n")

        Duplicate(mult - 1.0, function()
            this:Server_GrantFishingReward(Player, Reward, Lucky, __WorldContext)
        end)
    end)

    -- instant fishing (DEBUG)
    -- RegisterHook("/Game/Blueprints/Items/Weapons/Guns/Weapon_FishingRod.Weapon_FishingRod_C:TickMinigame", function(this, DeltaTime)
    --     local this = this:get()
    --     this.ReelingSpeed = 10.0
    --     if this.TimeToStartMinigame > 0 then
    --         this.TimeToStartMinigame = 0
    --     end
    --     if this.NextCooldownTime > 0 then
    --         this.NextCooldownTime = 0
    --     end
    -- end)
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