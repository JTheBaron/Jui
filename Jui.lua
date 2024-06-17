local Jui = {}

-- Create main UI frame
function Jui:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local OpenCloseButton = Instance.new("TextButton")
    local TabsFrame = Instance.new("Frame")
    
    ScreenGui.Name = "UILibrary"
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0, 10, 0, 10)
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.ClipsDescendants = true

    MainFrame:TweenSize(UDim2.new(0, 400, 0, 300), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Size = UDim2.new(0, 400, 0, 25)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20.000
    
    OpenCloseButton.Name = "OpenCloseButton"
    OpenCloseButton.Parent = MainFrame
    OpenCloseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    OpenCloseButton.Position = UDim2.new(1, -25, 0, 0)
    OpenCloseButton.Size = UDim2.new(0, 25, 0, 25)
    OpenCloseButton.Font = Enum.Font.SourceSansBold
    OpenCloseButton.Text = "-"
    OpenCloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenCloseButton.TextSize = 20.000
    OpenCloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)
    
    TabsFrame.Name = "TabsFrame"
    TabsFrame.Parent = MainFrame
    TabsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabsFrame.BorderSizePixel = 0
    TabsFrame.Position = UDim2.new(0, 0, 0, 25)
    TabsFrame.Size = UDim2.new(0, 100, 1, -25)
    
    local Tabs = {}
    function Tabs:CreateTab(tabName)
        local TabButton = Instance.new("TextButton")
        local TabContent = Instance.new("Frame")
        
        TabButton.Name = tabName
        TabButton.Parent = TabsFrame
        TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TabButton.Size = UDim2.new(1, 0, 0, 25)
        TabButton.Font = Enum.Font.SourceSansBold
        TabButton.Text = tabName
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 20.000
        
        TabContent.Name = tabName .. "Content"
        TabContent.Parent = MainFrame
        TabContent.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabContent.BorderSizePixel = 0
        TabContent.Position = UDim2.new(0, 100, 0, 25)
        TabContent.Size = UDim2.new(1, -100, 1, -25)
        TabContent.Visible = false
        
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
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Button.Size = UDim2.new(0, 300, 0, 25)
            Button.Font = Enum.Font.SourceSansBold
            Button.Text = buttonName
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 20.000
            Button.MouseButton1Click:Connect(callback)
        end
        
        function Elements:CreateToggle(toggleName, callback)
            local Toggle = Instance.new("Frame")
            local ToggleButton = Instance.new("TextButton")
            
            Toggle.Parent = TabContent
            Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Toggle.Size = UDim2.new(0, 300, 0, 25)
            
            ToggleButton.Parent = Toggle
            ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            ToggleButton.Position = UDim2.new(0, 0, 0, 0)
            ToggleButton.Size = UDim2.new(0, 25, 1, 0)
            ToggleButton.Font = Enum.Font.SourceSansBold
            ToggleButton.Text = ""
            ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleButton.TextSize = 20.000
            
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
            TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            TextBox.Size = UDim2.new(0, 300, 0, 25)
            TextBox.Font = Enum.Font.SourceSans
            TextBox.PlaceholderText = placeholderText
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 20.000
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
            Slider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Slider.Size = UDim2.new(0, 300, 0, 25)
            
            SliderBar.Parent = Slider
            SliderBar.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            SliderBar.Position = UDim2.new(0, 0, 0.5, -5)
            SliderBar.Size = UDim2.new(1, -50, 0, 10)
            
            SliderButton.Parent = SliderBar
            SliderButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
            SliderButton.Size = UDim2.new(0, 10, 1, 0)
            SliderButton.Text = ""
            
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SliderValue.Position = UDim2.new(1, -40, 0, 0)
            SliderValue.Size = UDim2.new(0, 40, 1, 0)
            SliderValue.Font = Enum.Font.SourceSans
            SliderValue.Text = min
            SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.TextSize = 20.000
            
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
