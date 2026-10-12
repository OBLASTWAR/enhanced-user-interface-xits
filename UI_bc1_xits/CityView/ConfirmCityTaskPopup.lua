-- CONFIRM CITY TASK POPUP
-- This popup occurs when an action needs confirmation.

local CityAIFocusTypes = CityAIFocusTypes

local GenericPopup = function(popupInfo)
	local cityID	= popupInfo.Data1;
	local taskID	= popupInfo.Data2;
	local popupText	= popupInfo.Text or "";

	if taskID == TaskTypes.TASK_RAZE then
		popupText = Locale.ConvertTextKey("TXT_KEY_POPUP_ARE_YOU_SURE_RAZE");
	else
		popupText = popupText.."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_POPUP_ARE_YOU_SURE");
	end

	SetPopupText(popupText);

	-- Initialize 'yes' button.
	local OnYesClicked = function()

		-- Confirm action
		Network.SendDoTask( cityID, taskID, -1, -1, false, false, false, false );

		--set prod focus on city annex puppet
		if taskID == TaskTypes.TASK_ANNEX_PUPPET then
			Network.SendSetCityAIFocus(cityID,CityAIFocusTypes.CITY_AI_FOCUS_TYPE_PRODUCTION)	
			Network.SendUpdateCityCitizens(cityID)
		end
	end

	AddButton(Locale.ConvertTextKey("TXT_KEY_POPUP_YES"), OnYesClicked)
	AddButton(Locale.ConvertTextKey("TXT_KEY_POPUP_NO"), nil)

end

PopupLayouts[ButtonPopupTypes.BUTTONPOPUP_CONFIRM_CITY_TASK] = GenericPopup
--PopupLayouts[ButtonPopupTypes.BUTTONPOPUP_ANNEX_CITY] = genericpopup
