# ResourceMultiplier

[View on NexusMods](https://www.nexusmods.com/abioticfactor/mods/39/)

<img src="https://github.com/PieKing1215/AF_ResourceMultiplier/blob/main/nexus/example.png?raw=true" width="45%"/> <img src="https://github.com/PieKing1215/AF_ResourceMultiplier/blob/main/nexus/crate.png?raw=true" width="25.5%"/> <img src="https://github.com/PieKing1215/AF_ResourceMultiplier/blob/main/nexus/bot.png?raw=true" width="28%"/>

Mod for [Abiotic Factor](https://store.steampowered.com/app/427410/Abiotic_Factor/) that lets you specify multipliers for:
- Drops from resource nodes (eg. crates, PCs, wall pipes, staplers/keyboards/cloth on tables).
- Drops when an NPC is killed (eg. robot CPUs/sodas, grunt ammo/military scrap)
- Drops when an NPC's corpse is chopped (eg. robot metal/tech scrap, grunt arms/skulls, various meats)

You can set global multipliers and/or multipliers for individual loot tables/NPCs.<br/>

Requires [UE4SS for Abiotic Factor](https://www.nexusmods.com/abioticfactor/mods/35)<br/>
After you have that set up, download & unzip the mod zip and copy the ResourceMultiplier folder (which has `Scripts/` and `enabled.txt` directly in it) into `/AbioticFactor/Binaries/Win64/ue4ss/Mods/`

By default, everything defaults to 1.0x so you should see no difference.<br/>
After starting the game with the mod once it will generate config files that you can edit at `AbioticFactor/Binaries/Win64/ResourceMultiplier_###.toml`

Should work in multiplayer if the host has the mod (or the server has the mod for dedicated servers)
