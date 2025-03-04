-- This file is not for manual editing
-- If you're looking to configure the mod, you should edit the config files
-- located in AbioticFactor/Binaries/Win64/ResourceMultiplier_###.toml

-- Data last generated on version 0.10.0.15580

local nodes_comments = {
    ["container_minecrate"] = "MineCrate - (woodplank, scrap_cloth, chains, rebar, hose, pickaxe, ammo_disc, steelcable)",
    ["container_woodcrate_defense"] = "WoodCrate_Defense - (woodplank, gigaglue, pipe_metal, ducttape, flashlight_basic, scrap_cloth, magalloy)",
    ["container_woodcrate_mf"] = "WoodCrate_Manufacturing - (woodplank, gigaglue, pipe_metal, ducttape, flashlight_basic, scrap_cloth, screws, rebar, hose)",
    ["container_woodcrate_office"] = "WoodCrate_Office - (woodplank, gigaglue, pipe_metal, ducttape, flashlight_basic, scrap_cloth, acid, enethiol)",
    ["container_woodcrate_reactors"] = "WoodCrate_Reactors - (woodplank, gigaglue, capacitor, ducttape, flashlight_basic, scrap_cloth, scrap_arcane, stapler, pipe_hydro, scrap_silver)",
    ["container_woodcrate_security"] = "WoodCrate_Security - (woodplank, gigaglue, pipe_metal, ducttape, flashlight_basic, scrap_cloth, sensor, scrap_kevlar, stapler)",
    ["loot_anvil"] = "MicroNode_Anvil - (anvil)",
    ["loot_cookingpot"] = "MicroNode_CookingPot - (cookingpot)",
    ["loot_fryingpan"] = "MicroNode_FryingPan - (fryingpan)",
    ["loot_nachos"] = "MicroNode_Nachos - (food_nachos)",
    ["loot_sledgehammer"] = "MicroNode_Sledgehammer - (sledgehammer)",
    ["loot_soilbag"] = "MicroNode_SoilBag - (soilbag)",
    ["resourcenode_1book"] = "MicroNode_PhoneBook - (book)",
    ["resourcenode_acid"] = "MicroNode_Acid - (acid)",
    ["resourcenode_alienwheat"] = "Micronode_AlienWheat - (alienwheat, seed_antelight)",
    ["resourcenode_ammo_308"] = "MicroNode_Ammo_308 - (ammo_308)",
    ["resourcenode_ammo_556"] = "MicroNode_Ammo_556 - (ammo_556)",
    ["resourcenode_ammo_9mm"] = "MicroNode_Ammo_9mm - (ammo_9mm)",
    ["resourcenode_ammo_Magnum"] = "MicroNode_Ammo_Magnum - (ammo_Magnum)",
    ["resourcenode_ammo_shotgun"] = "MicroNode_Ammo_Shotgun - (ammo_12g)",
    ["resourcenode_antelightseed_blue"] = "Micronode_Antelight_Blue - (seed_antelight_blue)",
    ["resourcenode_anteversebug"] = "AnteverseBug - (carapace)",
    ["resourcenode_anteversegel"] = "MicroNode_AnteverseGel - (gel)",
    ["resourcenode_antiqueshotgun"] = "MicroNode_DoubleBarrelShotgun - (shotgun_doublebarrel)",
    ["resourcenode_apple"] = "MicroNode_Apple - (food_apple)",
    ["resourcenode_backpack_medium"] = "MicroNode_SoldierBackpack - (backpack_medium)",
    ["resourcenode_backpack_security"] = "MicroNode_SecurityBackpack - (backpack_security)",
    ["resourcenode_backpack_small"] = "MicroNode_SmallBackpack - (backpack_small)",
    ["resourcenode_barrel"] = "Barrel - (Deployable_Barrel)",
    ["resourcenode_baton"] = "MicroNode_Baton - (baton)",
    ["resourcenode_batterycharger"] = "BatteryCharger - (batterycharger)",
    ["resourcenode_beaker"] = "MicroNode_Beaker - (beaker)",
    ["resourcenode_beehive"] = "AlienBeehive - (queenbee, honey, wax)",
    ["resourcenode_binders"] = "MicroNode_Binders - (book, scrap_paper, scrap_plastic)",
    ["resourcenode_blacksmithinggloves"] = "MicroNode_BlacksmithingGloves - (armor_arms_blacksmithinggloves)",
    ["resourcenode_bleach"] = "MicroNode_Bleach - (bleach)",
    ["resourcenode_blood_plutonic"] = "MicroNode_PlutonicBlood - (blood_plutonic)",
    ["resourcenode_bluecookie"] = "MicroNode_BlueCookie - (food_cookie)",
    ["resourcenode_bonnet"] = "MicroNode_Bonnet - (armor_hat_bonnet)",
    ["resourcenode_bookstack"] = "MicroNode_BookStack1 - (book)",
    ["resourcenode_briefcase"] = "MicroNode_Briefcase - (briefcase)",
    ["resourcenode_bucket_metal"] = "MicroNode_Bucket_Metal - (bucket_metal)",
    ["resourcenode_bucket_plastic"] = "MicroNode_Bucket_Plastic - (bucket_plastic)",
    ["resourcenode_cafeteriatray"] = "MicroNode_Tray - (cafeteriatray)",
    ["resourcenode_canesword"] = "MicroNode_CaneSword - (canesword)",
    ["resourcenode_cannedpeas"] = "MicroNode_CanOfFood - (food_cannedpeas)",
    ["resourcenode_cementbag"] = "MicroNode_CementBag - (cementbag)",
    ["resourcenode_cementpallet"] = "CementPallet - (woodplank, cementbag)",
    ["resourcenode_chains"] = "MicroNode_Chains - (chains)",
    ["resourcenode_chefapron"] = "MicroNode_WearableApron - (armor_chest_apron)",
    ["resourcenode_chefhat1"] = "MicroNode_ChefHat - (armor_helmet_chefhat)",
    ["resourcenode_corn_infected"] = "MicroNode_InfectedCorn - (food_corn_infected)",
    ["resourcenode_crowbar"] = "MicroNode_Crowbar - (crowbar)",
    ["resourcenode_deskleg"] = "MicroNode_DeskLeg - (weapon_deskleg)",
    ["resourcenode_ducttape"] = "MicroNode_DuctTape - (ducttape)",
    ["resourcenode_egg"] = "MicroNode_Ebbguh - (food_eggplant_raw)",
    ["resourcenode_enethiol"] = "MicroNode_Enethiol - (enethiol)",
    ["resourcenode_essence_leyak"] = "Micronode_LeyakEssence - (essence_leyak)",
    ["resourcenode_essence_reaper"] = "Micronode_ReaperEssence - (essence_reaper)",
    ["resourcenode_fireextinguisher"] = "MicroNode_FireExtinguisher - (fireextinguisher)",
    ["resourcenode_flashlight"] = "MicroNode_Flashlight - (flashlight_basic)",
    ["resourcenode_floppyhat"] = "MicroNode_FloppyHat - (armor_hat_floppy)",
    ["resourcenode_geigercounter"] = "MicroNode_GeigerCounter - (geigercounter)",
    ["resourcenode_gigaglue"] = "MicroNode_GigaGlue - (gigaglue)",
    ["resourcenode_gloves_purple"] = "MicroNode_ContGloves - (armor_arms_gloves_purple)",
    ["resourcenode_glowtulip"] = "Micronode_Mgt_GlowTulip - (glowtulip)",
    ["resourcenode_goo_exor"] = "MicroNode_Warhead - (goo_exor)",
    ["resourcenode_gravcube"] = "MicroNode_AntiGravCube - (gravitycube)",
    ["resourcenode_grease"] = "MicroNode_AxleGrease - (grease)",
    ["resourcenode_hammer"] = "MicroNode_Hammer - (hammer)",
    ["resourcenode_hardhat"] = "MicroNode_HardHat - (armor_helmet_hardhat)",
    ["resourcenode_hazmatsuit"] = "HazmatSuit - (suit_hazmat)",
    ["resourcenode_hightechmonitor"] = "HighTechMonitor - (coil, scrap_glass, liquidcrystal, scrap_plastic)",
    ["resourcenode_highvisvest"] = "MicroNode_HighVisVest - (armor_chest_highvisvest)",
    ["resourcenode_hose"] = "MicroNode_Hose - (hose)",
    ["resourcenode_hydrohelmet"] = "MicroNode_HydroplantHelm - (armor_helmet_hydrohat)",
    ["resourcenode_hydropanel"] = "Hydropanel - (coil_v2, scrap_glass, scrap_tech, rotary_pump)",
    ["resourcenode_hydropipes"] = "HydroPipes - (pipe_hydro, rotary_pump, pressuregauge)",
    ["resourcenode_icecream"] = "MicroNode_IceCream - (icecream)",
    ["resourcenode_iodinetablets"] = "MicroNode_IodineTablets - (iodinetablets)",
    ["resourcenode_is0010"] = "MicroNode_IS_0010 - (glowshard)",
    ["resourcenode_karatehelmet"] = "MicroNode_KarateHelmet - (armor_helmet_karate)",
    ["resourcenode_keyboard"] = "MicroNode_Keyboard - (keyboard)",
    ["resourcenode_kiteshield"] = "MicroNode_KiteShield - (kiteshield)",
    ["resourcenode_knife"] = "MicroNode_Knife - (knife)",
    ["resourcenode_labmachine_carbon"] = "AnalysisMachine - (circuitboard, refinedcarbon, powersupply)",
    ["resourcenode_labmachine_gem"] = "AnalysisMachine_Gem - (circuitboard, gem, powersupply)",
    ["resourcenode_labmachine_greyeb"] = "AnalysisMachine_Greyeb - (circuitboard, seed_greyeb, powersupply)",
    ["resourcenode_labmachine_transcendium"] = "AnalysisMachine_Transcendium - (capacitor, transcendium, powersupply)",
    ["resourcenode_labmask"] = "MicroNode_GasMask - (armor_helmet_gasmask)",
    ["resourcenode_leadvest"] = "MicroNode_LeadVest - (armor_chest_leadvest)",
    ["resourcenode_leadvest_t2"] = "MicroNode_LeadVest_T2 - (armor_chest_leadvest_t2)",
    ["resourcenode_lodestone"] = "MicroNode_Lodestone - (lodestone)",
    ["resourcenode_magazinestack"] = "MicroNode_MagazineStack - (magazines)",
    ["resourcenode_militaryradio"] = "MilitaryRadio - (scrap_metal, scrap_military)",
    ["resourcenode_money"] = "MicroNode_Money - (money_stack)",
    ["resourcenode_monitor"] = "DesktopMonitor - (coil, scrap_glass, scrap_tech, scrap_plastic)",
    ["resourcenode_mre"] = "MicroNode_MRE - (food_mre)",
    ["resourcenode_neutrinomapper"] = "MicroNode_NeutrinoMapper - (neutrinomapper)",
    ["resourcenode_oar"] = "Micronode_Oar - (oar)",
    ["resourcenode_oil"] = "MicroNode_Oil - (oil)",
    ["resourcenode_paperstack"] = "MicroNode_PaperStack - (scrap_paper)",
    ["resourcenode_pc"] = "DesktopPC, DesktopPC_Note - (circuitboard, casefan, powersupply)",
    ["resourcenode_penholder"] = "MicroNode_ParentBP - (pens)",
    ["resourcenode_petrock"] = "MicroNode_PetRock - (trinket_petrock)",
    ["resourcenode_phone"] = "MicroNode_DeskPhone - (phone)",
    ["resourcenode_photocopier"] = "OfficePhotocopier - (scrap_tech, scrap_plastic, scrap_glass, powersupply, scrap_paper)",
    ["resourcenode_photonreceptor"] = "MicroNode_PhotonReceptor - (receptor)",
    ["resourcenode_pickaxe"] = "MicroNode_Pickaxe - (pickaxe)",
    ["resourcenode_pipes"] = "ParentBP - (pipe_metal, pressuregauge)",
    ["resourcenode_pipewrench"] = "MicroNode_PipeWrench - (pipewrench)",
    ["resourcenode_pocketwatch"] = "MicroNode_Pocketwatch - (pocketwatch)",
    ["resourcenode_porkchop"] = "MicroNode_Porkchop - (food_porkchop)",
    ["resourcenode_powercell"] = "MicroNode_PowerCell - (powercell)",
    ["resourcenode_printer"] = "OfficePrinter - (scrap_tech, scrap_plastic, scrap_paper)",
    ["resourcenode_pumpkin"] = "Micronode_GrownPumpkin - (pumpkin)",
    ["resourcenode_reapersigil"] = "Micronode_ReaperSigil - (ReaperSigil)",
    ["resourcenode_rebar"] = "MicroNode_Rebar - (rebar)",
    ["resourcenode_resgrowth"] = "MicroNode_ResGrowth - (growth)",
    ["resourcenode_rice"] = "Micronode_Rice - (seed_rice)",
    ["resourcenode_rubberbandball"] = "MicroNode_RubberBands - (rubberbands)",
    ["resourcenode_salem_book_01"] = "MicroNode_NiketasDiary1 - (salem_book_01)",
    ["resourcenode_salem_book_02"] = "MicroNode_NiketasDiary2 - (salem_book_02)",
    ["resourcenode_salem_book_03"] = "MicroNode_NiketasDiary3 - (salem_book_03)",
    ["resourcenode_salem_book_05"] = "MicroNode_SalemLedger - (salem_book_05)",
    ["resourcenode_salt"] = "MicroNode_Salt - (salt)",
    ["resourcenode_screwdriver"] = "MicroNode_Screwdriver - (screwdriver)",
    ["resourcenode_screws"] = "MicroNode_BoxOfScrews - (screws)",
    ["resourcenode_seaweed"] = "Micronode_Seaweed - (food_seaweed)",
    ["resourcenode_securitycap"] = "MicroNode_SecurityCap - (armor_hat_securitycap)",
    ["resourcenode_securitypistol"] = "MicroNode_SecurityPistol - (pistol_security)",
    ["resourcenode_securityvest"] = "MicroNode_SecurityVest - (armor_chest_security)",
    ["resourcenode_sg_witchbook_01"] = "MicroNode_SGWitchJournal - (sg_book_01)",
    ["resourcenode_sg_witchbook_02"] = "MicroNode_SGWitchJournal2 - (sg_book_02)",
    ["resourcenode_sg_witchbook_03"] = "MicroNode_SGWitchJournal3 - (sg_book_03)",
    ["resourcenode_shadowberries"] = "MicroNode_Shadowberries - (food_shadowberry)",
    ["resourcenode_skull"] = "MicroNode_Skull - (gib_human_skull)",
    ["resourcenode_snowballs"] = "MicroNode_VWINTERSnowball - (snowball)",
    ["resourcenode_spacelettuce"] = "SpaceLettuce - (seed_lettuce)",
    ["resourcenode_stapler"] = "MicroNode_Stapler - (stapler)",
    ["resourcenode_steelcable"] = "MicroNode_SteelCable - (steelcable)",
    ["resourcenode_sword"] = "MicroNode_Sword - (sword)",
    ["resourcenode_sydyk_book_01"] = "MicroNode_SydJournal1 - (sydyk_book_01)",
    ["resourcenode_sydyk_book_02"] = "MicroNode_SydJournal2 - (sydyk_book_02)",
    ["resourcenode_sydyk_book_03"] = "MicroNode_SydJournal3 - (sydyk_book_03)",
    ["resourcenode_transcendiumrock"] = "Transcendium - (transcendium)",
    ["resourcenode_transformer"] = "Transformer - (coil_v2, transformer_bushing, transformer_round)",
    ["resourcenode_turbine"] = "Turbine - (cog, motor)",
    ["resourcenode_umbrella"] = "MicroNode_umbrella - (umbrella)",
    ["resourcenode_vineplant"] = "Micronode_VineSeeds - (seed_vine)",
    ["resourcenode_weldingmask"] = "MicroNode_WeldingMask - (armor_helmet_weldingmask)",
    ["resourcenode_witchhat"] = "MicroNode_WitchHat - (armor_hat_witch)",
    ["resourcenode_woodenpallet"] = "WoodenPallet - (woodplank, woodplank)",
    ["salvage_1clothscrap"] = "MicroNode_ClothscrapAprons, MicroNode_Labcoat - (scrap_cloth)",
    ["salvage_1glassscrap"] = "GlassPane, GlassPane_Cinematic - (scrap_glass)",
    ["salvage_1metalscrap"] = "MetalVent - (scrap_metal)",
    ["salvage_1ropeplantseed"] = "Micronode_RopePlantSeed - (seed_ropeplant)",
    ["salvage_1silverscrap"] = "MicroNode_Silverware - (scrap_silver)",
    ["salvage_1techscrap"] = "MicroNode_Calculator - (scrap_tech)",
    ["salvage_2hexwood"] = "HexedTree - (hexwood)",
    ["salvage_4glassscrap"] = "ReceptorHousing - (scrap_glass)",
    ["salvage_militarycot"] = "MicroNode_MilitaryCot - (Deployable_Cot_Military)",
    ["salvage_tomatoseeds"] = "MicroNode_SeedsTomato - (seed_tomato)",
    ["tutorial_clothcrate"] = "TUTORIAL_CRATE - (scrap_cloth, scrap_cloth)",
}

