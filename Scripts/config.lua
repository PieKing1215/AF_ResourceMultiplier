local data = require("data")

-- not really toml but we get syntax highlighting
local nodesPath = "ResourceMultiplier_nodes.toml"
local dropsPath = "ResourceMultiplier_drops.toml"
local corpsesPath = "ResourceMultiplier_corpses.toml"

local nodeGlobalMultiplier = 1.0
local nodeMultipliers = {}

local dropGlobalMultiplier = 1.0
local dropMultipliers = {}

local corpseGlobalMultiplier = 1.0
local corpseMultipliers = {}

local function max_len(tbl)
    local max = 0
    for k,v in pairs(tbl) do
        max = math.max(max, v:len())
    end
    return max
end

local function save_nodes()
    print("[ResourceMultiplier] Saving " .. nodesPath)

    local nodesFile = io.open(nodesPath, "w")

    if nodesFile == nil then
        print("[ResourceMultiplier] nodesFile was nil")
        return
    end

    local text = ""
    text = text .. "# This file lets you configure drop rates for Resource Nodes.\n"
    text = text .. "# This includes crates, PCs, wall pipes, things like staplers/keyboards/cloth placed on tables, etc.\n"
    text = text .. "# You will need to restart the game (or \"Restart All Mods\" in UE4SS gui) for changes to apply.\n"
    text = text .. "# (NOTE: this file is reformatted automatically after loading, changes other than editing numbers or adding new entries will be lost)\n"
    text = text .. "\n"
    text = text .. "# Global multiplier that affects ALL resource nodes (cannot go below 1.0)\n"
    text = text .. ("global_multiplier = %f\n"):format(nodeGlobalMultiplier)
    text = text .. "\n"

    text = text .. "# Multipliers for individual node types (cannot go below 1.0)\n"
    text = text .. "# (decimals are a chance to get the next integer up, eg. 1.5 means 50/50 chance to get 1x or 2x)\n"
    text = text .. "# The id used is printed to the UE4SS console when a resource node drops loot, so if there's missing ones you could add it to the list.\n"

    -- fill in edited entries

    local keys = {}

    for k, _ in pairs(nodeMultipliers) do
        table.insert(keys, k)
    end

    table.sort(keys)

    local formatted = {}

    for i = 1, #keys do
        local k = keys[i]
        table.insert(formatted, ("%s = %f"):format(k, nodeMultipliers[k]))
    end

    local len = max_len(formatted)

    for i = 1, #keys do
        local k = keys[i]
        local str = formatted[i]
        local v = data.nodes_comments[k]

        local pad = (" "):rep(len - str:len())

        if type(v) == "string" then
            text = text .. ("%s%s # %s\n"):format(str, pad, v)
        else
            text = text .. ("%s\n"):format(str)
        end
    end

    if next(nodeMultipliers) ~= nil then
        text = text .. "\n"
    end

    -- fill in any missing entries

    keys = {}

    for k, _ in pairs(data.nodes_comments) do
        if nodeMultipliers[k] == nil then
            table.insert(keys, k)
        end
    end

    table.sort(keys)

    formatted = {}

    for i = 1, #keys do
        table.insert(formatted, ("%s = %f"):format(keys[i], 1.0))
    end

    len = max_len(formatted)

    for i = 1, #keys do
        local k = keys[i]
        local str = formatted[i]
        local v = data.nodes_comments[k]

        local pad = (" "):rep(len - str:len())
        text = text .. ("%s%s # %s\n"):format(str, pad, v)
    end

    nodesFile:write(text)
    nodesFile:close()
end

local function load_nodes()
    print("[ResourceMultiplier] Loading " .. nodesPath)

    local nodesFile = io.open(nodesPath, "r")

    if nodesFile == nil then
        print("[ResourceMultiplier] Nodes config missing, regenerating")
        save_nodes()
        return
    end

    local text = nodesFile:read("*a")

    -- if file is empty, regenerate it
    if text == "" then
        print("[ResourceMultiplier] Nodes config was empty, regenerating")
        nodesFile:close()
        save_nodes()
        return
    end

    for k,v in text:gmatch("([%w_]*)%s*=%s*([%d.]*)") do
        local maybeNum = tonumber(v)
        if maybeNum ~= nil then
            local n = math.min(math.max(maybeNum, 1.0), 100.0)
            if k == "global_multiplier" then
                nodeGlobalMultiplier = n
            else
                if n ~= 1.0 or data.nodes_comments[k] == nil then
                    nodeMultipliers[k] = n
                end
            end
        end
    end

    nodesFile:close()

    save_nodes()
