
local HttpService = game:GetService("HttpService")

local SaveManager = {} do
	SaveManager.Folder = "LinoriaLibSettings"
	SaveManager.Ignore = {}
	SaveManager.Parser = {
		Toggle = {
			Save = function(idx, object) 
				return { type = "Toggle", idx = idx, value = object.Value } 
			end,
			Load = function(idx, data)
				if Toggles[idx] then 
					Toggles[idx]:SetValue(data.value)
				end
			end,
		},
		Slider = {
			Save = function(idx, object)
				return { type = "Slider", idx = idx, value = tostring(object.Value) }
			end,
			Load = function(idx, data)
				if Options[idx] then 
					Options[idx]:SetValue(data.value)
				end
			end,
		},
		Dropdown = {
			Save = function(idx, object)
				return { type = "Dropdown", idx = idx, value = object.Value, mutli = object.Multi }
			end,
			Load = function(idx, data)
				if Options[idx] then 
					Options[idx]:SetValue(data.value)
				end
			end,
		},
		ColorPicker = {
			Save = function(idx, object)
				return { type = "ColorPicker", idx = idx, value = object.Value:ToHex(), transparency = object.Transparency }
			end,
			Load = function(idx, data)
				if Options[idx] then 
					Options[idx]:SetValueRGB(Color3.fromHex(data.value), data.transparency)
				end
			end,
		},
		KeyPicker = {
			Save = function(idx, object)
				return { type = "KeyPicker", idx = idx, mode = object.Mode, key = object.Value, keycode = object.KeyCode }
			end,
			Load = function(idx, data)
				if Options[idx] then 
					Options[idx]:SetValue({ data.key, data.mode, data.keycode })
				end
			end,
		},

		Input = {
			Save = function(idx, object)
				return { type = "Input", idx = idx, text = object.Value }
			end,
			Load = function(idx, data)
				if Options[idx] and type(data.text) == "string" then
					Options[idx]:SetValue(data.text)
				end
			end,
		},
	}

	function SaveManager:SetIgnoreIndexes(list)
		for _, key in next, list do
			self.Ignore[key] = true
		end
	end

	function SaveManager:SetFolder(folder)
		self.Folder = folder;
		self:BuildFolderTree()
	end

	function SaveManager:Save(name)
		if (not name) then
			return false, "no config file is selected"
		end

		local fullPath = self.Folder .. "/Settings/" .. name .. ".json"

		local data = {
			objects = {}
		}

		for idx, toggle in next, Toggles do
			if self.Ignore[idx] then continue end

			table.insert(data.objects, self.Parser[toggle.Type].Save(idx, toggle))
		end

		for idx, option in next, Options do
			if not self.Parser[option.Type] then continue end
			if self.Ignore[idx] then continue end

			table.insert(data.objects, self.Parser[option.Type].Save(idx, option))
		end	

		local success, encoded = pcall(HttpService.JSONEncode, HttpService, data)
		if not success then
			return false, "failed to encode data"
		end

		writefile(fullPath, encoded)
		return true
	end

	function SaveManager:Load(name)
		if (not name) then
			return false, "no config file is selected"
		end
		
		local file = self.Folder .. "/Settings/" .. name .. ".json"
		if not isfile(file) then return false, "invalid file" end

		local success, decoded = pcall(HttpService.JSONDecode, HttpService, readfile(file))
		if not success then return false, "decode error" end

		for _, option in next, decoded.objects do
			if self.Parser[option.type] then
				task.spawn(function() self.Parser[option.type].Load(option.idx, option) end)
			end
		end

		return true
	end

	function SaveManager:IgnoreThemeSettings()
		self:SetIgnoreIndexes({ 
			"BackgroundColor", "MainColor", "AccentColor", "OutlineColor", "FontColor",
			"ThemeManager_ThemeList", "ThemeManager_CustomThemeList", "ThemeManager_CustomThemeName",
		})
	end

	function SaveManager:BuildFolderTree()
		local paths = {
			self.Folder,
			self.Folder .. "/Themes",
			self.Folder .. "/Settings"
		}

		for i = 1, #paths do
			local str = paths[i]
			if not isfolder(str) then
				makefolder(str)
			end
		end
	end

	function SaveManager:RefreshConfigList()
        local list = listfiles(self.Folder .. "/Settings")
        local out = {}
    
        for _, file in ipairs(list) do
            if file:sub(-5) == ".json" then
                local filename = file:match("([^/\\]+)%.json$") 
                if filename then
                    table.insert(out, filename)
                end
            end
        end
    
        return out
    end    

	function SaveManager:SetLibrary(library)
		self.Library = library
	end

	function SaveManager:LoadAutoloadConfig()
		if isfile(self.Folder .. "/Settings/autoload.txt") then
			local name = readfile(self.Folder .. "/Settings/autoload.txt")

			local success, err = self:Load(name)
			if not success then
				return self.Library:Notify("Failed to load autoload config: " .. err)
			end

			self.Library:Notify(string.format("Auto loaded config %q", name))
		end
	end

	function SaveManager:BuildConfigSection(tab, side)
		assert(self.Library, "Must set SaveManager.Library")

		local section = tab:AddGroupbox({Name = "Config", Side = side})

		section:AddInput("SaveManager_ConfigName",    { Text = "Config name" })
		section:AddDropdown("SaveManager_ConfigList", { Text = "Config list", Values = self:RefreshConfigList(), AllowNull = true })

		section:AddDivider()

		section:AddButton("Create config", function()
			local name = Options.SaveManager_ConfigName.Value

			if name:gsub(" ", "") == "" then 
				return self.Library:Notify("Invalid config name (empty)", 2)
			end

			local success, err = self:Save(name)
			if not success then
				return self.Library:Notify("Failed to save config: " .. err)
			end

			self.Library:Notify(string.format("Created config %q", name))

			Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
			Options.SaveManager_ConfigList:SetValue(nil)
		end):AddButton("Load config", function()
			local name = Options.SaveManager_ConfigList.Value

			local success, err = self:Load(name)
			if not success then
				return self.Library:Notify("Failed to load config: " .. err)
			end

			self.Library:Notify(string.format("Loaded config %q", name))
		end)

		section:AddButton("Overwrite config", function()
			local name = Options.SaveManager_ConfigList.Value

			local success, err = self:Save(name)
			if not success then
				return self.Library:Notify("Failed to overwrite config: " .. err)
			end

			self.Library:Notify(string.format("Overwrote config %q", name))
		end)

		section:AddButton("Refresh list", function()
			Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
			Options.SaveManager_ConfigList:SetValue(nil)
		end)

		section:AddButton("Set as autoload", function()
			local name = Options.SaveManager_ConfigList.Value
			writefile(self.Folder .. "/Settings/autoload.txt", name)
			SaveManager.AutoloadLabel:SetText("Current autoload config: " .. name)
			self.Library:Notify(string.format("Set %q to auto load", name))
		end)

		SaveManager.AutoloadLabel = section:AddLabel("Current autoload config: none", true)

		if isfile(self.Folder .. "/Settings/autoload.txt") then
			local name = readfile(self.Folder .. "/Settings/autoload.txt")
			SaveManager.AutoloadLabel:SetText("Current autoload config: " .. name)
		end

		SaveManager:SetIgnoreIndexes({ "SaveManager_ConfigList", "SaveManager_ConfigName" })
	end

	SaveManager:BuildFolderTree()
end

return SaveManager
