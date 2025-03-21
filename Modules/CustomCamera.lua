local Constants = require(script.Parent.Constants)
local UIController = require(script.Parent.UIController)


local CustomCamera = {}

local function radiansToDegrees(vector: Vector3): Vector3
	return Vector3.new(
		math.deg(vector.X),
		math.deg(vector.Y),
		math.deg(vector.Z)
	)
end

--[[
Creates a custom desk camera that copies the camera position and orientation in the Roblox Studio editor

args:
- defaultCamera: workspace.camera
- name: string
]]
function CustomCamera.new(defaultCamera: Camera, name: string)
	local cameraDir = workspace:FindFirstChild(Constants.CUSTOM_CAMERA_DIRECTORY_NAME)

	if not cameraDir then
		cameraDir = Instance.new("Folder")
		cameraDir.Name = Constants.CUSTOM_CAMERA_DIRECTORY_NAME
		cameraDir.Parent = workspace
	end

	if cameraDir:FindFirstChild(name) then
		UIController.showAlert(
			`A camera with the name "{name}" already exists.`,
			UIController.AlertLabelTypes.ERROR
		)
		return nil
	end

	local ID = 1 + (function()
		local maxID = 0
		for _, part in ipairs(cameraDir:GetChildren()) do
			maxID = math.max(maxID, part:GetAttribute(Constants.ID_ATTRIBUTE) or 0)
		end
		return maxID
	end)()

	local cameraPart = Instance.new("Part")
	cameraPart.Size = Constants.DEFAULT_CAMERA_PART_SIZE
	cameraPart.Anchored = true
	cameraPart.Position = defaultCamera.CFrame.Position

	local x, y, z = defaultCamera.CFrame.Rotation:ToOrientation()
	cameraPart.Orientation = radiansToDegrees(Vector3.new(x, y, z))
	cameraPart:SetAttribute(Constants.ID_ATTRIBUTE, ID)
	cameraPart.Parent = cameraDir
	cameraPart.Name = name

	UIController.showAlert(
		`Created {name} with ID: {ID}`,
		UIController.AlertLabelTypes.SUCCESS
	)

	return cameraPart
end

return CustomCamera