classdef popup_about < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        uifpopup               matlab.ui.Figure
        AboutPanel             matlab.ui.container.Panel
        creditLabel            matlab.ui.control.Label
        linkedbutton           matlab.ui.control.Button
        allrightsreservedErkanDemiralayLabel  matlab.ui.control.Label
        HistoryTextAreaLabel   matlab.ui.control.Label
        HistoryTextArea        matlab.ui.control.TextArea
        FeedbackTextAreaLabel  matlab.ui.control.Label
        FeedbackTextArea       matlab.ui.control.TextArea
        ghbutton               matlab.ui.control.Button
    end

    methods (Access = private)

        % Button pushed function: linkedbutton
        function linkedbuttonPushed(app, event)
            % launch the system browser to open a (company/ project) specific webpage
            % 
            web('https://github.com/erkandem/');
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create uifpopup
            app.uifpopup = uifigure;
            app.uifpopup.AutoResizeChildren = 'off';
            app.uifpopup.Position = [100 100 640 480];
            app.uifpopup.Name = 'Settings';
            app.uifpopup.Resize = 'off';

            % Create AboutPanel
            app.AboutPanel = uipanel(app.uifpopup);
            app.AboutPanel.AutoResizeChildren = 'off';
            app.AboutPanel.Title = 'About';
            app.AboutPanel.Position = [1 1 640 480];

            % Create creditLabel
            app.creditLabel = uilabel(app.AboutPanel);
            app.creditLabel.Position = [151 28 251 22];
            app.creditLabel.Text = 'This file was created using an app template by ';

            % Create linkedbutton
            app.linkedbutton = uibutton(app.AboutPanel, 'push');
            app.linkedbutton.ButtonPushedFcn = createCallbackFcn(app, @linkedbuttonPushed, true);
            app.linkedbutton.Icon = 'linkedin-in.png';
            app.linkedbutton.Position = [451 8 31 22];
            app.linkedbutton.Text = '';

            % Create allrightsreservedErkanDemiralayLabel
            app.allrightsreservedErkanDemiralayLabel = uilabel(app.AboutPanel);
            app.allrightsreservedErkanDemiralayLabel.Position = [151 8 260 22];
            app.allrightsreservedErkanDemiralayLabel.Text = '© 2018 all rights reserved --- Erkan Demiralay';

            % Create HistoryTextAreaLabel
            app.HistoryTextAreaLabel = uilabel(app.AboutPanel);
            app.HistoryTextAreaLabel.HorizontalAlignment = 'center';
            app.HistoryTextAreaLabel.Position = [31 408 43 22];
            app.HistoryTextAreaLabel.Text = 'History';

            % Create HistoryTextArea
            app.HistoryTextArea = uitextarea(app.AboutPanel);
            app.HistoryTextArea.Position = [31 230 260 170];
            app.HistoryTextArea.Value = {'a) License Information'};

            % Create FeedbackTextAreaLabel
            app.FeedbackTextAreaLabel = uilabel(app.AboutPanel);
            app.FeedbackTextAreaLabel.Position = [386 398 55 22];
            app.FeedbackTextAreaLabel.Text = 'Feedback';

            % Create FeedbackTextArea
            app.FeedbackTextArea = uitextarea(app.AboutPanel);
            app.FeedbackTextArea.Position = [388 230 199 160];
            app.FeedbackTextArea.Value = {'a) email link'; 'b) in app email response'};

            % Create ghbutton
            app.ghbutton = uibutton(app.AboutPanel, 'push');
            app.ghbutton.Icon = 'github.png';
            app.ghbutton.Position = [411 8 31 22];
            app.ghbutton.Text = '';
        end
    end

    methods (Access = public)

        % Construct app
        function app = popup_about

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

