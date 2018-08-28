classdef popup_about < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        uifpopup              matlab.ui.Figure
        AboutPanel            matlab.ui.container.Panel
        creditLabel           matlab.ui.control.Label
        epsilonIndButton      matlab.ui.control.Button
        AllrightsreservedEpsilonIndustriesLabel  matlab.ui.control.Label
        HistoryTextAreaLabel  matlab.ui.control.Label
        HistoryTextArea       matlab.ui.control.TextArea
        HeadingTextAreaLabel  matlab.ui.control.Label
        HeadingTextArea       matlab.ui.control.TextArea
    end

    methods (Access = private)

        % Button pushed function: epsilonIndButton
        function epsilonIndButtonPushed(app, event)
            % launch the system browser to open a (company/ project) specific webpage
            % 
            web('https://duckduckgo.com');
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
            app.creditLabel.Position = [121 38 251 22];
            app.creditLabel.Text = 'This file was created using a app template by ';

            % Create epsilonIndButton
            app.epsilonIndButton = uibutton(app.AboutPanel, 'push');
            app.epsilonIndButton.ButtonPushedFcn = createCallbackFcn(app, @epsilonIndButtonPushed, true);
            app.epsilonIndButton.Position = [371 38 111 22];
            app.epsilonIndButton.Text = 'epsilon indiustries';

            % Create AllrightsreservedEpsilonIndustriesLabel
            app.AllrightsreservedEpsilonIndustriesLabel = uilabel(app.AboutPanel);
            app.AllrightsreservedEpsilonIndustriesLabel.Position = [151 8 260 22];
            app.AllrightsreservedEpsilonIndustriesLabel.Text = '© 2018 All rights reserved --- Epsilon Industries';

            % Create HistoryTextAreaLabel
            app.HistoryTextAreaLabel = uilabel(app.AboutPanel);
            app.HistoryTextAreaLabel.HorizontalAlignment = 'right';
            app.HistoryTextAreaLabel.Position = [31 408 43 22];
            app.HistoryTextAreaLabel.Text = 'History';

            % Create HistoryTextArea
            app.HistoryTextArea = uitextarea(app.AboutPanel);
            app.HistoryTextArea.Position = [31 120 199 280];
            app.HistoryTextArea.Value = {' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut placerat ligula quis elit aliquam facilisis. Morbi et augue mattis arcu dictum vehicula. Nulla in malesuada eros. Nulla quis consectetur leo, et tristique ligula. Proin congue sem nisl, in pharetra elit maximus sed. Aenean ac velit eget lorem ultricies pellentesque. Nullam sed felis turpis. Cras efficitur sit amet tortor quis consectetur. Sed accumsan bibendum ante, sed sollicitudin metus semper id.'; 'ä ö ü ß'; 'Donec pulvinar leo ut augue viverra, a congue arcu accumsan. Aliquam feugiat enim non venenatis eleifend. Phasellus sodales interdum congue. Morbi efficitur diam nec rutrum sagittis. Phasellus imperdiet tempor porttitor. Cras consectetur porttitor dolor, id consectetur erat vestibulum non. Suspendisse vel sodales nulla, eu viverra diam. Nunc massa nisl, interdum eget ex id, consequat placerat tortor.'; ''; 'Nullam purus mi, iaculis eget metus sed, mollis aliquet diam. Donec id aliquam tellus. Nulla sed sapien velit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed quis tortor malesuada, aliquet ligula non, pellentesque felis. Maecenas vehicula eros nulla, vel pharetra ligula dignissim sit amet. Donec mollis metus at est aliquam, a vulputate mi pretium. Proin quis nulla sit amet arcu congue efficitur in aliquet mi. Vivamus tempor tincidunt velit sit amet blandit. Ut et interdum risus. Vestibulum eu lectus urna. Praesent in pharetra ex, et tempor leo. Praesent rhoncus mollis lorem non egestas. Praesent sit amet orci commodo, finibus erat sed, feugiat orci. Quisque odio velit, aliquam vestibulum ullamcorper id, imperdiet sed lorem. '};

            % Create HeadingTextAreaLabel
            app.HeadingTextAreaLabel = uilabel(app.AboutPanel);
            app.HeadingTextAreaLabel.HorizontalAlignment = 'right';
            app.HeadingTextAreaLabel.Position = [381 398 50 22];
            app.HeadingTextAreaLabel.Text = 'Heading';

            % Create HeadingTextArea
            app.HeadingTextArea = uitextarea(app.AboutPanel);
            app.HeadingTextArea.Position = [388 110 199 280];
            app.HeadingTextArea.Value = {' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut placerat ligula quis elit aliquam facilisis. Morbi et augue mattis arcu dictum vehicula. Nulla in malesuada eros. Nulla quis consectetur leo, et tristique ligula. Proin congue sem nisl, in pharetra elit maximus sed. Aenean ac velit eget lorem ultricies pellentesque. Nullam sed felis turpis. Cras efficitur sit amet tortor quis consectetur. Sed accumsan bibendum ante, sed sollicitudin metus semper id.'; ''; 'Donec pulvinar leo ut augue viverra, a congue arcu accumsan. Aliquam feugiat enim non venenatis eleifend. Phasellus sodales interdum congue. Morbi efficitur diam nec rutrum sagittis. Phasellus imperdiet tempor porttitor. Cras consectetur porttitor dolor, id consectetur erat vestibulum non. Suspendisse vel sodales nulla, eu viverra diam. Nunc massa nisl, interdum eget ex id, consequat placerat tortor.'; ''; 'Nullam purus mi, iaculis eget metus sed, mollis aliquet diam. Donec id aliquam tellus. Nulla sed sapien velit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed quis tortor malesuada, aliquet ligula non, pellentesque felis. Maecenas vehicula eros nulla, vel pharetra ligula dignissim sit amet. Donec mollis metus at est aliquam, a vulputate mi pretium. Proin quis nulla sit amet arcu congue efficitur in aliquet mi. Vivamus tempor tincidunt velit sit amet blandit. Ut et interdum risus. Vestibulum eu lectus urna. Praesent in pharetra ex, et tempor leo. Praesent rhoncus mollis lorem non egestas. Praesent sit amet orci commodo, finibus erat sed, feugiat orci. Quisque odio velit, aliquam vestibulum ullamcorper id, imperdiet sed lorem. '};
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

