classdef popup_settings < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        uifpopup            matlab.ui.Figure
        SettingsPopUpPanel  matlab.ui.container.Panel
        EditButton          matlab.ui.control.Button
        EdityourMeshuggeServicesAPILabel  matlab.ui.control.Label
        CallButton          matlab.ui.control.Button
        CallforaUNSecurityCouncilMeetingLabel  matlab.ui.control.Label
        Label               matlab.ui.control.Label
    end

    methods (Access = private)

        % Button pushed function: EditButton
        function EditButtonPushed(app, event)
        if exist('settings','dir') ~=7
            mkdir settings
        else
        
        end
        
        if ~exist('settings/meshuggeServicesAPI.txt','file')
            fid= fopen('settings/meshuggeServicesAPI.txt','w');
            fclose all;
            
            open('settings/meshuggeServicesAPI.txt');
            
        else
            
            open('settings/meshuggeServicesAPI.txt');
             
        end
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create uifpopup
            app.uifpopup = uifigure;
            app.uifpopup.AutoResizeChildren = 'off';
            app.uifpopup.Position = [100 100 289 360];
            app.uifpopup.Name = 'Settings';
            app.uifpopup.Resize = 'off';

            % Create SettingsPopUpPanel
            app.SettingsPopUpPanel = uipanel(app.uifpopup);
            app.SettingsPopUpPanel.AutoResizeChildren = 'off';
            app.SettingsPopUpPanel.Title = 'Settings PopUp ';
            app.SettingsPopUpPanel.Position = [1 -2 290 363];

            % Create EditButton
            app.EditButton = uibutton(app.SettingsPopUpPanel, 'push');
            app.EditButton.ButtonPushedFcn = createCallbackFcn(app, @EditButtonPushed, true);
            app.EditButton.Position = [170 37 78 22];
            app.EditButton.Text = 'Edit';

            % Create EdityourMeshuggeServicesAPILabel
            app.EdityourMeshuggeServicesAPILabel = uilabel(app.SettingsPopUpPanel);
            app.EdityourMeshuggeServicesAPILabel.HorizontalAlignment = 'center';
            app.EdityourMeshuggeServicesAPILabel.Position = [20 28 134 51];
            app.EdityourMeshuggeServicesAPILabel.Text = {'Edit your '; 'Meshugge Services API'};

            % Create CallButton
            app.CallButton = uibutton(app.SettingsPopUpPanel, 'push');
            app.CallButton.Position = [168 102 78 22];
            app.CallButton.Text = 'Call';

            % Create CallforaUNSecurityCouncilMeetingLabel
            app.CallforaUNSecurityCouncilMeetingLabel = uilabel(app.SettingsPopUpPanel);
            app.CallforaUNSecurityCouncilMeetingLabel.HorizontalAlignment = 'center';
            app.CallforaUNSecurityCouncilMeetingLabel.Position = [30 88 121 51];
            app.CallforaUNSecurityCouncilMeetingLabel.Text = {'Call for a UN Security'; ' Council Meeting'};

            % Create Label
            app.Label = uilabel(app.SettingsPopUpPanel);
            app.Label.Position = [42 201 206 98];
            app.Label.Text = {'This is  an example for a external app'; 'which might be related to the main app.'; ''; 'However, at some point we realized that'; 'the functionality is not essential and was'; 'moved to an external app to save'; 'some real estate.'};
        end
    end

    methods (Access = public)

        % Construct app
        function app = popup_settings

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.uifpopup)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.uifpopup)
        end
    end
end