local drops_comments = {
    ["Grunt"] = "Order Grunt - (money, food_mre, crackedlight, scrap_military, smg_military, ammo_9mm, backpack_medium, gunrepairkit_t1)",
    ["Grunt_Guard"] = "Order Guard - (money, food_mre, crackedlight, scrap_military, pistol_security, ammo_9mm, scrap_cloth, backpack_medium, gunrepairkit_t1)",
    ["Grunt_Captain"] = "Order Captain - (money, food_mre, crackedlight, scrap_military, magnum_military, frag, backpack_radio, ammo_Magnum, key_ornate, gunrepairkit_t1)",
    ["Grunt_Medic"] = "Order Medic - (money, food_mre, crackedlight, scrap_military, smg_military, ammo_9mm, backpack_medium, gunrepairkit_t1)",
    ["Grunt_Shotgun"] = "Order Breacher - (money, food_mre, crackedlight, scrap_military, shotgun_military, ammo_12g, scrap_cloth, armor_helmet_breacher, gunrepairkit_t1, key_ornate)",
    ["Grunt_Sniper"] = "Order Sniper - (money, food_mre, crackedlight, scrap_military, scrap_cloth, gunrepairkit_t1, rifle_sniper, ammo_308, book_journal, canteen)",
    ["Grunt_LabRat"] = "Lab Rat - (ratscanner, key_ornate, ratscanner, backpack_rat)",
    ["Grunt_Sapper"] = "Sapper - (petn, key_ornate, lodestone_fragment, petn, backpack_rat, lodestone_fragment)",
    ["Robot_Security"] = "Security Robot - (cpu, soda_a, soda_b, soda_c, soda_d)",
    ["Robot_Defense"] = "Defense Robot - (frag, cpu_gold, rebar)",
    ["Robot_Corrupt"] = "Corrupted Robot - (cpu_red, food_seaweed)",
    ["Robot_Containment"] = "Containment Robot - (cpu_purple, soda_a, soda_b, soda_c, soda_d, soda_anom)",
    ["Gatekeeper_Phyter"] = "Gatekeeper Phyter - (scrap_arcane, headlamp_NVG_t2_broken, ammo_556, lodestone_fragment)",
    ["Gatekeeper_Chieftain"] = "Gatekeeper Chieftain - (scrap_arcane, backpack_chieftain, key_gatekeeper, ammo_Magnum, lodestone_fragment)",
    ["Gatekeeper_Heavy"] = "Gatekeeper Jotun - (scrap_arcane, key_gatekeeper, ammo_308, lodestone_fragment)",
    ["Gatekeeper_Mage"] = "Gatekeeper Mystagogue - (scrap_arcane, key_gatekeeper, lodestone_fragment, parchment)",
    ["Gatekeeper_Witch"] = "Gatekeeper Witch - (scrap_arcane, censer, key_gatekeeper, ammo_12g, lodestone_fragment)",
    ["Thespian"] = "Thespian - (cpu, soda_a, soda_b, soda_c, soda_d)",
    ["Groupe_Grunt"] = "Groupe Mountaineer - (food_mre, crackedlight, scrap_military, rifle_groupe, ammo_556, scrap_cloth, scrap_kevlar, backpack_snow)",
    ["Groupe_Shotgun"] = "Groupe CQC - (food_mre, crackedlight, scrap_military, shotgun_military, ammo_12g, scrap_cloth, magalloy, armor_helmet_cqc)",
    ["Groupe_Rook"] = "Groupe Rook - (food_mre, crackedlight, scrap_military, riotshield, scrap_cloth, sensor, knife_groupe)",
    ["Exor_Pikeman"] = "Exor Cha - (spear_exor)",
    ["Pillager_Torchbearer"] = "Torchbearer - (scrap_silver)",
    ["Pillager_Woodsman"] = "Woodsman - (scrap_silver, woodaxe)",
    ["Pillager_Farmer"] = "Farmer - (scrap_silver, pitchfork)",
    ["Pillager_Preacher"] = "Lodeite - (scrap_silver, lodestone_fragment)",
    ["Pillager_Musketeer"] = "Guard - (scrap_silver, crossbow_broken)",
    ["Pillager_Musketeer_GUARD"] = "Guard - (scrap_silver, crossbow_broken)",
    ["Pillager_Preacher_Niketas"] = "Niketas - (scrap_silver, salem_book_04)",
    ["Larva_BOSS"] = "Nyth the Gluttonous - (core_fragment, gib_meat_larva, gib_meat_larva, gib_meat_larva, fig_larvaorange)",
    ["Gatekeeper_Heavy_BANNER"] = "Gatekeeper Jotun - (scrap_arcane, key_gatekeeper, ammo_308, lodestone_fragment)",
}

