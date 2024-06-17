local Jui = {}

-- Default theme
local defaultTheme = {
    BackgroundColor = Color3.fromRGB(30, 30, 30),
    TitleColor = Color3.fromRGB(255, 255, 255),
    ButtonColor = Color3.fromRGB(50, 50, 50),
    ButtonTextColor = Color3.fromRGB(255, 255, 255),
    ToggleColor = Color3.fromRGB(70, 70, 70),
    SliderColor = Color3.fromRGB(70, 70, 70),
    SliderButtonColor = Color3.fromRGB(90, 90, 90),
    OutlineColor = Color3.fromRGB(255, 255, 255)
}

-- Create main UI frame
function Jui:CreateWindow(title, theme)
    theme = theme or defaultTheme

    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
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
    MainFrame.ClipsDescendants = true
    MainFrame.BorderMode = Enum.BorderMode.Inset
    MainFrame.BorderSizePixel = 2
    MainFrame.BorderColor3 = theme.OutlineColor
    MainFrame.CornerRadius = UDim.new(0, 10)
    
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundColor3 = theme.BackgroundColor
    Title.BackgroundTransparency = 1.000
    Title.Size = UDim2.new(0, 400, 0, 25)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = title
    Title.TextColor3 = theme.TitleColor
    Title.TextSize = 20.000
    
    OpenCloseButton.Name = "OpenCloseButton"
    OpenCloseButton.Parent = ScreenGui
    OpenCloseButton.BackgroundColor3 = theme.ButtonColor
    OpenCloseButton.Position = UDim2.new(0, 385, 0, 10)
    OpenCloseButton.Size = UDim2.new(0, 25, 0, 25)
    OpenCloseButton.Font = Enum.Font.SourceSansBold
    OpenCloseButton.Text = "-"
    OpenCloseButton.TextColor3 = theme.ButtonTextColor
    OpenCloseButton.TextSize = 20.000
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
    TabsFrame.BorderMode = Enum.BorderMode.Inset
    TabsFrame.BorderSizePixel = 2
    TabsFrame.BorderColor3 = theme.OutlineColor
    TabsFrame.CornerRadius = UDim.new(0, 10)
    
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
        
        TabContent.Name = tabName .. "Content"
        TabContent.Parent = MainFrame
        TabContent.BackgroundColor3 = theme.BackgroundColor
        TabContent.BorderSizePixel = 0
        TabContent.Position = UDim2.new(0, 100, 0, 25)
        TabContent.Size = UDim2.new(1, -100, 1, -25)
        TabContent.Visible = false
        TabContent.BorderMode = Enum.BorderMode.Inset
        TabContent.BorderSizePixel = 2
        TabContent.BorderColor3 = theme.OutlineColor
        TabContent.CornerRadius = UDim.new(0, 10)
        
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
            Button.BorderMode = Enum.BorderMode.Inset
            Button.BorderSizePixel = 2
            Button.BorderColor3 = theme.OutlineColor
            Button.CornerRadius = UDim.new(0, 10)
            Button.MouseButton1Click:Connect(callback)
        end
        
        function Elements:CreateToggle(toggleName, callback)
            local Toggle = Instance.new("Frame")
            local ToggleButton = Instance.new("TextButton")
            
            Toggle.Parent = TabContent
            Toggle.BackgroundColor3 = theme.ButtonColor
            Toggle.Size = UDim2.new(0, 300, 0, 25)
            Toggle.BorderMode = Enum.BorderMode.Inset
            Toggle.BorderSizePixel = 2
            Toggle.BorderColor3 = theme.OutlineColor
            Toggle.CornerRadius = UDim.new(0, 10)
            
            ToggleButton.Parent = Toggle
            ToggleButton.BackgroundColor3 = theme.ToggleColor
            ToggleButton.Position = UDim2.new(0, 0, 0, 0)
            ToggleButton.Size = UDim2.new(0, 25, 1, 0)
            ToggleButton.Font = Enum.Font.SourceSansBold
            ToggleButton.Text = ""
            ToggleButton.TextColor3 = theme.ButtonTextColor
            ToggleButton.TextSize = 20.000
            ToggleButton.BorderMode = Enum.BorderMode.Inset
            ToggleButton.BorderSizePixel = 2
            ToggleButton.BorderColor3 = theme.OutlineColor
            ToggleButton.CornerRadius = UDim.new(0, 10)
            
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
            TextBox.BorderMode = Enum.BorderMode.Inset
            TextBox.BorderSizePixel = 2
            TextBox.BorderColor3 = theme.OutlineColor
            TextBox.CornerRadius = UDim.new(0, 10)
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
            Slider.BorderMode = Enum.BorderMode.Inset
            Slider.BorderSizePixel = 2
            Slider.BorderColor3 = theme.OutlineColor
            Slider.CornerRadius = UDim.new(0, 10)
            
            SliderBar.Parent = Slider
            SliderBar.BackgroundColor3 = theme.SliderColor
            SliderBar.Position = UDim2.new(0, 0, 0.5, -5)
            SliderBar.Size = UDim2.new(1, -50, 0, 10)
            SliderBar.BorderMode = Enum.BorderMode.Inset
            SliderBar.BorderSizePixel = 2
            SliderBar.BorderColor3 = theme.OutlineColor
            SliderBar.CornerRadius = UDim.new(0, 10)
            
            SliderButton.Parent = SliderBar
            SliderButton.BackgroundColor3 = theme.SliderButtonColor
            SliderButton.Size = UDim2.new(0, 10, 1, 0)
            SliderButton.Text = ""
            SliderButton.BorderMode = Enum.BorderMode.Inset
            SliderButton.BorderSizePixel = 2
            SliderButton.BorderColor3 = theme.OutlineColor
            SliderButton.CornerRadius = UDim.new(0, 10)
            
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = theme.ButtonColor
            SliderValue.Position = UDim2.new(1, -40, 0, 0)
            SliderValue.Size = UDim2.new(0, 40, 1, 0)
            SliderValue.Font = Enum.Font.SourceSans
            SliderValue.Text = min
            SliderValue.TextColor3 = theme.ButtonTextColor
            SliderValue.TextSize = 20.000
            SliderValue.BorderMode = Enum.BorderMode.Inset
            SliderValue.BorderSizePixel = 2
            SliderValue.BorderColor3 = theme.OutlineColor
            SliderValue.CornerRadius = UDim.new(0, 10)
            
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
                    SliderValue.Text = value
                    callback(value)
                end
            end)
        end
        
        return Elements
    end
    
    return Tabs
end

return Jui
