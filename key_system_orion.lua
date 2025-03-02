-- settings 
local limited_attempts = true
local attempts = 3
local user_input_attempts = 0
local destroy_library_after_entering_the_correct_key = true

-- key
local key = 'key'
local key_link = 'link'

-- library & window
local orion = loadstring(game:HttpGet"https://raw.githubusercontent.com/m1kp0/libraries/refs/heads/main/m1kpe0_orion_lib.lua")()
local window = orion:MakeWindow({Name = 'key System', HidePremium = false, SaveConfig = true, IntroText = 'welcome', ConfigFolder = 'OrionTest'})

-- functions
local function notify(title, content, time)
    orion:MakeNotification({
        Name = title,
        Content = content,
        Image = '',
        Time = time
    })
end

local function load_script()
    -- script here
    print('entered correct key!') --> example
end

-- key tab
local key_tab = window:MakeTab({Name = 'key', Icon = '', PremiumOnly = false})

-- key input
key_tab:AddTextbox({
	Name = 'enter key',
	Default = '',
	TextDisappear = true,
	Callback = function(e)
        if e == key then
            notify('correct key', 'entered correct key!\nloading script', 2) --> \n is enter
            if destroy_library_after_entering_the_correct_key then 
                task.wait(3) 
                library:Destroy() 
            end
            load_script()
        else
            if limited_attempts then
                user_input_attempts = user_input_attempts + 1
                if attempts - user_input_attempts <= 0 then 
                    game.Players.LocalPlayer:Kick('\n   [key system]: incorrect key')
                end
                notify('incorrect', 'entered incorrect key!\nyou have '..attempts - user_input_attempts..' attempts left!', 5)
            else
                notify('incorrect', 'entered incorrect key!', 5)
            end
        end
	end	  
})

-- copy key link button
key_tab:AddButton({
    Name = 'copy key link', 
    Callback = function()
        setclipboard(tostring(key_link))
        notify('copied', 'link copied to clipboard', 5)
    end
})

-- init
library:Init()
