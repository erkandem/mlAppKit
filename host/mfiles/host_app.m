classdef host_app < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        uif                matlab.ui.Figure
        HomeMenu           matlab.ui.container.Menu
        LaunchMenu         matlab.ui.container.Menu
        ICBMMenu           matlab.ui.container.Menu
        StingerMenu        matlab.ui.container.Menu
        scudMenu           matlab.ui.container.Menu
        HelpMenu           matlab.ui.container.Menu
        AboutMenu          matlab.ui.container.Menu
        SettingsMenu       matlab.ui.container.Menu
        DocumentationMenu  matlab.ui.container.Menu
        LicenceMenu        matlab.ui.container.Menu
        HomePanel          matlab.ui.container.Panel
        MessageTextArea    matlab.ui.control.TextArea
    end

    
    properties (Access = private)
        
    end
    
    properties (Access = public)
    % the properties of the :class:`host_app` are empty atfirst (only declared)
    % They could serve as in-app database `struct()` if some data is preferably kept in RAM
    % or - what they intended to by this project: get initialized as a `struct()` holding views
    % in the form of `tabs`
    
        m1home   % plugin, one placeholder is left for in-*host*-app tabs, but could be modified to be loaded externally aswell
                 % I kept it to serve as some kind of landing/404/503 equivalent
                 % for example: a dashboard with charts and news could be set up
        
        launch   % plugin, for launch submenu carrying scud, icbc and stinger
        
   
        m3_help     % plugin, placeholder for in-app about, help/documentation, license,  web links, etc...
    
        % m4_calculate % plugin
        
        % TODO: menu entries must be the same as the TITLE of the panel in the class
        % Note:
        % instead of bloating the number of elements like I did in my first apps
        % I turned to create properties as placeholders for the windows or views to be loaded.
        %
        % *advantages*: maintainability
        % *drawbacks*: more complex file and pathmanagement
        %
        %  Always Always give menus and buttons a meaningful names. m1a4  makes sence but UX sucks.
        %  "m1home" would suck, too.  But seems ok for codeside of things
    end
    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
        % The :func:`startupfnc`    is used to:
        %   - intatiate the plugins
        %   - assign appropriate tags to the plugins
        %   - and resize the window and center it on the user screen
        %
        % :param app: a reference to itself
        % :type app: :class: `matlab.apps.AppBase`
        
        % create all subpanels from different m-filers
        %
        % :todo: mandatory name `app.uif` for UIFigure of host app? (app.uif)
        %
        % :todo: autogenerate the connections 
        %
            app.launch.stinger   =  stinger(app.uif);        %
            app.launch.icbm      =  icbm   (app.uif);        %
            app.launch.scud      =  scud   (app.uif);        %
        %
        % :todo: mandatory name  `main_Panel` for UIPanel  of plugins? (main_Panel)
        %            
            
       % set visibility to "off" by default
            app.launch.stinger.main_Panel.Visible       = 'off'; %
            app.launch.icbm.main_Panel.Visible          = 'off'; %
            app.launch.scud.main_Panel.Visible          = 'off'; %
            app.HomePanel.Visible                       =  'on';
           
        %
        % :todo: mandatory tag names  of plugins? Way to automate them ? 
        %           
        
       % assign tags
            app.launch.stinger.main_Panel.Tag    = 'stinger'; %
            app.launch.icbm.main_Panel.Tag       = 'icbm';    %
            app.launch.scud.main_Panel.Tag       = 'scud';    %
            %----
            app.HomePanel.Tag                    = 'home';

        
            %--- Center window and apply target resultion
            value = '1024x640'; % target resolution
            
            xPos = regexp(value,'x');
            d1 = str2double( value(  1     : xPos-1 )) ;
            d2 = str2double( value( xPos+1 : end    )) ;
            
            % center window
            st = get(0,'ScreenSize');
            
            xDif = (st(3)-d1)/2;
            yDif = (st(4)-d2)/2;
            
            nSize=[xDif, yDif, d1, d2];
            app.uif.Position = nSize;
            n2Size=[1,1,1024,640];
            %--- Center window and apply target resultion
        end

        % Menu selected function: HomeMenu
        function HomeMenuSelected(app, event)
            % change the view to the landing / home / neutral page 
            target_tag='home';
            panel_visibility_switch(app,target_tag);
        end

        % Menu selected function: SettingsMenu
        function SettingsMenuSelected(app, event)
            % launch a pop-up :class:`popup_settings`
            d=popup_settings; % new ui 
        end

        % Menu selected function: ICBMMenu
        function ICBMMenuSelected(app, event)
            % switch the view
            target_tag='icbm';
            panel_visibility_switch(app,target_tag)
        end

        % Menu selected function: StingerMenu
        function StingerMenuSelected(app, event)
            % switch the view
            % 
            % see also: :ref:`panel_visibility_switch() <panel_visibility>`
            %
            target_tag='stinger';
            panel_visibility_switch(app,target_tag)
        end

        % Menu selected function: scudMenu
        function scudMenuSelected(app, event)
            target_tag='scud';
            panel_visibility_switch(app,target_tag)
        end

        % Menu selected function: AboutMenu
        function AboutMenuSelected(app, event)
            % launch   :class:`popup_about`
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

            % Create LaunchMenu
            app.LaunchMenu = uimenu(app.uif);
            app.LaunchMenu.Text = 'Launch';

            % Create ICBMMenu
            app.ICBMMenu = uimenu(app.LaunchMenu);
            app.ICBMMenu.MenuSelectedFcn = createCallbackFcn(app, @ICBMMenuSelected, true);
            app.ICBMMenu.Text = 'ICBM';

            % Create StingerMenu
            app.StingerMenu = uimenu(app.LaunchMenu);
            app.StingerMenu.MenuSelectedFcn = createCallbackFcn(app, @StingerMenuSelected, true);
            app.StingerMenu.Text = 'Stinger';

            % Create scudMenu
            app.scudMenu = uimenu(app.LaunchMenu);
            app.scudMenu.MenuSelectedFcn = createCallbackFcn(app, @scudMenuSelected, true);
            app.scudMenu.Text = 'scud';

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
            app.MessageTextArea.Position = [321 300 315 80];
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

