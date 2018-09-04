
classdef mlappkit_quickstart < matlab.apps.AppBase

     % Properties that correspond to app components
     properties (Access = public)
         mlAppKitQuickstartWizardUIFigure  matlab.ui.Figure
         container                      matlab.ui.container.Panel
         Panel                          matlab.ui.container.Panel
         ProjectNameEditFieldLabel      matlab.ui.control.Label
         ProjectNameEditField           matlab.ui.control.EditField
         ProjectFolderEditFieldLabel    matlab.ui.control.Label
         ProjectFolderEditField         matlab.ui.control.EditField
         BrowseButton                   matlab.ui.control.Button
         CreateButton                   matlab.ui.control.Button
         mlAppKitQuickstartWizardLabel  matlab.ui.control.Label
     end

     methods (Access = private)

         % Code that executes after component creation
         function startupFcn(app)
     projectnames = {'Muffin';
     'Oliver';
     'Boomer';
     'Pumpkin';
     'Molly';
     'Sebastian';
     'Callie';
     'Cupcake';
     'Spike';
     'Houdini';
     'Midnight';
     'Leo';
     'Frankie';
     'Jasmine';
     'Charlie';
     'Blackie';
     'Lola';
     'Daisy';
     'Belle';
     'Missy'};

     pindex = randi([1,numel(projectnames)],1);
     %randstr=dec2base(randi([1,35],5), 36)'

     app.ProjectNameEditField.Value = lower(projectnames{pindex});

     app.ProjectFolderEditField.Value =pwd();

         end

         % Button pushed function: BrowseButton
         function BrowseButtonPushed(app, event)
             dir_sel = uigetdir;
             if ~isempty(dir_sel)
                 app.ProjectFolderEditField.Value  = dir_sel;
             end

         end

         % Button pushed function: CreateButton
         function CreateButtonPushed(app, event)
             project_dir=fullfile(app.ProjectFolderEditField.Value, app.ProjectNameEditField.Value);

             mlappkit_quickstart_execution(project_dir)

             msgbox ( 'created!')
             %somefunctionWhichCreatesABoilerPlate
         end
     end

     % App initialization and construction
     methods (Access = private)

         % Create UIFigure and components
         function createComponents(app)

             % Create mlAppKitQuickstartWizardUIFigure
             app.mlAppKitQuickstartWizardUIFigure = uifigure;
             app.mlAppKitQuickstartWizardUIFigure.Position = [100 100 500 250];
             app.mlAppKitQuickstartWizardUIFigure.Name = 'mlAppKit Quickstart Wizard';

             % Create container
             app.container = uipanel(app.mlAppKitQuickstartWizardUIFigure);
             app.container.Position = [1 1 500 250];

             % Create Panel
             app.Panel = uipanel(app.container);
             app.Panel.Position = [5 5 490 240];

             % Create ProjectNameEditFieldLabel
             app.ProjectNameEditFieldLabel = uilabel(app.Panel);
             app.ProjectNameEditFieldLabel.HorizontalAlignment = 'right';
             app.ProjectNameEditFieldLabel.Position = [21 124 73 22];
             app.ProjectNameEditFieldLabel.Text = 'Project Name';

             % Create ProjectNameEditField
             app.ProjectNameEditField = uieditfield(app.Panel, 'text');
             app.ProjectNameEditField.Position = [101 124 180 22];

             % Create ProjectFolderEditFieldLabel
             app.ProjectFolderEditFieldLabel = uilabel(app.Panel);
             app.ProjectFolderEditFieldLabel.HorizontalAlignment = 'right';
             app.ProjectFolderEditFieldLabel.Position = [20 84 74 22];
             app.ProjectFolderEditFieldLabel.Text = 'Project Folder';

             % Create ProjectFolderEditField
             app.ProjectFolderEditField = uieditfield(app.Panel, 'text');
             app.ProjectFolderEditField.Position = [101 84 299 22];

             % Create BrowseButton
             app.BrowseButton = uibutton(app.Panel, 'push');
             app.BrowseButton.ButtonPushedFcn = createCallbackFcn(app, @BrowseButtonPushed, true);
             app.BrowseButton.Position = [414 84 54 22];
             app.BrowseButton.Text = 'Browse';

             % Create CreateButton
             app.CreateButton = uibutton(app.Panel, 'push');
             app.CreateButton.ButtonPushedFcn = createCallbackFcn(app, @CreateButtonPushed, true);
             app.CreateButton.FontSize = 18;
             app.CreateButton.FontWeight = 'bold';
             app.CreateButton.Position = [183 26 100 30];
             app.CreateButton.Text = 'Create';

             % Create mlAppKitQuickstartWizardLabel
             app.mlAppKitQuickstartWizardLabel = uilabel(app.Panel);
             app.mlAppKitQuickstartWizardLabel.FontSize = 20;
             app.mlAppKitQuickstartWizardLabel.FontWeight = 'bold';
             app.mlAppKitQuickstartWizardLabel.Position = [17 198 268 25];
             app.mlAppKitQuickstartWizardLabel.Text = 'ml App Kit - Quickstart Wizard';
         end
     end

     methods (Access = public)

         % Construct app
         function app = mlappkit_quickstart

             % Create and configure components
             createComponents(app)

             % Register the app with App Designer
             registerApp(app, app.mlAppKitQuickstartWizardUIFigure)

             % Execute the startup function
             runStartupFcn(app, @startupFcn)

             if nargout == 0
                 clear app
             end
         end

         % Code that executes before app deletion
         function delete(app)

             % Delete UIFigure when app is deleted
             delete(app.mlAppKitQuickstartWizardUIFigure)
         end
     end
 end
