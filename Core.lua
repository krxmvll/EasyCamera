local UIController = require(script.Parent.Modules.UIController)
local CustomCamera = require(script.Parent.Modules.CustomCamera)

local toolbar = plugin:CreateToolbar("EasyCamera")

local cameraCreate = toolbar:CreateButton(
	"Create new camera", 
	"Creates a custom desk camera that copies the camera position and orientation in the Roblox Studio editor", 
	"rbxassetid://6125281125"
)

local function radiansToDegrees(vector: Vector3): Vector3
	return Vector3.new(
		math.deg(vector.X),
		math.deg(vector.Y),
		math.deg(vector.Z)
	)
end

if not workspace:FindFirstChild('CustomCameras') then
	local cameraDir = Instance.new('Folder')
	cameraDir.Name = 'CustomCameras'
	cameraDir.Parent = workspace
end

local info = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Left,
	false,
	false,
	200,
	300,
	150,
	150
)

local widget = plugin:CreateDockWidgetPluginGui(
	"EasyCamera", 
	info
)
widget.Title = 'EasyCamera | Create'

local CreateUI = script.Parent.UI.Background
CreateUI.Parent = widget

cameraCreate.Click:Connect(function()
	widget.Enabled = not widget.Enabled
	print(CreateUI.Parent)
end)

local CreateCamera = CreateUI.InteractionBox.CreateButton
local NameInput = CreateUI.InteractionBox.NameInput.TextBox

CreateCamera.Activated:Connect(function()
	if NameInput.Text == '' then
		UIController.showAlert(
			"Please enter name of camera",
			UIController.AlertLabelTypes.ERROR
		)
		return
	end

	local name = NameInput.Text

	local camera = CustomCamera.new(
		workspace.Camera,
		name
	)
	NameInput.Text = ''
end)
