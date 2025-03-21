local Constants = require(script.Parent.Constants)

local UIController = {}

export type InfoLabelType = {
	name: string,
	color: Color3
}

UIController.AlertLabelTypes = {
	ERROR = {
		name = 'error',
		color = Constants.UI_ALERT_COLORS.ERROR
	} ::InfoLabelType,
	INFO = {
		name = 'info',
		color = Constants.UI_ALERT_COLORS.INFO
	} ::InfoLabelType,
	SUCCESS = {
		name = 'success',
		color = Constants.UI_ALERT_COLORS.SUCCESS
	} ::InfoLabelType,
}

local AlertLabel = script.Parent.Parent.UI.Background.InteractionBox.AlertLabel.TextLabel

function UIController.showAlert(message: string, labelType: InfoLabelType)
	AlertLabel.Text = `[{labelType.name}] {message}` 
	AlertLabel.TextColor3 = labelType.color
	
	wait(5)
	
	AlertLabel.Text = ''
end

return UIController

