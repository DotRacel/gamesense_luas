local enabled = ui.new_checkbox('MISC', 'Miscellaneous', '| AutoBot enabled')

local consts = {
    target_size       = 0,
    screen_size       = { x, y },
    commander_missing = false,
    commander         = nil
}

local items = {
    target        = ui.new_combobox('MISC', 'Miscellaneous', '| Target commander', "-"),
    teammate_only = ui.new_checkbox('MISC', 'Miscellaneous', '| Teammate only')
}

local utils = {
    get_entindex_for_name = function(name)
        for player=1, globals.maxplayers() do 
            local tmp_name = entity.get_player_name(player)
            if tmp_name == name then 
                return player 
            end
        end

        return nil
    end,

    table_contains = function(table, value)
        for _, v in pairs(table) do
            if(v == value) then return true end
        end

        return false
    end
}

local callbacks = {
    update_items = {function( ... )
        if not(ui.is_menu_open()) then return end

        local names     = {}
        local teammates = {}
        local enemies   = entity.get_players(true)

        for _, index in pairs(entity.get_players()) do
            if not(utils.table_contains(enemies, index)) then
                table.insert(teammates, index)
            end
        end

        for _, index in pairs(ui.get(items.teammate_only) and teammates or enemies) do 
            table.insert(names, entity.get_player_name(index))
        end

        local current_size = #names
        local current_sel  = ui.get(items.target)

        if(current_size == consts.target_size) then return end

        consts.target_size = current_size
        ui.set_visible(items.target, false)
        items.target = ui.new_combobox('MISC', 'Miscellaneous', '| Target commander', "-", unpack(names))

        if(current_sel ~= nil and current_sel ~= "-" and utils.get_entindex_for_name(current_sel) ~= nil) then
            ui.set(items.target, current_sel)
        end
    end, "setup_command"},

    follow_commander = {function(ctx)
        local commander = utils.get_entindex_for_name(ui.get(items.target))

        if(commander == nil) then
            consts.commander         = nil
            consts.commander_missing = true
            return
        else
            consts.commander         = commander
            consts.commander_missing = false
        end

        local loc_local_x, loc_local_y, loc_local_z             = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
        local loc_commander_x, loc_commander_y, loc_commander_z = entity.get_prop(commander, "m_vecOrigin")
        local distance                                          = { x = loc_local_x - loc_commander_x, y = loc_local_y - loc_commander_y }

    end, "setup_command"},

    render_status = {function(ctx)
        local x, y = consts.screen_size.x / 2, consts.screen_size.y / 2 - 300

        if(consts.commander_missing) then 
            renderer.text(x, y, 255, 0, 0, 255, '+cbd', 0, "Missing commander ...")
        else
            renderer.text(x, y, 255, 255, 255, 255, '+cbd', 0, "Being controlled by commander")
        end

    end, "paint"}
}

local function setup_callbacks()
    for _, object in pairs(callbacks) do
        client.set_event_callback(object[2], object[1])
    end
end

local function unsetup_callbacks()
    for _, object in pairs(callbacks) do
        client.unset_event_callback(object[2], object[1])
    end
end

local function setup_consts()
    local screen_x, screen_y = client.screen_size()
    consts.screen_size       = { x = screen_x, y = screen_y}
end

local function hide_menu_items(hide)
    for _, item in pairs(items) do
        ui.set_visible(item, hide)
    end
end

local function setup_masterswitch_callback()
    ui.set_callback(enabled, function(item)
        if(ui.get(item) == true) then
            setup_callbacks()
            hide_menu_items(true)
        else
            unsetup_callbacks()
            hide_menu_items(false)
        end
    end)
end

setup_consts()
hide_menu_items(false)
setup_masterswitch_callback()
