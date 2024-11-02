
-- Multiplier for all resource nodes (cannot go below 1.0)
-- (decimals are a chance to get the next integer up, eg. 1.5 means 50/50 chance to get 1x or 2x)
local globalMultiplier = 1.0
-- If true, pressing F5 will respawn all depleted resource nodes (for debugging)
-- WARNING: may cause memory leaks which can lead to crash on world exit 
local debugKeybinds = false

-- Multipliers for specific resource node loot tables (cannot go below 1.0)
-- Uncomment a row and change the number to change the multiplier for that loot table
-- Ex. if you set "container_woodcrate_office" to 10.0, the wood crates in the office sector will drop 10x the items
-- (decimals are a chance to get the next integer up, eg. 1.5 means 50/50 chance to get 1x or 2x)
-- This list was extracted on version 0.9.1.11753, but it might be incomplete.
-- The id used is printed to the UE4SS console when a resource node drops loot, so if there's missing ones you could add it to the list.
local specific_multipliers = {
    -- ["resourcenode_screwdriver"] = 1.0,         -- MicroNode_Screwdriver
    -- ["resourcenode_woodenpallet"] = 1.0,        -- WoodenPallet
    -- ["resourcenode_photonreceptor"] = 1.0,      -- MicroNode_PhotonReceptor
    -- ["loot_sledgehammer"] = 1.0,                -- MicroNode_Sledgehammer
    -- ["resourcenode_hardhat"] = 1.0,             -- MicroNode_HardHat
    -- ["resourcenode_cafeteriatray"] = 1.0,       -- MicroNode_Tray
    -- ["resourcenode_securitypistol"] = 1.0,      -- MicroNode_SecurityPistol
    -- ["resourcenode_hydropipes"] = 1.0,          -- HydroPipes
    -- ["resourcenode_monitor"] = 1.0,             -- DesktopMonitor
    -- ["resourcenode_photocopier"] = 1.0,         -- OfficePhotocopier
    -- ["resourcenode_egg"] = 1.0,                 -- MicroNode_Ebbguh
    -- ["salvage_tomatoseeds"] = 1.0,              -- MicroNode_SeedsTomato
    -- ["resourcenode_keyboard"] = 1.0,            -- MicroNode_Keyboard
    -- ["salvage_1silverscrap"] = 1.0,             -- MicroNode_Silverware
    -- ["resourcenode_bookstack"] = 1.0,           -- MicroNode_BookStack1
    -- ["resourcenode_stapler"] = 1.0,             -- MicroNode_Stapler
    -- ["salvage_1techscrap"] = 1.0,               -- MicroNode_Calculator
    -- ["resourcenode_paperstack"] = 1.0,          -- MicroNode_PaperStack
    -- ["resourcenode_pc"] = 1.0,                  -- DesktopPC, DesktopPC_Note
    -- ["resourcenode_cementpallet"] = 1.0,        -- CementPallet
    -- ["resourcenode_labmachine_gem"] = 1.0,      -- AnalysisMachine_Gem
    -- ["resourcenode_leadvest"] = 1.0,            -- MicroNode_LeadVest
    -- ["loot_nachos"] = 1.0,                      -- MicroNode_Nachos
    -- ["resourcenode_backpack_medium"] = 1.0,     -- MicroNode_SoldierBackpack
    -- ["resourcenode_karatehelmet"] = 1.0,        -- MicroNode_KarateHelmet
    -- ["resourcenode_ducttape"] = 1.0,            -- MicroNode_DuctTape
    -- ["resourcenode_resgrowth"] = 1.0,           -- MicroNode_ResGrowth
    -- ["resourcenode_oil"] = 1.0,                 -- MicroNode_Oil
    -- ["resourcenode_hydropanel"] = 1.0,          -- Hydropanel
    -- ["resourcenode_kiteshield"] = 1.0,          -- MicroNode_KiteShield
    -- ["resourcenode_sword"] = 1.0,               -- MicroNode_Sword
    -- ["resourcenode_chefapron"] = 1.0,           -- MicroNode_WearableApron
    -- ["salvage_1metalscrap"] = 1.0,              -- MetalVent
    -- ["resourcenode_skull"] = 1.0,               -- MicroNode_Skull
    -- ["resourcenode_leadvest_t2"] = 1.0,         -- MicroNode_LeadVest_T2
    -- ["resourcenode_antiqueshotgun"] = 1.0,      -- MicroNode_DoubleBarrelShotgun
    -- ["resourcenode_cementbag"] = 1.0,           -- MicroNode_CementBag
    -- ["resourcenode_canesword"] = 1.0,           -- MicroNode_CaneSword
    -- ["resourcenode_turbine"] = 1.0,             -- Turbine
    -- ["resourcenode_knife"] = 1.0,               -- MicroNode_Knife
    -- ["salvage_4glassscrap"] = 1.0,              -- ReceptorHousing
    -- ["resourcenode_briefcase"] = 1.0,           -- MicroNode_Briefcase
    -- ["resourcenode_hightechmonitor"] = 1.0,     -- HighTechMonitor
    -- ["resourcenode_highvisvest"] = 1.0,         -- MicroNode_HighVisVest
    -- ["resourcenode_securitycap"] = 1.0,         -- MicroNode_SecurityCap
    -- ["resourcenode_securityvest"] = 1.0,        -- MicroNode_SecurityVest
    -- ["resourcenode_seaweed"] = 1.0,             -- Micronode_Seaweed
    -- ["resourcenode_gravcube"] = 1.0,            -- MicroNode_AntiGravCube
    -- ["resourcenode_pickaxe"] = 1.0,             -- MicroNode_Pickaxe
    -- ["resourcenode_cannedpeas"] = 1.0,          -- MicroNode_CanOfFood
    -- ["resourcenode_iodinetablets"] = 1.0,       -- MicroNode_IodineTablets
    -- ["resourcenode_labmachine_greyeb"] = 1.0,   -- AnalysisMachine_Greyeb
    -- ["resourcenode_acid"] = 1.0,                -- MicroNode_Acid
    -- ["resourcenode_essence_leyak"] = 1.0,       -- Micronode_LeyakEssence
    -- ["loot_anvil"] = 1.0,                       -- MicroNode_Anvil
    -- ["resourcenode_chefhat1"] = 1.0,            -- MicroNode_ChefHat
    -- ["resourcenode_rice"] = 1.0,                -- Micronode_Rice
    -- ["resourcenode_printer"] = 1.0,             -- OfficePrinter
    -- ["resourcenode_ammo_308"] = 1.0,            -- MicroNode_Ammo_308
    -- ["resourcenode_beaker"] = 1.0,              -- MicroNode_Beaker
    -- ["resourcenode_anteversebug"] = 1.0,        -- AnteverseBug
    -- ["resourcenode_batterycharger"] = 1.0,      -- BatteryCharger
    -- ["tutorial_clothcrate"] = 1.0,              -- TUTORIAL_CRATE
    -- ["resourcenode_gigaglue"] = 1.0,            -- MicroNode_GigaGlue
    -- ["resourcenode_oar"] = 1.0,                 -- Micronode_Oar
    -- ["resourcenode_gloves_purple"] = 1.0,       -- MicroNode_ContGloves
    -- ["resourcenode_pipes"] = 1.0,               -- ParentBP
    -- ["resourcenode_steelcable"] = 1.0,          -- MicroNode_SteelCable
    -- ["resourcenode_militaryradio"] = 1.0,       -- MilitaryRadio
    -- ["resourcenode_anteversegel"] = 1.0,        -- MicroNode_AnteverseGel
    -- ["resourcenode_pipewrench"] = 1.0,          -- MicroNode_PipeWrench
    -- ["resourcenode_enethiol"] = 1.0,            -- MicroNode_Enethiol
    -- ["resourcenode_weldingmask"] = 1.0,         -- MicroNode_WeldingMask
    -- ["salvage_hazmatsuit"] = 1.0,               -- HazmatSuit
    -- ["resourcenode_ammo_556"] = 1.0,            -- MicroNode_Ammo_556
    -- ["resourcenode_pocketwatch"] = 1.0,         -- MicroNode_Pocketwatch
    -- ["loot_cookingpot"] = 1.0,                  -- MicroNode_CookingPot
    -- ["resourcenode_vineplant"] = 1.0,           -- Micronode_VineSeeds
    -- ["resourcenode_bucket_plastic"] = 1.0,      -- MicroNode_Bucket_Plastic
    -- ["resourcenode_chains"] = 1.0,              -- MicroNode_Chains
    -- ["salvage_1ropeplantseed"] = 1.0,           -- Micronode_RopePlantSeed
    -- ["container_woodcrate_security"] = 1.0,     -- WoodCrate_Security
    -- ["container_woodcrate_mf"] = 1.0,           -- WoodCrate_Manufacturing
    -- ["loot_fryingpan"] = 1.0,                   -- MicroNode_FryingPan
    -- ["resourcenode_magazinestack"] = 1.0,       -- MicroNode_MagazineStack
    -- ["resourcenode_floppyhat"] = 1.0,           -- MicroNode_FloppyHat
    -- ["resourcenode_essence_reaper"] = 1.0,      -- Micronode_ReaperEssence
    -- ["resourcenode_penholder"] = 1.0,           -- MicroNode_ParentBP
    -- ["resourcenode_binders"] = 1.0,             -- MicroNode_Binders
    -- ["resourcenode_labmachine_carbon"] = 1.0,   -- AnalysisMachine
    -- ["resourcenode_barrel"] = 1.0,              -- Barrel
    -- ["resourcenode_backpack_security"] = 1.0,   -- MicroNode_SecurityBackpack
    -- ["resourcenode_ammo_9mm"] = 1.0,            -- MicroNode_Ammo_9mm
    -- ["resourcenode_fireextinguisher"] = 1.0,    -- MicroNode_FireExtinguisher
    -- ["resourcenode_bucket_metal"] = 1.0,        -- MicroNode_Bucket_Metal
    -- ["resourcenode_spacelettuce"] = 1.0,        -- SpaceLettuce
    -- ["resourcenode_screws"] = 1.0,              -- MicroNode_BoxOfScrews
    -- ["resourcenode_bluecookie"] = 1.0,          -- MicroNode_BlueCookie
    -- ["resourcenode_antelightseed_blue"] = 1.0,  -- Micronode_Antelight_Blue
    -- ["resourcenode_grease"] = 1.0,              -- MicroNode_AxleGrease
    -- ["resourcenode_labmask"] = 1.0,             -- MicroNode_GasMask
    -- ["resourcenode_salt"] = 1.0,                -- MicroNode_Salt
    -- ["container_minecrate"] = 1.0,              -- MineCrate
    -- ["resourcenode_hammer"] = 1.0,              -- MicroNode_Hammer
    -- ["resourcenode_backpack_small"] = 1.0,      -- MicroNode_SmallBackpack
    -- ["resourcenode_flashlight"] = 1.0,          -- MicroNode_Flashlight
    -- ["resourcenode_blacksmithinggloves"] = 1.0, -- MicroNode_BlacksmithingGloves
    -- ["resourcenode_1book"] = 1.0,               -- MicroNode_PhoneBook
    -- ["loot_soilbag"] = 1.0,                     -- MicroNode_SoilBag
    -- ["resourcenode_geigercounter"] = 1.0,       -- MicroNode_GeigerCounter
    -- ["resourcenode_rubberbandball"] = 1.0,      -- MicroNode_RubberBands
    -- ["resourcenode_phone"] = 1.0,               -- MicroNode_DeskPhone
    -- ["resourcenode_crowbar"] = 1.0,             -- MicroNode_Crowbar
    -- ["resourcenode_rebar"] = 1.0,               -- MicroNode_Rebar
    -- ["resourcenode_baton"] = 1.0,               -- MicroNode_Baton
    -- ["resourcenode_hose"] = 1.0,                -- MicroNode_Hose
    -- ["resourcenode_icecream"] = 1.0,            -- MicroNode_IceCream
    -- ["resourcenode_neutrinomapper"] = 1.0,      -- MicroNode_NeutrinoMapper
    -- ["resourcenode_porkchop"] = 1.0,            -- MicroNode_Porkchop
    -- ["resourcenode_alienwheat"] = 1.0,          -- Micronode_AlienWheat
    -- ["resourcenode_reapersigil"] = 1.0,         -- Micronode_ReaperSigil
    -- ["container_woodcrate_office"] = 1.0,       -- WoodCrate_Office
    -- ["resourcenode_umbrella"] = 1.0,            -- MicroNode_umbrella
    -- ["resourcenode_money"] = 1.0,               -- MicroNode_Money
    -- ["salvage_1clothscrap"] = 1.0,              -- MicroNode_ClothscrapAprons, MicroNode_Labcoat
    -- ["resourcenode_petrock"] = 1.0,             -- MicroNode_PetRock
    -- ["resourcenode_transformer"] = 1.0,         -- Transformer
    -- ["resourcenode_ammo_shotgun"] = 1.0,        -- MicroNode_Ammo_Shotgun
    -- ["resourcenode_powercell"] = 1.0,           -- MicroNode_PowerCell
    -- ["resourcenode_deskleg"] = 1.0,             -- MicroNode_DeskLeg
    -- ["resourcenode_is0010"] = 1.0,              -- MicroNode_IS_0010
    -- ["salvage_1glassscrap"] = 1.0,              -- GlassPane, GlassPane_Cinematic
    -- ["resourcenode_mre"] = 1.0,                 -- MicroNode_MRE
    -- ["container_woodcrate_defense"] = 1.0,      -- WoodCrate_Defense
}