end

local function save_drops()
    print("[ResourceMultiplier] Saving " .. dropsPath)

    local dropsFile = io.open(dropsPath, "w")

    if dropsFile == nil then
        print("[ResourceMultiplier] dropsFile was nil")
        return
    end

    local text = ""
    text = text .. "# This file lets you configure drop rates for NPC drops.\n"
    text = text .. "# This includes items that enemies drop immediately when killed (not items from chopping their corpse)\n"
    text = text .. "# You will need to restart the game (or \"Restart All Mods\" in UE4SS gui) for changes to apply.\n"
    text = text .. "# (NOTE: this file is reformatted automatically after loading, changes other than editing numbers or adding new entries will be lost)\n"
    text = text .. "\n"
    text = text .. "# Global multiplier that affects ALL NPC drops (cannot go below 1.0)\n"
    text = text .. ("global_multiplier = %f\n"):format(dropGlobalMultiplier)
    text = text .. "\n"

    text = text .. "# Multipliers for individual NPC types (cannot go below 1.0)\n"
    text = text .. "# (decimals are a chance to get the next integer up, eg. 1.5 means 50/50 chance to get 1x or 2x)\n"
    text = text .. "# The id used is printed to the UE4SS console when an NPC drops loot, so if there's missing ones you could add it to the list.\n"

    -- fill in edited entries

    local keys = {}

    for k, _ in pairs(dropMultipliers) do
        table.insert(keys, k)
    end

    table.sort(keys)

    local formatted = {}

    for i = 1, #keys do
        local k = keys[i]
        table.insert(formatted, ("%s = %f"):format(k, dropMultipliers[k]))
    end

    local len = max_len(formatted)

    for i = 1, #keys do
        local k = keys[i]
        local str = formatted[i]
        local v = data.drops_comments[k]

        local pad = (" "):rep(len - str:len())

        if type(v) == "string" then
            text = text .. ("%s%s # %s\n"):format(str, pad, v)
        else
            text = text .. ("%s\n"):format(str)
        end
    end

    if next(dropMultipliers) ~= nil then
        text = text .. "\n"
    end

    -- fill in any missing entries

    keys = {}

    for k, _ in pairs(data.drops_comments) do
        if dropMultipliers[k] == nil then
            table.insert(keys, k)
        end
    end

    table.sort(keys)

    formatted = {}

    for i = 1, #keys do
        table.insert(formatted, ("%s = %f"):format(keys[i], 1.0))
    end

    len = max_len(formatted)

    for i = 1, #keys do
        local k = keys[i]
        local str = formatted[i]
        local v = data.drops_comments[k]

        local pad = (" "):rep(len - str:len())
        text = text .. ("%s%s # %s\n"):format(str, pad, v)
    end

    dropsFile:write(text)
    dropsFile:close()
end

local function load_drops()
    print("[ResourceMultiplier] Loading " .. dropsPath)

    local dropsFile = io.open(dropsPath, "r")

    if dropsFile == nil then
        print("[ResourceMultiplier] Drops config missing, regenerating")
        save_drops()
        return
    end

    local text = dropsFile:read("*a")

    -- if file is empty, regenerate it
    if text == "" then
        print("[ResourceMultiplier] Drops config was empty, regenerating")
        dropsFile:close()
        save_drops()
        return
    end

    for k,v in text:gmatch("([%w_]*)%s*=%s*([%d.]*)") do
        local maybeNum = tonumber(v)
        if maybeNum ~= nil then
            local n = math.min(math.max(maybeNum, 1.0), 100.0)
            if k == "global_multiplier" then
                dropGlobalMultiplier = n
            else
                if n ~= 1.0 or data.drops_comments[k] == nil then
                    dropMultipliers[k] = n
                end
            end
        end
    end

    dropsFile:close()

    save_drops()
end

