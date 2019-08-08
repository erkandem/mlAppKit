classdef host_app < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        uif                matlab.ui.Figure
        HomeMenu           matlab.ui.container.Menu
        firstPluginMenu    matlab.ui.container.Menu
        redbuttonMenu      matlab.ui.container.Menu
        calculatorMenu     matlab.ui.container.Menu
        HelpMenu           matlab.ui.container.Menu
        AboutMenu          matlab.ui.container.Menu
        SettingsMenu       matlab.ui.container.Menu
        DocumentationMenu  matlab.ui.container.Menu
        LicenceMenu        matlab.ui.container.Menu
        homePanel          matlab.ui.container.Panel
        Button             matlab.ui.control.Button
    end

    
    properties (Access = private)
        dummy_private_var    
    end
    
    properties (Access = public)
    % could serve as:
    % *in-app database, keep data in RAM to avoid Disk I/O via `struct()` 
    % *plugins, again a `struct()` holding views 
    % 
        home      % e.g. display a welcome message
        plugins   % plugin, for firstplugin carrying the red buttons
        cache     % in-app cache (unused in boilerplate)
    end
    
    methods (Static)
        % dummy
    end     
    
    methods (Access = public)
    
        function  dummyPublicMethod(app)
            %% a dummy public mehtod
            %
            % :props app: handle
            % :type app: :class:`matlab.apps.AppBase`
            %
            
        end
        
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % instead of hardcoding plugins, this app (host_app)
            % is rahter meant to put the pieces together.
            % Likewise, the 'recipe' is layed out in :func:`ext_start_up`
            %
            ext_start_up(app);
        end

        % Menu selected function: HomeMenu
        function HomeMenuSelected(app, event)
            % change the view to the landing / home / neutral page 
            target_tag = 'home';
            panel_visibility_switch(app, target_tag);
        end

        % Menu selected function: SettingsMenu
        function SettingsMenuSelected(app, event)
            % firstplugin a pop-up :class:`popup_settings`
            d = popup_settings;
        end

        % Menu selected function: redbuttonMenu
        function redbuttonMenuSelected(app, event)
            % switch the view
            target_tag = 'redbutton';
            panel_visibility_switch(app, target_tag)
        end

        % Menu selected function: calculatorMenu
        function calculatorMenuSelected(app, event)
            % switch the view
            % 
            % see also: :ref:`panel_visibility_switch() <panel_visibility_switch>`
            %
            target_tag = 'calculator';
            panel_visibility_switch(app, target_tag)
        end

        % Menu selected function: AboutMenu
        function AboutMenuSelected(app, event)
            % firstplugin   :class:`popup_about`
            d = popup_about;
        end

        % Close request function: uif
        function uifCloseRequest(app, event)
            delete(app)
          %  builder_rmPath();
        end

        % Menu selected function: DocumentationMenu
        function DocumentationMenuSelected(app, event)
            % e.g. open a fil or website, launch a second application
            %
            link = 'http://mlappkit.com';
            if ispc()
                system(sprintf('start %s', link));
            elseif ismac()
                system(sprintf('open %s', link));
            elseif isunix()
                system(sprintf('xdg-open %s', link));
            end
        end

        % Menu selected function: LicenceMenu
        function LicenceMenuSelected(app, event)
            uialert(app.uif, 'MIT for this example, MIT for mlappkit', 'License', 'Icon','info')
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create uif and hide until all components are created
            app.uif = uifigure('Visible', 'off');
            app.uif.AutoResizeChildren = 'off';
            app.uif.Color = [0.9412 0.9412 0.9412];
            app.uif.Position = [1 1 1024 640];
            app.uif.Name = 'mlAppKit Boilerplate';
            app.uif.Resize = 'off';
            app.uif.CloseRequestFcn = createCallbackFcn(app, @uifCloseRequest, true);

            % Create HomeMenu
            app.HomeMenu = uimenu(app.uif);
            app.HomeMenu.MenuSelectedFcn = createCallbackFcn(app, @HomeMenuSelected, true);
            app.HomeMenu.Text = 'Home';

            % Create firstPluginMenu
            app.firstPluginMenu = uimenu(app.uif);
            app.firstPluginMenu.Text = 'A Group of Apps';

            % Create redbuttonMenu
            app.redbuttonMenu = uimenu(app.firstPluginMenu);
            app.redbuttonMenu.MenuSelectedFcn = createCallbackFcn(app, @redbuttonMenuSelected, true);
            app.redbuttonMenu.Text = 'Red Button';

            % Create calculatorMenu
            app.calculatorMenu = uimenu(app.firstPluginMenu);
            app.calculatorMenu.MenuSelectedFcn = createCallbackFcn(app, @calculatorMenuSelected, true);
            app.calculatorMenu.Text = 'Calculator';

            % Create HelpMenu
            app.HelpMenu = uimenu(app.uif);
            app.HelpMenu.Text = 'Help';

            % Create AboutMenu
            app.AboutMenu = uimenu(app.HelpMenu);
            app.AboutMenu.MenuSelectedFcn = createCallbackFcn(app, @AboutMenuSelected, true);
            app.AboutMenu.Text = 'About';

            % Create SettingsMenu
            app.SettingsMenu = uimenu(app.HelpMenu);
            app.SettingsMenu.MenuSelectedFcn = createCallbackFcn(app, @SettingsMenuSelected, true);
            app.SettingsMenu.Text = 'Settings';

            % Create DocumentationMenu
            app.DocumentationMenu = uimenu(app.HelpMenu);
            app.DocumentationMenu.MenuSelectedFcn = createCallbackFcn(app, @DocumentationMenuSelected, true);
            app.DocumentationMenu.Text = 'Documentation';

            % Create LicenceMenu
            app.LicenceMenu = uimenu(app.HelpMenu);
            app.LicenceMenu.MenuSelectedFcn = createCallbackFcn(app, @LicenceMenuSelected, true);
            app.LicenceMenu.Text = 'Licence';

            % Create homePanel
            app.homePanel = uipanel(app.uif);
            app.homePanel.AutoResizeChildren = 'off';
            app.homePanel.BackgroundColor = [1 1 1];
            app.homePanel.Position = [1 1 1024 640];

            % Create Button
            app.Button = uibutton(app.homePanel, 'push');
            app.Button.Icon = 'logo.png';
            app.Button.IconAlignment = 'center';
            app.Button.BackgroundColor = [1 1 1];
            app.Button.Position = [1 4 1023 635];
            app.Button.Text = '';

            % Show the figure after all components are created
            app.uif.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = host_app

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.uif)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.uif)
        end
    end
end

