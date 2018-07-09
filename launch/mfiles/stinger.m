classdef stinger < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
%        uif_icbm         matlab.ui.Figure
        main_Panel       matlab.ui.container.Panel
        LAUNCHButton     matlab.ui.control.Button
        UIAxes           matlab.ui.control.UIAxes
        Button           matlab.ui.control.Button
        ButtonGroup      matlab.ui.container.ButtonGroup
        Button_2         matlab.ui.control.ToggleButton
        Button2          matlab.ui.control.ToggleButton
        Button3          matlab.ui.control.ToggleButton
        Tree             matlab.ui.container.Tree
        Node             matlab.ui.container.TreeNode
        Node2            matlab.ui.container.TreeNode
        Node3            matlab.ui.container.TreeNode
        Node4            matlab.ui.container.TreeNode
        EditField2Label  matlab.ui.control.Label
        EditField2       matlab.ui.control.NumericEditField
        EditField3Label  matlab.ui.control.Label
        EditField3       matlab.ui.control.EditField
        TabGroup         matlab.ui.container.TabGroup
        Tab              matlab.ui.container.Tab
        Label            matlab.ui.control.Label
        Tab2             matlab.ui.container.Tab
        EditFieldLabel   matlab.ui.control.Label
        EditField        matlab.ui.control.NumericEditField
        GaugeLabel       matlab.ui.control.Label
        Gauge            matlab.ui.control.NinetyDegreeGauge
        Gauge2Label      matlab.ui.control.Label
        Gauge2           matlab.ui.control.NinetyDegreeGauge
        LampLabel        matlab.ui.control.Label
        Lamp             matlab.ui.control.Lamp
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
        function createComponents(app)

            % Create uif_icbm
%            app.uif_icbm = uifigure;
%            app.uif_icbm.Position = [1 1 1024 640];
%            app.uif_icbm.Name = 'Ultra Mega Super Duper Bien App';

            % Create main_Panel
            app.main_Panel = uipanel(external_handle);
            app.main_Panel.Title = 'Stinger';
            app.main_Panel.Position = [1 1 1024 640];

            % Create LAUNCHButton
            app.LAUNCHButton = uibutton(app.main_Panel, 'push');
            app.LAUNCHButton.ButtonPushedFcn = createCallbackFcn(app, @LAUNCHButtonPushed, true);
            app.LAUNCHButton.BackgroundColor = [1 0 0];
            app.LAUNCHButton.FontSize = 26;
            app.LAUNCHButton.FontWeight = 'bold';
            app.LAUNCHButton.Position = [126 297 125 110];
            app.LAUNCHButton.Text = 'LAUNCH';

            % Create UIAxes
            app.UIAxes = uiaxes(app.main_Panel);
            title(app.UIAxes, 'Title')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            app.UIAxes.Position = [520 331 300 185];

            % Create Button
            app.Button = uibutton(app.main_Panel, 'push');
            app.Button.Position = [250 531 100 22];

            % Create ButtonGroup
            app.ButtonGroup = uibuttongroup(app.main_Panel);
            app.ButtonGroup.Title = 'Button Group';
            app.ButtonGroup.Position = [154 70 123 106];

            % Create Button_2
            app.Button_2 = uitogglebutton(app.ButtonGroup);
            app.Button_2.Text = 'Button';
            app.Button_2.Position = [11 53 100 22];
            app.Button_2.Value = true;

            % Create Button2
            app.Button2 = uitogglebutton(app.ButtonGroup);
            app.Button2.Text = 'Button2';
            app.Button2.Position = [11 32 100 22];

            % Create Button3
            app.Button3 = uitogglebutton(app.ButtonGroup);
            app.Button3.Text = 'Button3';
            app.Button3.Position = [11 11 100 22];

            % Create Tree
            app.Tree = uitree(app.main_Panel);
            app.Tree.Position = [850 107 150 300];

            % Create Node
            app.Node = uitreenode(app.Tree);
            app.Node.Text = 'Node';

            % Create Node2
            app.Node2 = uitreenode(app.Node);
            app.Node2.Text = 'Node2';

            % Create Node3
            app.Node3 = uitreenode(app.Node);
            app.Node3.Text = 'Node3';

            % Create Node4
            app.Node4 = uitreenode(app.Node);
            app.Node4.Text = 'Node4';

            % Create EditField2Label
            app.EditField2Label = uilabel(app.main_Panel);
            app.EditField2Label.HorizontalAlignment = 'right';
            app.EditField2Label.Position = [51 494 62 22];
            app.EditField2Label.Text = 'Edit Field2';

            % Create EditField2
            app.EditField2 = uieditfield(app.main_Panel, 'numeric');
            app.EditField2.Position = [128 494 100 22];

            % Create EditField3Label
            app.EditField3Label = uilabel(app.main_Panel);
            app.EditField3Label.HorizontalAlignment = 'right';
            app.EditField3Label.Position = [290 385 62 22];
            app.EditField3Label.Text = 'Edit Field3';

            % Create EditField3
            app.EditField3 = uieditfield(app.main_Panel, 'text');
            app.EditField3.Position = [367 385 100 22];

            % Create TabGroup
            app.TabGroup = uitabgroup(app.main_Panel);
            app.TabGroup.Position = [520 55 260 221];

            % Create Tab
            app.Tab = uitab(app.TabGroup);
            app.Tab.Title = 'Tab';

            % Create Label
            app.Label = uilabel(app.Tab);
            app.Label.Position = [153 131 35 22];

            % Create Tab2
            app.Tab2 = uitab(app.TabGroup);
            app.Tab2.Title = 'Tab2';

            % Create EditFieldLabel
            app.EditFieldLabel = uilabel(app.Tab2);
            app.EditFieldLabel.HorizontalAlignment = 'right';
            app.EditFieldLabel.Position = [77 151 56 22];
            app.EditFieldLabel.Text = 'Edit Field';

            % Create EditField
            app.EditField = uieditfield(app.Tab2, 'numeric');
            app.EditField.Position = [148 151 100 22];

            % Create GaugeLabel
            app.GaugeLabel = uilabel(app.main_Panel);
            app.GaugeLabel.HorizontalAlignment = 'center';
            app.GaugeLabel.Position = [374 171 42 22];
            app.GaugeLabel.Text = 'Gauge';

            % Create Gauge
            app.Gauge = uigauge(app.main_Panel, 'ninetydegree');
            app.Gauge.Position = [349 208 90 90];

            % Create Gauge2Label
            app.Gauge2Label = uilabel(app.main_Panel);
            app.Gauge2Label.HorizontalAlignment = 'center';
            app.Gauge2Label.Position = [72 144 48 22];
            app.Gauge2Label.Text = 'Gauge2';

            % Create Gauge2
            app.Gauge2 = uigauge(app.main_Panel, 'ninetydegree');
            app.Gauge2.Position = [51 181 90 90];

            % Create LampLabel
            app.LampLabel = uilabel(app.main_Panel);
            app.LampLabel.HorizontalAlignment = 'right';
            app.LampLabel.Position = [465 552 36 22];
            app.LampLabel.Text = 'Lamp';

            % Create Lamp
            app.Lamp = uilamp(app.main_Panel);
            app.Lamp.Position = [516 552 20 20];
        end
    end

    methods (Access = public)

        % Construct app
        function app = stinger

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
%            registerApp(app, app.uif_icbm)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
%            delete(app.uif_icbm)
        end
    end
end