local function save_corpses()
    print("[ResourceMultiplier] Saving " .. corpsesPath)

    local corpsesFile = io.open(corpsesPath, "w")

    if corpsesFile == nil then
        print("[ResourceMultiplier] corpsesFile was nil")
        return
    end

    local text = ""
    text = text .. "# This file lets you configure drop rates for NPC corpses.\n"
    text = text .. "# This includes items that drop when an enemy's corpse is chopped.\n"
    text = text .. "# You will need to restart the game (or \"Restart All Mods\" in UE4SS gui) for changes to apply.\n"
    text = text .. "# (NOTE: this file is reformatted automatically after loading, changes other than editing numbers or adding new entries will be lost)\n"
    text = text .. "\n"
    text = text .. "# Global multiplier that affects ALL NPC corpse drops (cannot go below 1.0)\n"
    text = text .. ("global_multiplier = %f\n"):format(corpseGlobalMultiplier)
    text = text .. "\n"

    text = text .. "# Multipliers for individual NPC types (cannot go below 1.0)\n"
    text = text .. "# (decimals are a chance to get the next integer up, eg. 1.5 means 50/50 chance to get 1x or 2x)\n"
    text = text .. "# The id used is printed to the UE4SS console when an NPC corpse is destroyed, so if there's missing ones you could add it to the list.\n"

    -- fill in edited entries

    local keys = {}

    for k, _ in pairs(corpseMultipliers) do
        table.insert(keys, k)
    end

    table.sort(keys)

    local formatted = {}

    for i = 1, #keys do
        local k = keys[i]
        table.insert(formatted, ("%s = %f"):format(k, corpseMultipliers[k]))
    end

    local len = max_len(formatted)

    for i = 1, #keys do
        local k = keys[i]
        local str = formatted[i]
        local v = data.corpse_comments[k]

        local pad = (" "):rep(len - str:len())

        if type(v) == "string" then
            text = text .. ("%s%s # %s\n"):format(str, pad, v)
        else
            text = text .. ("%s\n"):format(str)
        end
    end

    if next(corpseMultipliers) ~= nil then
        text = text .. "\n"
    end

    -- fill in any missing entries

    keys = {}

    for k, _ in pairs(data.corpse_comments) do
        if corpseMultipliers[k] == nil then
            table.insert(keys, k)
        end
    end

    table.sort(keys)

    formatted = {}

    for i = 1, #keys do
        table.insert(formatted, ("%s = %f"):format(keys[i], 1.0))
    end

    len = max_len(formatted)

    for i = 1, #keys do
        local k = keys[i]
        local str = formatted[i]
        local v = data.corpse_comments[k]

        local pad = (" "):rep(len - str:len())
        text = text .. ("%s%s # %s\n"):format(str, pad, v)
    end

    corpsesFile:write(text)
    corpsesFile:close()
end

local function load_corpses()
    print("[ResourceMultiplier] Loading " .. corpsesPath)

    local corpsesFile = io.open(corpsesPath, "r")

    if corpsesFile == nil then
        print("[ResourceMultiplier] Corpses config missing, regenerating")
        save_corpses()
        return
    end

    local text = corpsesFile:read("*a")

    -- if file is empty, regenerate it
    if text == "" then
        print("[ResourceMultiplier] corpses config was empty, regenerating")
        corpsesFile:close()
        save_corpses()
        return
    end

    for k,v in text:gmatch("([%w_]*)%s*=%s*([%d.]*)") do
        local maybeNum = tonumber(v)
        if maybeNum ~= nil then
            local n = math.min(math.max(maybeNum, 1.0), 100.0)
            if k == "global_multiplier" then
                corpseGlobalMultiplier = n
            else
                if n ~= 1.0 or data.corpse_comments[k] == nil then
                    corpseMultipliers[k] = n
                end
            end
        end
    end

    corpsesFile:close()

    save_corpses()
end

local function save()
    save_nodes()
    save_drops()
    save_corpses()
end

local function load()
    print("[ResourceMultiplier] Loading config...")

    load_nodes()
    load_drops()
    load_corpses()
end

local function node_multiplier(key)
    local mult = nodeGlobalMultiplier

    if type(nodeMultipliers[key]) == "number" then
        mult = mult * nodeMultipliers[key]
    end

    return math.min(math.max(mult, 1.0), 100.0)
end

local function drop_multiplier(key)
    local mult = dropGlobalMultiplier

    if type(dropMultipliers[key]) == "number" then
        mult = mult * dropMultipliers[key]
    end

    return math.min(math.max(mult, 1.0), 100.0)
end

local function corpse_multiplier(key)
    local mult = corpseGlobalMultiplier

    if type(corpseMultipliers[key]) == "number" then
        mult = mult * corpseMultipliers[key]
    end

    return math.min(math.max(mult, 1.0), 100.0)
end

return {
    save = save,
    load = load,
    node_multiplier = node_multiplier,
    drop_multiplier = drop_multiplier,
    corpse_multiplier = corpse_multiplier,
}