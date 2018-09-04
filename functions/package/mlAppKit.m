 classdef mlAppKit < matlab.apps.AppBase

     % Properties that correspond to app components
     properties (Access = public)
         mlAppToolKitUIFigure           matlab.ui.Figure
         Panel                          matlab.ui.container.Panel
         Panel_2                        matlab.ui.container.Panel
         BuildButton                    matlab.ui.control.Button
         BuildyourExistingProjectLabel  matlab.ui.control.Label
         Panel_3                        matlab.ui.container.Panel
         PackagethemFilesLabel          matlab.ui.control.Label
         PackageButton                  matlab.ui.control.Button
         Panel_4                        matlab.ui.container.Panel
         runthepackageLabel             matlab.ui.control.Label
         RunPackageButton               matlab.ui.control.Button
         Panel_5                        matlab.ui.container.Panel
         DirectoryEditFieldLabel        matlab.ui.control.Label
         DirectoryEditField             matlab.ui.control.EditField
         selecttheprojectdirectoryortypeitLabel  matlab.ui.control.Label
         BrowseButton                   matlab.ui.control.Button
         mlAppKitDashboardLabel         matlab.ui.control.Label
         Description                    matlab.ui.control.Label
         Panel_6                        matlab.ui.container.Panel
         runtheQucikStartWizardLabel    matlab.ui.control.Label
         WizardButton                   matlab.ui.control.Button
         Panel_7                        matlab.ui.container.Panel
         runsphinxmakeLabel             matlab.ui.control.Label
         makeButton                     matlab.ui.control.Button
     end


     methods (Access = private)

         function results = func(app)

         end

     end

     methods (Access = public)

         function results = mlappkit(app, project_path)

         %    current_path= pwd();
         %    cd(project_path)
         %    buildTheApp()
         %    cd
         %    cd(current_path)

             results = 0;

         end

     end


     methods (Access = private)

         % Code that executes after component creation
         function startupFcn(app)
             % reshape and center the current applucation window
            %--- Center window and apply target resultion
             value = '335x640'; % target resolution

             xPos = regexp(value,'x');
             d1 = str2double( value(  1     : xPos-1 )) ;
             d2 = str2double( value( xPos+1 : end    )) ;
             st = get(0,'ScreenSize');

             xDif = (st(3)-d1)/2;
             yDif = (st(4)-d2)/2;

             nSize=[xDif, yDif, d1, d2];
             app.mlAppToolKitUIFigure.Position = nSize;
             %--- Center window and apply target resultion
         end

         % Button pushed function: BrowseButton
         function BrowseButtonPushed(app, event)
             selpath = uigetdir;
             app.DirectoryEditField.Value = selpath;
         end

         % Button pushed function: BuildButton
         function BuildButtonPushed(app, event)
             cwd = app.DirectoryEditField.Value;
             cd(cwd)
             buildTheApp()
         end

         % Button pushed function: WizardButton
         function WizardButtonPushed(app, event)
             mlappkit_quickstart()
         end

         % Button pushed function: PackageButton
         function PackageButtonPushed(app, event)
             package_app()
         end

         % Button pushed function: makeButton
         function makeButtonPushed(app, event)
             %res = system('E:\e\Markets\gui\templates\mlAppSDK\docs\make html &')
             msgbox('Feature not built in yet')
         end
     end

     % App initialization and construction
     methods (Access = private)

         % Create UIFigure and components
         function createComponents(app)

             % Create mlAppToolKitUIFigure
             app.mlAppToolKitUIFigure = uifigure;
             app.mlAppToolKitUIFigure.Position = [1 1 335 640];
             app.mlAppToolKitUIFigure.Name = 'ml AppToolKit';

             % Create Panel
             app.Panel = uipanel(app.mlAppToolKitUIFigure);
             app.Panel.Position = [1 1 335 640];

             % Create Panel_2
             app.Panel_2 = uipanel(app.Panel);
             app.Panel_2.Position = [19 361 300 45];

             % Create BuildButton
             app.BuildButton = uibutton(app.Panel_2, 'push');
             app.BuildButton.ButtonPushedFcn = createCallbackFcn(app, @BuildButtonPushed, true);
             app.BuildButton.Position = [216 11 60 22];
             app.BuildButton.Text = 'Build';

             % Create BuildyourExistingProjectLabel
             app.BuildyourExistingProjectLabel = uilabel(app.Panel_2);
             app.BuildyourExistingProjectLabel.Position = [21 11 133 22];
             app.BuildyourExistingProjectLabel.Text = 'Build your Existing Project';

             % Create Panel_3
             app.Panel_3 = uipanel(app.Panel);
             app.Panel_3.Position = [18 272 300 41];

             % Create PackagethemFilesLabel
             app.PackagethemFilesLabel = uilabel(app.Panel_3);
             app.PackagethemFilesLabel.Position = [21 10 107 22];
             app.PackagethemFilesLabel.Text = 'Package the m-Files';

             % Create PackageButton
             app.PackageButton = uibutton(app.Panel_3, 'push');
             app.PackageButton.ButtonPushedFcn = createCallbackFcn(app, @PackageButtonPushed, true);
             app.PackageButton.Position = [216 10 60 22];
             app.PackageButton.Text = 'Package';

             % Create Panel_4
             app.Panel_4 = uipanel(app.Panel);
             app.Panel_4.Position = [18 211 300 43];

             % Create runthepackageLabel
             app.runthepackageLabel = uilabel(app.Panel_4);
             app.runthepackageLabel.Position = [21 10 87 22];
             app.runthepackageLabel.Text = 'run the package';

             % Create RunPackageButton
             app.RunPackageButton = uibutton(app.Panel_4, 'push');
             app.RunPackageButton.Position = [205 10 83 22];
             app.RunPackageButton.Text = 'Run Package';

             % Create Panel_5
             app.Panel_5 = uipanel(app.Panel);
             app.Panel_5.Position = [18 418 300 82];

             % Create DirectoryEditFieldLabel
             app.DirectoryEditFieldLabel = uilabel(app.Panel_5);
             app.DirectoryEditFieldLabel.HorizontalAlignment = 'right';
             app.DirectoryEditFieldLabel.Position = [6 8 50 22];
             app.DirectoryEditFieldLabel.Text = 'Directory';

             % Create DirectoryEditField
             app.DirectoryEditField = uieditfield(app.Panel_5, 'text');
             app.DirectoryEditField.Position = [71 8 224 22];

             % Create selecttheprojectdirectoryortypeitLabel
             app.selecttheprojectdirectoryortypeitLabel = uilabel(app.Panel_5);
             app.selecttheprojectdirectoryortypeitLabel.Position = [11 39 183 22];
             app.selecttheprojectdirectoryortypeitLabel.Text = 'select the project directory or type it';

             % Create BrowseButton
             app.BrowseButton = uibutton(app.Panel_5, 'push');
             app.BrowseButton.ButtonPushedFcn = createCallbackFcn(app, @BrowseButtonPushed, true);
             app.BrowseButton.Position = [211 39 62 22];
             app.BrowseButton.Text = 'Browse';

             % Create mlAppKitDashboardLabel
             app.mlAppKitDashboardLabel = uilabel(app.Panel);
             app.mlAppKitDashboardLabel.FontSize = 20;
             app.mlAppKitDashboardLabel.FontWeight = 'bold';
             app.mlAppKitDashboardLabel.Position = [24 605 209 25];
             app.mlAppKitDashboardLabel.Text = 'ml App Kit - Dashboard';

             % Create Description
             app.Description = uilabel(app.Panel);
             app.Description.Position = [21 552 254 27];
             app.Description.Text = {'keep it open notice that for certain operations you'; 'need to be in the project directory'};

             % Create Panel_6
             app.Panel_6 = uipanel(app.Panel);
             app.Panel_6.Position = [19 140 300 43];

             % Create runtheQucikStartWizardLabel
             app.runtheQucikStartWizardLabel = uilabel(app.Panel_6);
             app.runtheQucikStartWizardLabel.Position = [21 10 137 22];
             app.runtheQucikStartWizardLabel.Text = 'run the Qucik-Start Wizard';

             % Create WizardButton
             app.WizardButton = uibutton(app.Panel_6, 'push');
             app.WizardButton.ButtonPushedFcn = createCallbackFcn(app, @WizardButtonPushed, true);
             app.WizardButton.Position = [205 10 83 22];
             app.WizardButton.Text = 'Wizard';

             % Create Panel_7
             app.Panel_7 = uipanel(app.Panel);
             app.Panel_7.Position = [21 36 300 43];

             % Create runsphinxmakeLabel
             app.runsphinxmakeLabel = uilabel(app.Panel_7);
             app.runsphinxmakeLabel.Position = [21 10 88 22];
             app.runsphinxmakeLabel.Text = 'run sphinx make';

             % Create makeButton
             app.makeButton = uibutton(app.Panel_7, 'push');
             app.makeButton.ButtonPushedFcn = createCallbackFcn(app, @makeButtonPushed, true);
             app.makeButton.Position = [205 10 83 22];
             app.makeButton.Text = 'make';
         end
     end

     methods (Access = public)

         % Construct app
         function app = mlAppKit

             % Create and configure components
             createComponents(app)

             % Register the app with App Designer
             registerApp(app, app.mlAppToolKitUIFigure)

             % Execute the startup function
             runStartupFcn(app, @startupFcn)

             if nargout == 0
                 clear app
             end
         end

         % Code that executes before app deletion
         function delete(app)

             % Delete UIFigure when app is deleted
             delete(app.mlAppToolKitUIFigure)
         end
     end
 end