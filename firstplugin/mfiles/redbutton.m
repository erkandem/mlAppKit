classdef redbutton < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
%        uif_redbutton  matlab.ui.Figure
        main_Panel     matlab.ui.container.Panel
        LAUNCHButton   matlab.ui.control.Button
    end

    
    properties (Access = private)

    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: LAUNCHButton
        function LAUNCHButtonPushed(app, event)
            msgbox('WooOOOOOooooosh!');
            [y, Sr] = audioread(fullfile(pwd(), 'static', 'audio', 'launch.mp3'));
            sound(y, Sr)
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function  createComponents(app,external_handle) % $_$ flipped 

            % Create uif_redbutton and hide until all components are created
%            app.uif_redbutton = uifigure('Visible', 'off');
%            app.uif_redbutton.Position = [1 1 1024 640];
%            app.uif_redbutton.Name = 'Ultra Mega Super Duper Bien App';

            % Create main_Panel
            app.main_Panel = uipanel(external_handle);
            app.main_Panel.Title = 'Do not Push the Red Button';
            app.main_Panel.Position = [1 1 1024 640];

            % Create LAUNCHButton
            app.LAUNCHButton = uibutton(app.main_Panel, 'push');
            app.LAUNCHButton.ButtonPushedFcn = createCallbackFcn(app, @LAUNCHButtonPushed, true);
            app.LAUNCHButton.BackgroundColor = [1 0 0];
            app.LAUNCHButton.FontSize = 26;
            app.LAUNCHButton.FontWeight = 'bold';
            app.LAUNCHButton.Position = [449 313 125 110];
            app.LAUNCHButton.Text = 'LAUNCH';

            % Show the figure after all components are created
%            app.uif_redbutton.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
            function app = redbutton(external_handle) % $_$ flipped 

            % Create UIFigure and components
             createComponents(app,external_handle) % $_$ flipped 

            % Register the app with App Designer
%            registerApp(app, app.uif_redbutton)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
%            delete(app.uif_redbutton)
        end
    end
end

