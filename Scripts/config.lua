-- !!! This file is not how you configure the mod !!!
-- Config files are generated after loading the mod for the first time
-- at AbioticFactor/Binaries/Win64/ResourceMultiplier_###.toml
-- (restart the game to apply changes)

local data = require("data")

-- if true enables extra print spam to help debug config save/load
local debugConfig = false

local function mk_multiplier_type(label, path, comments, copy1, copy2, copy3, copy4, copy5)
    local globalMultiplier = 1.0
    local multipliers = {}

    if debugConfig then
        multipliers = setmetatable({}, {
            __newindex = function(t, key, value)
                if type(key) ~= "string" then
                    print("Non-string key inserted into " .. label .. " multipliers:", key, "type:", type(key), "value:", value, "\n")
                    print(debug.traceback(), "\n")
                else
                    rawset(t, key, value)
                end
            end
        })
    end

    local function max_len(tbl)
        local max = 0
        for k,v in pairs(tbl) do
            max = math.max(max, v:len())
        end
        return max
    end

    local function dprint(msg)
        if debugConfig then
            print(msg)
        end
    end

    local function save()
        print("[ResourceMultiplier] Saving " .. path, "\n")

        local text = ""
        text = text .. "# This file lets you configure drop rates for " .. copy1 .. ".\n"
        text = text .. "# This includes " .. copy2 .. ".\n"
        text = text .. "# You will need to restart the game (or \"Restart All Mods\" in UE4SS gui) for changes to apply.\n"
        text = text .. "# (NOTE: this file is reformatted automatically after loading, changes other than editing numbers or adding new entries will be lost)\n"
        text = text .. "\n"
        text = text .. "# Global multiplier that affects ALL " .. copy3 .. " (cannot go below 1.0)\n"
        text = text .. ("global_multiplier = %f\n"):format(globalMultiplier)
        text = text .. "\n"

        text = text .. "# Multipliers for individual " .. copy4 .. " (cannot go below 1.0)\n"
        text = text .. "# (decimals are a chance to get the next integer up, eg. 1.5 means 50/50 chance to get 1x or 2x)\n"
        text = text .. "# The id used is printed to the UE4SS console when " .. copy5 .. ", so if there's missing ones you could add it to the list.\n"

        -- fill in edited entries

        dprint("[ResourceMultiplier] save " .. label .. " A\n")

        local keys = {}

        for k, _ in pairs(multipliers) do
            if type(k) == "string" then
                table.insert(keys, k)
            else
                print("[ResourceMultiplier] Ignoring non-string key in multipliers:", k, "\n")
            end
        end

        dprint("[ResourceMultiplier] save " .. label .. " B\n")

        table.sort(keys)

        dprint("[ResourceMultiplier] save " .. label .. " C\n")

        local formatted = {}

        for i = 1, #keys do
            local k = keys[i]
            table.insert(formatted, ("%s = %f"):format(k, multipliers[k]))
        end

        dprint("[ResourceMultiplier] save " .. label .. " D\n")

        local len = max_len(formatted)

        dprint("[ResourceMultiplier] save " .. label .. " E\n")

        for i = 1, #keys do
            local k = keys[i]
            local str = formatted[i]
            local v = comments[k]

            local pad = (" "):rep(len - str:len())

            if type(v) == "string" then
                text = text .. ("%s%s # %s\n"):format(str, pad, v)
            else
                text = text .. ("%s\n"):format(str)
            end
        end

        dprint("[ResourceMultiplier] save " .. label .. " F\n")

        if next(multipliers) ~= nil then
            text = text .. "\n"
        end

        dprint("[ResourceMultiplier] save " .. label .. " G\n")

        -- fill in any missing entries

        keys = {}

        for k, _ in pairs(comments) do
            if multipliers[k] == nil then
                table.insert(keys, k)
            end
        end

        dprint("[ResourceMultiplier] save " .. label .. " H\n")

        table.sort(keys)

        dprint("[ResourceMultiplier] save " .. label .. " I\n")

        formatted = {}

        for i = 1, #keys do
            table.insert(formatted, ("%s = %f"):format(keys[i], 1.0))
        end

        dprint("[ResourceMultiplier] save " .. label .. " J\n")

        len = max_len(formatted)

        dprint("[ResourceMultiplier] save " .. label .. " K\n")

        for i = 1, #keys do
            local k = keys[i]
            local str = formatted[i]
            local v = comments[k]

            local pad = (" "):rep(len - str:len())
            text = text .. ("%s%s # %s\n"):format(str, pad, v)
        end

        dprint("[ResourceMultiplier] save " .. label .. " L\n")

        local file, err, errno = io.open(path, "w")

        if file == nil then
            print("[ResourceMultiplier] " .. label .. " config failed to write:", err, errno, "\n")
            return
        end
        file:write(text)
        file:close()

        dprint("[ResourceMultiplier] save " .. label .. " done\n")
    end

    local function load()
        print("[ResourceMultiplier] Loading " .. path, "\n")

        local file, err, errno = io.open(path, "r")

        if file == nil then
            print("[ResourceMultiplier] " .. label .. " config failed to load:", err, errno, "\n")
            print("[ResourceMultiplier] Regenerating...", "\n")
            save()
            return
        end

        local text = file:read("*a")

        -- if file is empty, regenerate it
        if text == "" then
            print("[ResourceMultiplier] " .. label .. " config was empty, regenerating", "\n")
            file:close()
            save()
            return
        end

        for k,v in text:gmatch("([%w_]*)%s*=%s*([%d.]*)") do
            local maybeNum = tonumber(v)
            if maybeNum ~= nil then
                local n = math.min(math.max(maybeNum, 1.0), 100.0)
                if k == "global_multiplier" then
                    globalMultiplier = n
                else
                    if n ~= 1.0 or comments[k] == nil then
                        if type(k) == "string" then
                            multipliers[k] = n
                            print(k, n)
                        else
                            print("[ResourceMultiplier] Not inserting non-string key into " .. label .. " multipliers:", k, "\n")
                        end
                    end
                end
            end
        end

        file:close()

        save()
    end

    local function get(key)
        local mult = globalMultiplier

        if type(multipliers[key]) == "number" then
            mult = mult * multipliers[key]
        elseif type(key) == "string" and type(multipliers[key:lower()]) == "number" then -- extra check
            mult = mult * multipliers[key:lower()]
        end

        return math.min(math.max(mult, 1.0), 100.0)
    end

    return {
        save = save,
        load = load,
        get = get,
    }
