local config = {
    delete = ui.reference("CONFIG", "Presets", "Delete"),
    save = ui.reference("CONFIG", "Presets", "Save"),
    reset = ui.reference("CONFIG", "Presets", "Reset"),
}

local function set_visible(boolean)
    for k, v in pairs(config) do
        ui.set_visible(v, boolean)
    end
end

local lock = ui.new_button("CONFIG", "Presets", "Unlock for 5s", function(this)
    ui.set_visible(this, false)
    set_visible(true)

    client.delay_call(5, function()
        ui.set_visible(this, true)
        set_visible(false)
    end)
end)

set_visible(false)
