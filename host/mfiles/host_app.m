classdef host_app < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        uif                  matlab.ui.Figure
        HomeMenu             matlab.ui.container.Menu
        firstPluginMenu      matlab.ui.container.Menu
        bigredoneMenu        matlab.ui.container.Menu
        secondbigredoneMenu  matlab.ui.container.Menu
        smallredoneMenu      matlab.ui.container.Menu
        HelpMenu             matlab.ui.container.Menu
        AboutMenu            matlab.ui.container.Menu
        SettingsMenu         matlab.ui.container.Menu
        DocumentationMenu    matlab.ui.container.Menu
        LicenceMenu          matlab.ui.container.Menu
        HomePanel            matlab.ui.container.Panel
        MessageTextArea      matlab.ui.control.TextArea
    end

    
    properties (Access = private)
        
    end
    
    properties (Access = public)
    % could serve as:
    % *in-app database, keep data in RAM to avoid Disk I/O via `struct()` 
    % *plugins, again a `struct()` holding views 
    % 
        home   % internal usage, 
        
        plugins   % plugin, for firstplugin carrying the red buttons
        
        cache     % in app cache (unused in boilerplate)
    
    end

    methods (Access = public)
    
        function  dummyPublicMethod(app)
            %% a dummy public mehtod
            %
            % :props app: handle
            % :type app: :class:`matlab.apps.AppBase`
            %
            

            % do something meaningful like developing 
        end
        
    end
    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            externalStartUpFunctionOfProject(app);
        end

        % Menu selected function: HomeMenu
        function HomeMenuSelected(app, event)
            % change the view to the landing / home / neutral page 
            target_tag='home';
            panel_visibility_switch(app,target_tag);
        end

        % Menu selected function: SettingsMenu
        function SettingsMenuSelected(app, event)
            % firstplugin a pop-up :class:`popup_settings`
            d=popup_settings; % new ui 
        end

        % Menu selected function: bigredoneMenu
        function bigredoneMenuSelected(app, event)
            % switch the view
            target_tag='bigredone';
            panel_visibility_switch(app,target_tag)
        end

        % Menu selected function: secondbigredoneMenu
        function secondbigredoneMenuSelected(app, event)
            % switch the view
            % 
            % see also: :ref:`panel_visibility_switch() <panel_visibility_switch>`
            %
            target_tag='secondbigredone';
            panel_visibility_switch(app,target_tag)
        end

        % Menu selected function: smallredoneMenu
        function smallredoneMenuSelected(app, event)
            target_tag='smallredone';
            panel_visibility_switch(app,target_tag)
        end

        % Menu selected function: AboutMenu
        function AboutMenuSelected(app, event)
            % firstplugin   :class:`popup_about`
            d=popup_about;
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create uif
            app.uif = uifigure;
            app.uif.AutoResizeChildren = 'off';
            app.uif.Position = [1 1 1024 640];
            app.uif.Name = 'mlAppBinder Boilerplate';
            app.uif.Resize = 'off';

            % Create HomeMenu
            app.HomeMenu = uimenu(app.uif);
            app.HomeMenu.MenuSelectedFcn = createCallbackFcn(app, @HomeMenuSelected, true);
            app.HomeMenu.Text = 'Home';

            % Create firstPluginMenu
            app.firstPluginMenu = uimenu(app.uif);
            app.firstPluginMenu.Text = 'Red Buttons';

            % Create bigredoneMenu
            app.bigredoneMenu = uimenu(app.firstPluginMenu);
            app.bigredoneMenu.MenuSelectedFcn = createCallbackFcn(app, @bigredoneMenuSelected, true);
            app.bigredoneMenu.Text = 'Red Button 1';

            % Create secondbigredoneMenu
            app.secondbigredoneMenu = uimenu(app.firstPluginMenu);
            app.secondbigredoneMenu.MenuSelectedFcn = createCallbackFcn(app, @secondbigredoneMenuSelected, true);
            app.secondbigredoneMenu.Text = 'Red Button 2';

            % Create smallredoneMenu
            app.smallredoneMenu = uimenu(app.firstPluginMenu);
            app.smallredoneMenu.MenuSelectedFcn = createCallbackFcn(app, @smallredoneMenuSelected, true);
            app.smallredoneMenu.Text = 'Red Button 3';

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
            app.DocumentationMenu.Text = 'Documentation';

            % Create LicenceMenu
            app.LicenceMenu = uimenu(app.HelpMenu);
            app.LicenceMenu.Text = 'Licence';

            % Create HomePanel
            app.HomePanel = uipanel(app.uif);
            app.HomePanel.AutoResizeChildren = 'off';
            app.HomePanel.Title = 'Home';
            app.HomePanel.Position = [1 1 1024 640];

            % Create MessageTextArea
            app.MessageTextArea = uitextarea(app.HomePanel);
            app.MessageTextArea.Position = [291 460 315 80];
            app.MessageTextArea.Value = {''; 'option for static or dynamic welcome content'; 'but could be removed'};
        end
    end

    methods (Access = public)

        % Construct app
        function app = host_app

            % Create and configure components
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

