local Jui = {}

-- Themes
local themes = {
    ghibli = {
        BackgroundColor = Color3.fromRGB(139, 69, 19),  -- Brown
        TitleColor = Color3.fromRGB(255, 255, 255),    -- White
        ButtonColor = Color3.fromRGB(34, 139, 34),     -- Green
        ButtonTextColor = Color3.fromRGB(255, 255, 255), -- White
        ToggleColor = Color3.fromRGB(34, 139, 34),     -- Green
        SliderColor = Color3.fromRGB(34, 139, 34),     -- Green
        SliderButtonColor = Color3.fromRGB(0, 100, 0), -- Dark Green
        OutlineColor = Color3.fromRGB(255, 255, 255)   -- White
    }
}

local function applyUICorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = instance
end

-- Create main UI frame
function Jui:CreateWindow(title, themeName)
    local theme = themes[themeName] or themes.ghibli

    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local OpenCloseButton = Instance.new("TextButton")
    local TabsFrame = Instance.new("Frame")
    
    ScreenGui.Name = "Jui"
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = theme.BackgroundColor
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0, 10, 0, 10)
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    applyUICorner(MainFrame, 10)
    
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = MainFrame
    TitleLabel.BackgroundColor3 = theme.BackgroundColor
    TitleLabel.BackgroundTransparency = 1.000
    TitleLabel.Size = UDim2.new(0, 400, 0, 25)
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = theme.TitleColor
    TitleLabel.TextSize = 20.000
    
    OpenCloseButton.Name = "OpenCloseButton"
    OpenCloseButton.Parent = ScreenGui
    OpenCloseButton.BackgroundColor3 = theme.ButtonColor
    OpenCloseButton.Position = UDim2.new(0, 385, 0, 10)
    OpenCloseButton.Size = UDim2.new(0, 25, 0, 25)
    OpenCloseButton.Font = Enum.Font.SourceSansBold
    OpenCloseButton.Text = "-"
    OpenCloseButton.TextColor3 = theme.ButtonTextColor
    OpenCloseButton.TextSize = 20.000
    applyUICorner(OpenCloseButton, 5)
    OpenCloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
        if MainFrame.Visible then
            OpenCloseButton.Text = "-"
        else
            OpenCloseButton.Text = "+"
        end
    end)
    
    TabsFrame.Name = "TabsFrame"
    TabsFrame.Parent = MainFrame
    TabsFrame.BackgroundColor3 = theme.BackgroundColor
    TabsFrame.BorderSizePixel = 0
    TabsFrame.Position = UDim2.new(0, 0, 0, 25)
    TabsFrame.Size = UDim2.new(0, 100, 1, -25)
    applyUICorner(TabsFrame, 10)
    
    local Tabs = {}
    function Tabs:CreateTab(tabName)
        local TabButton = Instance.new("TextButton")
        local TabContent = Instance.new("Frame")
        
        TabButton.Name = tabName
        TabButton.Parent = TabsFrame
        TabButton.BackgroundColor3 = theme.ButtonColor
        TabButton.Size = UDim2.new(1, 0, 0, 25)
        TabButton.Font = Enum.Font.SourceSansBold
        TabButton.Text = tabName
        TabButton.TextColor3 = theme.ButtonTextColor
        TabButton.TextSize = 20.000
        applyUICorner(TabButton, 5)
        
        TabContent.Name = tabName .. "Content"
        TabContent.Parent = MainFrame
        TabContent.BackgroundColor3 = theme.BackgroundColor
        TabContent.BorderSizePixel = 0
        TabContent.Position = UDim2.new(0, 100, 0, 25)
        TabContent.Size = UDim2.new(1, -100, 1, -25)
        TabContent.Visible = false
        applyUICorner(TabContent, 10)
        
        TabButton.MouseButton1Click:Connect(function()
            for _, content in pairs(MainFrame:GetChildren()) do
                if content:IsA("Frame") and content ~= TabsFrame then
                    content.Visible = false
                end
            end
            TabContent.Visible = true
        end)
        
        local Elements = {}
        function Elements:CreateButton(buttonName, callback)
            local Button = Instance.new("TextButton")
            Button.Parent = TabContent
            Button.BackgroundColor3 = theme.ButtonColor
            Button.Size = UDim2.new(0, 300, 0, 25)
            Button.Font = Enum.Font.SourceSansBold
            Button.Text = buttonName
            Button.TextColor3 = theme.ButtonTextColor
            Button.TextSize = 20.000
            applyUICorner(Button, 5)
            Button.MouseButton1Click:Connect(callback)
        end
        
        function Elements:CreateToggle(toggleName, callback)
            local Toggle = Instance.new("Frame")
            local ToggleButton = Instance.new("TextButton")
            
            Toggle.Parent = TabContent
            Toggle.BackgroundColor3 = theme.ButtonColor
            Toggle.Size = UDim2.new(0, 300, 0, 25)
            applyUICorner(Toggle, 5)
            
            ToggleButton.Parent = Toggle
            ToggleButton.BackgroundColor3 = theme.ToggleColor
            ToggleButton.Position = UDim2.new(0, 0, 0, 0)
            ToggleButton.Size = UDim2.new(0, 25, 1, 0)
            ToggleButton.Font = Enum.Font.SourceSansBold
            ToggleButton.Text = ""
            ToggleButton.TextColor3 = theme.ButtonTextColor
            ToggleButton.TextSize = 20.000
            applyUICorner(ToggleButton, 5)
            
            local toggled = false
            ToggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                if toggled then
                    ToggleButton.Position = UDim2.new(1, -25, 0, 0)
                else
                    ToggleButton.Position = UDim2.new(0, 0, 0, 0)
                end
                callback(toggled)
            end)
        end
        
        function Elements:CreateTextbox(placeholderText, callback)
            local TextBox = Instance.new("TextBox")
            TextBox.Parent = TabContent
            TextBox.BackgroundColor3 = theme.ButtonColor
            TextBox.Size = UDim2.new(0, 300, 0, 25)
            TextBox.Font = Enum.Font.SourceSans
            TextBox.PlaceholderText = placeholderText
            TextBox.Text = ""
            TextBox.TextColor3 = theme.ButtonTextColor
            TextBox.TextSize = 20.000
            applyUICorner(TextBox, 5)
            TextBox.FocusLost:Connect(function()
                callback(TextBox.Text)
            end)
        end
        
        function Elements:CreateSlider(sliderName, min, max, callback)
            local Slider = Instance.new("Frame")
            local SliderBar = Instance.new("Frame")
            local SliderButton = Instance.new("TextButton")
            local SliderValue = Instance.new("TextLabel")
            
            Slider.Parent = TabContent
            Slider.BackgroundColor3 = theme.ButtonColor
            Slider.Size = UDim2.new(0, 300, 0, 25)
            applyUICorner(Slider, 5)
            
            SliderBar.Parent = Slider
            SliderBar.BackgroundColor3 = theme.SliderColor
            SliderBar.Position = UDim2.new(0, 0, 0.5, -5)
            SliderBar.Size = UDim2.new(1, -50, 0, 10)
            applyUICorner(SliderBar, 5)
            
            SliderButton.Parent = SliderBar
            SliderButton.BackgroundColor3 = theme.SliderButtonColor
            SliderButton.Size = UDim2.new(0, 10, 1, 0)
            SliderButton.Text = ""
            applyUICorner(SliderButton, 5)
            
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = theme.ButtonColor
            SliderValue.Position = UDim2.new(1, -40, 0, 0)
            SliderValue.Size = UDim2.new(0, 40, 1, 0)
            SliderValue.Font = Enum.Font.SourceSans
            SliderValue.Text = tostring(min)
            SliderValue.TextColor3 = theme.ButtonTextColor
            SliderValue.TextSize = 20.000
            applyUICorner(SliderValue, 5)
            
            local sliding = false
            SliderButton.MouseButton1Down:Connect(function()
                sliding = true
            end)
            game:GetService("UserInputService").InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    sliding = false
                end
            end)
            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local mousePos = game:GetService("UserInputService"):GetMouseLocation().X - SliderBar.AbsolutePosition.X
                    local sliderValue = math.clamp(mousePos / SliderBar.AbsoluteSize.X, 0, 1)
                    SliderButton.Position = UDim2.new(sliderValue, -5, 0, 0)
                    local value = math.floor(sliderValue * (max - min) + min)
                    SliderValue.Text = tostring(value)
                    callback(value)
                end
            end)
        end
        
        return Elements
    end
    
    return Tabs
end

return Jui
