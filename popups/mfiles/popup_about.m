classdef popup_about < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        uifpopup               matlab.ui.Figure
        AboutPanel             matlab.ui.container.Panel
        creditLabel            matlab.ui.control.Label
        linkedbutton           matlab.ui.control.Button
        crLabel                matlab.ui.control.Label
        LicenseBoilerplateAppTextAreaLabel  matlab.ui.control.Label
        LicenseTextArea        matlab.ui.control.TextArea
        FeedbackTextAreaLabel  matlab.ui.control.Label
        AboutTextArea          matlab.ui.control.TextArea
        ghbutton               matlab.ui.control.Button
        mailButton             matlab.ui.control.Button
        linkToProject          matlab.ui.control.TextArea
    end

    methods (Access = private)

        % Button pushed function: linkedbutton
        function linkedbuttonPushed(app, event)
            % launch the system browser to open a (company/ project) specific webpage
            % 
            web('https://erkan.io');
        end

        % Button pushed function: mailButton
        function mailButtonButtonPushed(app, event)
            web('mailto:ed@erkan.io');
        end

        % Button pushed function: ghbutton
        function ghbuttonButtonPushed(app, event)
            web('https://github.com/erkandem');
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
            app.creditLabel.Text = 'This app was created using a template by ';

            % Create linkedbutton
            app.linkedbutton = uibutton(app.AboutPanel, 'push');
            app.linkedbutton.ButtonPushedFcn = createCallbackFcn(app, @linkedbuttonPushed, true);
            app.linkedbutton.Icon = 'ic_insert_link_black_48dp.png';
            app.linkedbutton.IconAlignment = 'center';
            app.linkedbutton.Position = [451 8 30 32];
            app.linkedbutton.Text = '';

            % Create crLabel
            app.crLabel = uilabel(app.AboutPanel);
            app.crLabel.Position = [151 8 260 22];
            app.crLabel.Text = '© 2018 all rights reserved --- Erkan Demiralay';

            % Create LicenseBoilerplateAppTextAreaLabel
            app.LicenseBoilerplateAppTextAreaLabel = uilabel(app.AboutPanel);
            app.LicenseBoilerplateAppTextAreaLabel.HorizontalAlignment = 'center';
            app.LicenseBoilerplateAppTextAreaLabel.Position = [55 220 134 22];
            app.LicenseBoilerplateAppTextAreaLabel.Text = 'License - Boilerplate App:';

            % Create LicenseTextArea
            app.LicenseTextArea = uitextarea(app.AboutPanel);
            app.LicenseTextArea.Position = [31 70 579 142];
            app.LicenseTextArea.Value = {'MIT License'; ''; 'Copyright (c) 2018 Erkan Demiralay'; ''; 'Permission is hereby granted, free of charge, to any person obtaining a copy'; 'of this software and associated documentation files (the "Software"), to deal'; 'in the Software without restriction, including without limitation the rights'; 'to use, copy, modify, merge, publish, distribute, sublicense, and/or sell'; 'copies of the Software, and to permit persons to whom the Software is'; 'furnished to do so, subject to the following conditions:'; ''; 'The above copyright notice and this permission notice shall be included in all'; 'copies or substantial portions of the Software.'; ''; 'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR'; 'IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,'; 'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE'; 'AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER'; 'LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,'; 'OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE'; 'SOFTWARE.'};

            % Create FeedbackTextAreaLabel
            app.FeedbackTextAreaLabel = uilabel(app.AboutPanel);
            app.FeedbackTextAreaLabel.Position = [31 408 55 22];
            app.FeedbackTextAreaLabel.Text = 'Feedback';

            % Create AboutTextArea
            app.AboutTextArea = uitextarea(app.AboutPanel);
            app.AboutTextArea.Editable = 'off';
            app.AboutTextArea.Position = [33 310 567 90];
            app.AboutTextArea.Value = {'This Project is based on mlAppKit.'; ''; 'mlAppKit was developed to bridge the gap between programmatic GUI design'; 'and the semi automatic drag and drop experience from MATLAB App Designer.'; 'The project is available at Github:'};

            % Create ghbutton
            app.ghbutton = uibutton(app.AboutPanel, 'push');
            app.ghbutton.ButtonPushedFcn = createCallbackFcn(app, @ghbuttonButtonPushed, true);
            app.ghbutton.Icon = 'github.png';
            app.ghbutton.IconAlignment = 'center';
            app.ghbutton.Position = [411 8 30 32];
            app.ghbutton.Text = '';

            % Create mailButton
            app.mailButton = uibutton(app.AboutPanel, 'push');
            app.mailButton.ButtonPushedFcn = createCallbackFcn(app, @mailButtonButtonPushed, true);
            app.mailButton.Icon = 'ic_email_48pt_3x.png';
            app.mailButton.IconAlignment = 'center';
            app.mailButton.Position = [491 8 30 32];
            app.mailButton.Text = '';

            % Create linkToProject
            app.linkToProject = uitextarea(app.AboutPanel);
            app.linkToProject.Editable = 'off';
            app.linkToProject.HorizontalAlignment = 'center';
            app.linkToProject.Position = [33 283 567 20];
            app.linkToProject.Value = {'https://github.com/erkandem/mlappkit'};
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

