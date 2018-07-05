classdef popup_settings < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        uifpopup            matlab.ui.Figure
        SettingsPopUpLabel  matlab.ui.control.Label
        CallButton          matlab.ui.control.Button
        CallforaUNSecurityCouncilMeetingLabel  matlab.ui.control.Label
        EditButton          matlab.ui.control.Button
        EdityourMeshuggeServicesAPILabel  matlab.ui.control.Label
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
            app.uifpopup.Position = [100 100 289 480];
            app.uifpopup.Name = 'Settings';
            app.uifpopup.Resize = 'off';

            % Create SettingsPopUpLabel
            app.SettingsPopUpLabel = uilabel(app.uifpopup);
            app.SettingsPopUpLabel.Position = [23 441 92 22];
            app.SettingsPopUpLabel.Text = 'Settings PopUp ';

            % Create CallButton
            app.CallButton = uibutton(app.uifpopup, 'push');
            app.CallButton.Position = [161 369 78 22];
            app.CallButton.Text = 'Call';

            % Create CallforaUNSecurityCouncilMeetingLabel
            app.CallforaUNSecurityCouncilMeetingLabel = uilabel(app.uifpopup);
            app.CallforaUNSecurityCouncilMeetingLabel.HorizontalAlignment = 'center';
            app.CallforaUNSecurityCouncilMeetingLabel.Position = [23 355 121 51];
            app.CallforaUNSecurityCouncilMeetingLabel.Text = {'Call for a UN Security'; ' Council Meeting'};

            % Create EditButton
            app.EditButton = uibutton(app.uifpopup, 'push');
            app.EditButton.ButtonPushedFcn = createCallbackFcn(app, @EditButtonPushed, true);
            app.EditButton.Position = [161 291 78 22];
            app.EditButton.Text = 'Edit';

            % Create EdityourMeshuggeServicesAPILabel
            app.EdityourMeshuggeServicesAPILabel = uilabel(app.uifpopup);
            app.EdityourMeshuggeServicesAPILabel.HorizontalAlignment = 'center';
            app.EdityourMeshuggeServicesAPILabel.Position = [17 277 134 51];
            app.EdityourMeshuggeServicesAPILabel.Text = {'Edit your '; 'Meshugge Services API'};
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

