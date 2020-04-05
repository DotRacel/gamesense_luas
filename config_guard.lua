local config = {
    delete = ui.reference("CONFIG", "Presets", "Delete"),
    save = ui.reference("CONFIG", "Presets", "Save"),
    reset = ui.reference("CONFIG", "Presets", "Reset"),
}

local lock, status = ui.new_checkbox("CONFIG", "Presets", "Lock config"), database.read("lock_config")

if(status ~= nil) then ui.set(lock, status) end

local function set_visible(boolean)
    for k, v in pairs(config) do
        ui.set_visible(v, boolean)
    end
end

local function update_visibility()
    local locked = ui.get(lock)
    database.write("lock_config", locked)

    if(locked) then
        set_visible(false)
    else
        set_visible(true)
    end
end

update_visibility()
ui.set_callback(lock, update_visibility)
