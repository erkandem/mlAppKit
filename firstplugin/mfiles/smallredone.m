classdef smallredone < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
%        uif_smallredone  matlab.ui.Figure
        main_Panel       matlab.ui.container.Panel
        LAUNCHButton     matlab.ui.control.Button
    end

    
    properties (Access = private)

    end
    

    methods (Access = private)

        % Button pushed function: LAUNCHButton
        function LAUNCHButtonPushed(app, event)
            msgbox('WooOOOOOooooosh!');            
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function  createComponents(app,external_handle) % $_$ flipped 

            % Create uif_smallredone
%            app.uif_smallredone = uifigure;
%            app.uif_smallredone.Position = [1 1 1024 640];
%            app.uif_smallredone.Name = 'Ultra Mega Super Duper Bien App';

            % Create main_Panel
            app.main_Panel = uipanel(external_handle);
            app.main_Panel.Title = 'Small Red One';
            app.main_Panel.Position = [1 1 1024 640];

            % Create LAUNCHButton
            app.LAUNCHButton = uibutton(app.main_Panel, 'push');
            app.LAUNCHButton.ButtonPushedFcn = createCallbackFcn(app, @LAUNCHButtonPushed, true);
            app.LAUNCHButton.BackgroundColor = [1 0 0];
            app.LAUNCHButton.FontSize = 26;
            app.LAUNCHButton.FontWeight = 'bold';
            app.LAUNCHButton.Position = [721 290 125 60];
            app.LAUNCHButton.Text = 'LAUNCH';
        end
    end

    methods (Access = public)

        % Construct app
            function app = smallredone(external_handle) % $_$ flipped 

            % Create and configure components
             createComponents(app,external_handle) % $_$ flipped 

            % Register the app with App Designer
%            registerApp(app, app.uif_smallredone)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
%            delete(app.uif_smallredone)
        end
    end
end