local corpse_comments = {
    ["Pest"] = "Pest - (gib_pest_body, gib_pest_tail)",
    ["Pest_Volatile"] = "Volatile Pest - (gib_pest_body, gib_pest_tail, carapace_plutonic)",
    ["Pest_Electro"] = "Electro-Pest - (gib_pest_body, gib_pest_tail, capacitor, scrap_tech)",
    ["Peccary"] = "Peccary - (gib_peccary_leg, gib_peccary_skull, gib_peccary_chop)",
    ["Peccary_Mushroom"] = "Mushroom Peccary - (gib_peccary_leg, gib_pecmushroom_skull, gib_peccary_chop, food_mushroom, food_mushroom)",
    ["Sow"] = "Peccary Sow - (gib_peccary_leg, gib_sow_skull, gib_peccary_chop, food_milksac, scrap_leather)",
    ["Exor_Monk"] = "Exor Monk - (gib_peccary_leg, gib_exorheart)",
    ["Exor"] = "Exor - (gib_peccary_leg, gib_exorheart, gib_exor_arm, exorquill)",
    ["Exor_Volatile"] = "Volatile Exor - (blood_plutonic, exorquill, carapace_plutonic, gib_exor_skull_volatile)",
    ["Exor_Armored"] = "Armored Exor - (gib_peccary_leg, gib_exorheart, gib_exor_arm_red, exorquill)",
    ["Grunt"] = "Order Grunt - (gib_human_skull, gib_human_arm_mil)",
    ["Grunt_Guard"] = "Order Guard - (gib_human_skull, gib_human_arm_mil)",
    ["Grunt_Captain"] = "Order Captain - (gib_human_skull, gib_human_arm_mil)",
    ["Grunt_Medic"] = "Order Medic - (gib_human_skull, gib_human_arm_mil)",
    ["Grunt_Shotgun"] = "Order Breacher - (gib_human_skull, gib_human_arm_mil)",
    ["Grunt_Sniper"] = "Order Sniper - (gib_human_arm_mil, gib_sniper_skull)",
    ["Grunt_LabRat"] = "Lab Rat - (gib_human_skull, gib_human_arm_mil, suit_ratsuit)",
    ["Grunt_Sapper"] = "Sapper - (gib_human_skull, gib_human_arm_mil, suit_sappersuit)",
    ["Robot_Security"] = "Security Robot - (scrap_metal, scrap_glass, scrap_tech, coil, oil_robot)",
    ["Robot_Defense"] = "Defense Robot - (scrap_tech, coil_v2, transformer_bushing, transformer_round, gib_human_skull, coil, oil_robot)",
    ["Robot_Corrupt"] = "Corrupted Robot - (scrap_tech, oil_robot, key_gatekeeper, scrap_arcane)",
    ["Robot_Containment"] = "Containment Robot - (scrap_metal, scrap_glass, scrap_tech, coil, oil_robot)",
    ["Gatekeeper_Phyter"] = "Gatekeeper Phyter - (gib_human_arm_mil, scrap_kevlar, gib_human_skull)",
    ["Gatekeeper_Chieftain"] = "Gatekeeper Chieftain - (gib_chieftain_skull, gib_human_arm_mil, scrap_kevlar)",
    ["Gatekeeper_Heavy"] = "Gatekeeper Jotun - (gib_gkheavy_skull, backpack_heavy, scrap_kevlar)",
    ["Gatekeeper_Mage"] = "Gatekeeper Mystagogue - (gib_mage_skull, gib_human_arm_mil)",
    ["Gatekeeper_MageEye"] = "Mystagogue Eye - (mage_eye, scrap_arcane)",
    ["Gatekeeper_Witch"] = "Gatekeeper Witch - (gib_witch_skull)",
    ["Behemoth"] = "Behemoth - (ichor, gib_skull_behemoth)",
    ["Tarasque"] = "Tarasque - (ichor, gib_tarasque_skull)",
    ["Yeti"] = "Yeti - (yetifur, gib_yeti_skull)",
    ["Groupe_Grunt"] = "Groupe Mountaineer - (gib_human_skull, gib_human_arm_mil, armor_arms_groupe, armor_chest_groupe, armor_legs_groupe)",
    ["Groupe_Shotgun"] = "Groupe CQC - (gib_human_skull, gib_human_arm_mil, armor_arms_groupe, armor_chest_groupe, armor_legs_groupe)",
    ["Groupe_Rook"] = "Groupe Rook - (gib_human_skull, gib_human_arm_mil, armor_arms_groupe, armor_chest_groupe, armor_legs_groupe)",
    ["Assassin"] = "Crystallisk - (powderedcrystal)",
    ["Coworker"] = "Coworker - (gib_human_skull)",
    ["Peccary_Alpha"] = "Peccary Alpha - (gib_peccary_leg, gib_peccary_skull_red, gib_peccary_chop, food_milksac)",
    ["Zombie"] = "Zombie - (gib_human_skull)",
    ["Zombie_Sci"] = "Zombie Scientist - (gib_human_skull)",
    ["Symph"] = "Symphonist - (gib_symph_skull, key_porcelain, scrap_composer, organ, composer_tablet)",
    ["Zombie_Dam"] = "Hydroplant Zombie - (pipe_hydro, gib_human_skull)",
    ["Exor_Pikeman"] = "Exor Cha - (gib_exor_skull, gib_peccary_leg, food_milksac)",
    ["Pillager_Torchbearer"] = "Torchbearer - (gib_human_skull, armor_hat_pilgrim)",
    ["Pillager_Woodsman"] = "Woodsman - (gib_human_skull)",
    ["Pillager_Farmer"] = "Farmer - (gib_human_skull, armor_hat_pilgrim)",
    ["Pillager_Preacher"] = "Lodeite - (gib_human_skull)",
    ["Pillager_Musketeer"] = "Guard - (gib_human_skull, armor_hat_pilgrim)",
    ["BogMan"] = "Bog Monster - (scrap_bio, lodestone_fragment, Plant_Dead, scrap_leather)",
    ["Pillager_Musketeer_GUARD"] = "Guard - (gib_human_skull, armor_hat_pilgrim)",
    ["Pillager_Preacher_Niketas"] = "Niketas - (gib_human_skull, scrap_tech, armor_hat_preacher)",
    ["Larva"] = "Larva - (gib_meat_larva, fig_larva)",
    ["Larva_Hive"] = "Hive Larva - (gib_meat_larva, fig_larva)",
    ["Larva_Big"] = "Big Larva - (gib_meat_larva, fig_larvabig)",
    ["Larva_Big_Hive"] = "Big Hive Larva - (gib_meat_larva, fig_larvabig)",
    ["Gatekeeper_Heavy_BANNER"] = "Gatekeeper Jotun - (gib_gkheavy_skull, backpack_heavy, scrap_kevlar)",
}

return {
    nodes_comments = nodes_comments,
    drops_comments = drops_comments,
    corpse_comments = corpse_comments,
}