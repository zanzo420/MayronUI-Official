-- luacheck: ignore MayronUI self

local tk, db, _, _, _, L = MayronUI:GetCoreComponents();
local C_ConfigModule = MayronUI:ImportModule("Config");

C_ConfigModule.ConfigData =
{
    name = L["General"],
    id = 1,
    type = "category",
    children = {
        {   name = L["Enable Master Font"],
            tooltip = L["Uncheck to prevent MUI from changing the game font."],
            requiresRestart = true,
            dbPath = "global.core.changeGameFont",
            type = "check",
        },
        {   name = L["Display Lua Errors"],
            type = "check",
            GetValue = function()
                return tonumber(_G.GetCVar("ScriptErrors")) == 1;
            end,
            SetValue = function(value)
                if (value) then
                    _G.SetCVar("ScriptErrors","1");
                else
                    _G.SetCVar("ScriptErrors","0");
                end
            end
        },
        {   type = "divider"
        },
        {   name = L["Master Font"],
            type = "dropdown",
            options = tk.Constants.LSM:List("font"),
            dbPath = "global.core.font",
            requiresRestart = true,
            fontPicker = true,
        },
        {   type = "divider"
        },
        {   name = L["Set Theme Color"],
            type = "color",
            tooltip = L["Warning: This will NOT change the color of CastBars!"],
            dbPath = "profile.theme.color",
            requiresReload = true,
            SetValue = function(_, _, value)
                value.hex = tk.string.format('%02x%02x%02x', value.r * 255, value.g * 255, value.b * 255);
                db.profile.theme.color = value;
                db.profile["profile.bottomui.gradients"] = nil;
            end
        },
        {   name = L["Objective (Quest) Tracker"],
            type = "title"
        },
        {   name = "Enable",
            tooltip = L["Disable this to stop MUI from controlling the Objective Tracker."],
            type = "check",
            dbPath = "profile.sidebar.objective_tracker.enabled",
            module = "SideBar",
            requiresReload = true,
        },
        {   name = "Anchor to Side Bar",
            tooltip = "Anchor the Objective Tracker to the action bar container on the right side of the screen.",
            type = "check",
            dbPath = "profile.sidebar.objective_tracker.anchored_to_sidebars",
            module = "SideBar",
        },
        {   type = "divider",
        },
        {   name = L["Set Width"],
            type = "textfield",
            tooltip = L["Adjust the width of the Objective Tracker."].."\n\n"..
                        L["Default value is "].."250",
            dbPath = "profile.sidebar.objective_tracker.width",
            valueType = "number",
            module = "SideBar",
        },
        {   name = L["Set Height"],
            type = "textfield",
            tooltip = L["Adjust the height of the Objective Tracker."].."\n\n"..
                        L["Default value is "].."600",
            dbPath = "profile.sidebar.objective_tracker.height",
            valueType = "number",
            module = "SideBar",
        },
        {   name = L["X-Offset"],
            type = "textfield",
            tooltip = L["Adjust the horizontal positioning of the Objective Tracker."].."\n\n"..
                        L["Default value is "].."-30",
            dbPath = "profile.sidebar.objective_tracker.xOffset",
            valueType = "number",
            module = "SideBar",
        },
        {   name = L["Y-Offset"],
            type = "textfield",
            tooltip = L["Adjust the vertical positioning of the Objective Tracker."].."\n\n"..
                        L["Default value is "].."0",
            dbPath = "profile.sidebar.objective_tracker.yOffset",
            valueType = "number",
            module = "SideBar",
        }
    },
    {   name = L["Bottom UI Panels"],
        module = "BottomUI",
        type = "category",
        children = {
            {   name = L["General Options"],
                type = "title",
                padding_top = 0
            },
            {   name = L["Container Width"],
                type = "slider",
                tooltip = L["Adjust the width of the Bottom UI container."].."\n\n"..
                            L["Minimum value is "].."680".."\n\n"..
                            L["Default value is "].."750",
                step = 5,
                min = 680,
                max = 1200,
                dbPath = "profile.bottomui.width",
            },
            {   name = L["Unit Panels"],
                type = "title",
                padding_top = 0
            },
            {   name = L["Enable Unit Panels"],
                dbPath = "profile.bottomui.unit_panels.enabled",
                requiresReload = true,
                type = "check",
            },
            {   name = L["Symmetric Unit Panels"],
                tooltip = L["Previously called 'Classic Mode'."],
                type = "check",
                requiresReload = true,
                dbPath = "profile.bottomui.unit_panels.classicMode"
            },
            {   name = L["Allow MUI to Control Unit Frames"],
                tooltip = L["TT_MUI_CONTROL_SUF"],
                type = "check",
                requiresReload = true,
                dbPath = "profile.bottomui.unit_panels.control_SUF"
            },
            {   name = L["Allow MUI to Control Grid"],
                tooltip = L["TT_MUI_CONTROL_GRID"],
                type = "check",
                requiresReload = true,
                dbPath = "profile.bottomui.unit_panels.control_Grid"
            },
            {   type = "divider",
            },
            {   name = L["Unit Panel Width"],
                type = "slider",
                step = 5,
                min = 200,
                max = 550,
                tooltip = L["Adjust the width of the unit frame background panels."].."\n\n"..
                            L["Minimum value is "].."200".."\n\n"..
                            L["Default value is "].."325",
                dbPath = "profile.bottomui.unit_panels.unit_width",
            },
            {   name = L["Name Panels"],
                type = "title",
            },
            {   name = L["Width"],
                type = "slider",
                tooltip = L["Adjust the width of the unit name background panels."].."\n\n"..
                            L["Default value is "].."235",
                step = 5,
                min = 150,
                max = 350,
                dbPath = "profile.bottomui.unit_panels.unit_names.width",
            },
            {   name = L["Height"],
                type = "slider",
                tooltip = L["Adjust the height of the unit name background panels."].."\n\n"..
                            L["Default value is "].."20",
                step = 1,
                min = 16,
                max = 30,
                dbPath = "profile.bottomui.unit_panels.unit_names.height",
            },
            {   name = L["X-Offset"],
                type = "slider",
                tooltip = L["Move the unit name panels further in or out."].."\n\n"..
                            L["Default value is "].."24",
                step = 1,
                min = -100,
                max = 100,
                dbPath = "profile.bottomui.unit_panels.unit_names.xOffset",
            },
            {   name = L["Font Size"],
                type = "slider",
                tooltip = L["Set the font size of unit names."].."\n\n"..
                            L["Default value is "].."11",
                step = 1,
                min = 8,
                max = 18,
                dbPath = "profile.bottomui.unit_panels.unit_names.fontSize",
            },
            {   name = L["Target Class Colored"],
                type = "check",
                height = 50,
                dbPath = "profile.bottomui.unit_panels.unit_names.target_class_colored"
            },
            {   name = L["Action Bar Panel"],
                type = "title",
                padding_top = 0
            },
            {   name = L["Enable Action Bar Panel"],
                dbPath = "profile.bottomui.actionbar_panel.enabled",
                requiresReload = true,
                type = "check",
            },
            {   name = L["Animation Speed"],
                type = "slider",
                tooltip = L["The speed of the Expand and Retract transitions."].."\n\n"..
                            L["The higher the value, the quicker the speed."].."\n\n"..
                            L["Default value is "].."6",
                step = 1,
                min = 1,
                max = 10,
                dbPath = "profile.bottomui.actionbar_panel.animate_speed",
            },
            {   name = L["Retract Height"],
                tooltip = tk.Strings:Concat(
                    L["Set the height of the action bar panel when it\nis 'Retracted' to show 1 action bar row."],
                    "\n\n", L["Minimum value is "], "40", "\n\n", L["Default value is "], "44"),
                type = "textfield",
                valueType = "number",
                min = 40,
                dbPath = "profile.bottomui.actionbar_panel.retract_height"
            },
            {   name = L["Expand Height"],
                tooltip = tk.Strings:Concat(
                    L["Set the height of the action bar panel when it\nis 'Expanded' to show 2 action bar rows."],
                    "\n\n", L["Minimum value is "], "40", "\n\n", L["Default value is "], "80"),
                type = "textfield",
                valueType = "number",
                min = 40,
                dbPath = "profile.bottomui.actionbar_panel.expand_height"
            },
            {   type = "fontstring",
                content = "Modifier keys used to show Expand/Retract buttons:"
            },
            {   name = L["Control"],
                height = 40,
                min_width = true,
                type = "check",
                dbPath = "profile.bottomui.actionbar_panel.mod_key",
                GetValue = function(_, current_value)
                    return current_value:find("C");
                end,
                SetValue = function(dbPath, old_value, value)
                    value = value and "C";
                    if (not value) then
                        if (old_value:find("C")) then
                            value = old_value:gsub("C", "")
                        end
                    else
                        value = old_value..value;
                    end
                    db:SetPathValue(dbPath, value);
                end
            },
            {   name = L["Shift"],
                height = 40,
                min_width = true,
                type = "check",
                dbPath = "profile.bottomui.actionbar_panel.mod_key",
                GetValue = function(_, current_value)
                    return current_value:find("S");
                end,
                SetValue = function(dbPath, old_value, value)
                    value = value and "S";
                    if (not value) then
                        if (old_value:find("S")) then
                            value = old_value:gsub("S", "")
                        end
                    else
                        value = old_value..value;
                    end
                    db:SetPathValue(dbPath, value);
                end
            },
            {   name = L["Alt"],
                height = 40,
                min_width = true,
                type = "check",
                dbPath = "profile.bottomui.actionbar_panel.mod_key",
                GetValue = function(_, current_value)
                    return current_value:find("A");
                end,
                SetValue = function(dbPath, old_value, value) -- the path and the new value
                    value = value and "A";
                    if (not value) then
                        if (old_value:find("A")) then
                            value = old_value:gsub("A", "");
                        end
                    else
                        value = old_value..value;
                    end
                    db:SetPathValue(dbPath, value);
                end
            },
            {   name = L["SUF Portrait Gradient"],
                type = "title",
            },
            {   name = L["Enable Gradient Effect"],
                type = "check",
                tooltip = L["If the SUF Player or Target portrait bars are enabled, a class"].."\n"..
                            L["colored gradient will overlay it."],
                dbPath = "profile.bottomui.gradients.enabled"
            },
            {   name = L["Height"],
                type = "slider",
                tooltip = L["The height of the gradient effect."].."\n\n"..
                            L["Default value is "].."24",
                step = 1,
                min = 1,
                max = 50,
                width = 250,
                dbPath = "profile.bottomui.gradients.height",
            },
            {   type = "fontstring",
                content = L["Gradient Colors"],
                subtype = "header",
            },
            {   name = L["Start Color"],
                type = "color",
                width = 150,
                tooltip = L["What color the gradient should start as."],
                dbPath = "profile.bottomui.gradients.from",
            },
            {   name = L["End Color"],
                width = 150,
                tooltip = L["What color the gradient should change into."],
                type = "color",
                dbPath = "profile.bottomui.gradients.to",
            },
            {   name = L["Target Class Colored"],
                tooltip = L["TT_MUI_USE_TARGET_CLASS_COLOR"],
                type = "check",
                dbPath = "profile.bottomui.gradients.target_class_colored",
            },
            {   name = L["Bartender Action Bars"],
                type = "title",
            },
            {   name = L["Allow MUI to Control Selected Bartender Bars"],
                type = "check",
                tooltip = L["TT_MUI_CONTROL_BARTENDER"],
                dbPath = "profile.bottomui.actionbar_panel.bartender.control"
            },
            {   type = "fontstring",
                content = L["Row 1"],
                subtype = "header",
            },
            {   name = L["First Bartender Bar"],
                type = "dropdown",
                dbPath = "profile.bottomui.actionbar_panel.bartender[1]",
                options = {
                    "Bar 1",
                    "Bar 2",
                    "Bar 3",
                    "Bar 4",
                    "Bar 5",
                    "Bar 6",
                    "Bar 7",
                    "Bar 8",
                    "Bar 9",
                }
            },
            {   name = L["Second Bartender Bar"],
                dbPath = "profile.bottomui.actionbar_panel.bartender[2]",
                type = "dropdown",
                options = {
                    "Bar 1",
                    "Bar 2",
                    "Bar 3",
                    "Bar 4",
                    "Bar 5",
                    "Bar 6",
                    "Bar 7",
                    "Bar 8",
                    "Bar 9",
                }
            },
            {   type = "fontstring",
                content = L["Row 2"],
                subtype = "header",
            },
            {   name = L["First Bartender Bar"],
                dbPath = "profile.bottomui.actionbar_panel.bartender[3]",
                type = "dropdown",
                options = {
                    "Bar 1",
                    "Bar 2",
                    "Bar 3",
                    "Bar 4",
                    "Bar 5",
                    "Bar 6",
                    "Bar 7",
                    "Bar 8",
                    "Bar 9",
                }
            },
            {   name = L["Second Bartender Bar"],
                dbPath = "profile.bottomui.actionbar_panel.bartender[4]",
                type = "dropdown",
                options = {
                    "Bar 1",
                    "Bar 2",
                    "Bar 3",
                    "Bar 4",
                    "Bar 5",
                    "Bar 6",
                    "Bar 7",
                    "Bar 8",
                    "Bar 9",
                }
            },
            {   type = "loop",
                args = {"Artifact", "Reputation", "XP"},
                func = function(_, name)
                    local key = name:lower().."Bar";
                    local child = {
                        {   name = L[name].." "..L["Bar"],
                            type = "title",
                        },
                        {   name = L["Enabled"],
                            type = "check",
                            tooltip = L["Default value is "]..L["true"],
                            dbPath = "profile.bottomui."..key..".enabled",
                        },
                        {   name = L["Show Text"],
                            type = "check",
                            tooltip = L["Default value is "]..L["false"],
                            dbPath = "profile.bottomui."..key..".show_text",
                        },
                        {   name = L["Height"],
                            type = "slider",
                            step = 1,
                            min = 4,
                            max = 30,
                            tooltip = L["Default value is "].."8",
                            dbPath = "profile.bottomui."..key..".height",
                        },
                        {   name = L["Font Size"],
                            type = "slider",
                            step = 1,
                            min = 8,
                            max = 18,
                            tooltip = L["Default value is "].."10",
                            dbPath = "profile.bottomui."..key..".font_size",
                        },
                    };
                    return child;
                end
            },
        }
    },
    {   name = L["Side Bar"],
        type = "category",
        module = "SideBar",
        children =  {
            {   name = L["Width (With 1 Bar)"],
                type = "textfield",
                tooltip = L["Default value is "].."46",
                valueType = "number",
                dbPath = "profile.sidebar.retract_width"
            },
            {   name = L["Width (With 2 Bars)"],
                tooltip = L["Default value is "].."83",
                type = "textfield",
                valueType = "number",
                dbPath = "profile.sidebar.expand_width"
            },
            {   type = "divider",
            },
            {   name = L["Height"],
                tooltip = L["Default value is "].."486",
                type = "textfield",
                valueType = "number",
                dbPath = "profile.sidebar.height"
            },
            {   name = L["Y-Offset"],
                tooltip = L["Default value is "].."40",
                type = "textfield",
                valueType = "number",
                dbPath = "profile.sidebar.yOffset"
            },
            {   type = "divider",
            },
            {   name = L["Animation Speed"],
                type = "slider",
                tooltip = L["The speed of the Expand and Retract transitions."].."\n\n"..
                            L["The higher the value, the quicker the speed."].."\n\n"..
                            L["Default value is "].."6.",
                step = 1,
                min = 1,
                max = 10,
                width = 250,
                dbPath = "profile.sidebar.animate_speed"
            },
            {   name = L["Bartender Action Bars"],
                type = "title",
            },
            {   name = L["Allow MUI to Control Selected Bartender Bars"],
                type = "check",
                dbPath = "profile.sidebar.bartender.control",
                tooltip = L["TT_MUI_CONTROL_BARTENDER"],
            },
            {   type = "divider",
            },
            {   name = L["First Bartender Bar"],
                dbPath = "profile.sidebar.bartender[1]",
                type = "dropdown",
                options = {
                    "Bar 1",
                    "Bar 2",
                    "Bar 3",
                    "Bar 4",
                    "Bar 5",
                    "Bar 6",
                    "Bar 7",
                    "Bar 8",
                    "Bar 9",
                }
            },
            {   name = L["Second Bartender Bar"],
                dbPath = "profile.sidebar.bartender[2]",
                type = "dropdown",
                options = {
                    "Bar 1",
                    "Bar 2",
                    "Bar 3",
                    "Bar 4",
                    "Bar 5",
                    "Bar 6",
                    "Bar 7",
                    "Bar 8",
                    "Bar 9",
                }
            },
            {   name = L["Expand and Retract Buttons"],
                type = "title"
            },
            {   name = L["Hide in Combat"],
                type = "check",
                height = 60,
                dbPath = "profile.sidebar.buttons.hide_in_combat",
            },
            {   name = L["Show When"],
                type = "dropdown",
                dbPath = "profile.sidebar.buttons.show_when",
                options = {
                    L["Never"],
                    L["Always"],
                    L["On Mouse-over"]
                },
            },
            {   type = "divider",
            },
            {   name = L["Width"],
                type = "textfield",
                tooltip = L["Default value is "].."15",
                dbPath = "profile.sidebar.buttons.width",
                valueType = "number",
            },
            {   name = L["Height"],
                type = "textfield",
                tooltip = L["Default value is "].."100",
                dbPath = "profile.sidebar.buttons.height",
                valueType = "number",
            },
        }
    }
};