end

-- multiplier types

local nodes = mk_multiplier_type(
    "nodes",
    "ResourceMultiplier_nodes.toml", -- not really full toml but we get syntax highlighting
    data.nodes_comments,
    -- header fill in the blanks
    "Resource Nodes",
    "crates, PCs, wall pipes, things like staplers/keyboards/cloth placed on tables, etc",
    "resource nodes",
    "node types",
    "a resource node drops loot"
)

local drops = mk_multiplier_type(
    "drops",
    "ResourceMultiplier_drops.toml",
    data.drops_comments,
    -- header fill in the blanks
    "NPC drops",
    "items that enemies drop immediately when killed (not items from chopping their corpse)",
    "NPC drops",
    "NPC types",
    "an NPC drops loot"
)

local corpses = mk_multiplier_type(
    "corpses",
    "ResourceMultiplier_corpses.toml",
    data.corpse_comments,
    -- header fill in the blanks
    "NPC corpses",
    "items that drop when an enemy's corpse is chopped",
    "NPC corpse drops",
    "NPC types",
    "an NPC corpse is destroyed"
)

-- exports

local function save()
    nodes.save()
    drops.save()
    corpses.save()
end

local function load()
    print("[ResourceMultiplier] Loading config...", "\n")

    nodes.load()
    drops.load()
    corpses.load()
end

return {
    save = save,
    load = load,
    node_multiplier = nodes.get,
    drop_multiplier = drops.get,
    corpse_multiplier = corpses.get,
}