function CalculateMultiplier(key)
    local mult = globalMultiplier

    if type(specific_multipliers[key:lower()]) == "number" then
        mult = mult * specific_multipliers[key:lower()]
    end

    return math.min(math.max(mult, 1.0), 100.0)
end

local ignoreHook = false

ExecuteInGameThread(function ()
    LoadAsset("/Game/Blueprints/Environment/Nodes/ResourceNode_ParentBP.ResourceNode_ParentBP_C")
    RegisterHook("/Game/Blueprints/Environment/Nodes/ResourceNode_ParentBP.ResourceNode_ParentBP_C:DropLoot", function(this, a, b, c)
        if ignoreHook then
            return
        end

        local key = this:get().SalvageDropRow.RowName:ToString()
        local mult = CalculateMultiplier(key)
        print("[ResourceMultiplier] DropLoot \"" .. key .. "\" (" .. mult .. "x)\n")

        local t = this:get()
        local a,b,c = a:get(),b:get(),c:get()

        DuplicateDrops(t, a, b, c, mult - 1.0)
    end)
end)

function DuplicateDrops(this, a, b, c, chance)
    if math.random() < chance then
        -- for some reason without this delay it sometimes doesn't work
        ExecuteWithDelay(20, function()
            ExecuteInGameThread(function()
                ignoreHook = true
                this:DropLoot(a, b, c)
                ignoreHook = false
                DuplicateDrops(this, a, b, c, chance - 1.0)
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
end

print("[ResourceMultiplier] Mod loaded\n")