classdef host_app < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        uif                matlab.ui.Figure
        HomeMenu           matlab.ui.container.Menu
        LaunchMenu         matlab.ui.container.Menu
        ICBMMenu           matlab.ui.container.Menu
        StingerMenu        matlab.ui.container.Menu
        scudMenu           matlab.ui.container.Menu
        contentMenu        matlab.ui.container.Menu
        PingPongMenu       matlab.ui.container.Menu
        etchAsketchMenu    matlab.ui.container.Menu
        HelpMenu           matlab.ui.container.Menu
        AboutMenu          matlab.ui.container.Menu
        DocumentationMenu  matlab.ui.container.Menu
        LicenceMenu        matlab.ui.container.Menu
        SettingsMenu       matlab.ui.container.Menu
        HomePanel          matlab.ui.container.Panel
        MessageTextArea    matlab.ui.control.TextArea
    end

    
    properties (Access = private)
        
    end
    
    properties (Access = public)
        %----About---
        % instead of bloating the number of elements like I did in my first apps
        % I turned to create properties as placeholders for the windows or views to be loaded.
        %
        %---advantages: maintainability
        %
        %---drawbacks: more complex file and pathmanagement
        %
        % Always Always give menus and buttons a meaningful names. m1a4  makes sence but UX sucks.
        %  "m1home" would suck, too.  But seems ok for codeside of things
        m1home
        
        
        % so this property could be a  class of it self.
        % However, it was just ok for me to leave it at this degree of seperating code
        
        m2_launch   % plugin
        
        m3help     % plugin
        
        m4_content     %external
        
        %todo: menu entries must be the same as the TITLE of the panel in the class
    end
    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            %create all subpanels from different m-filers
            
            app.m2_launch.m2a_stinger   =  stinger(app.uif);     %
            app.m2_launch.m2d_icbm      =  icbm(app.uif);        %
            app.m2_launch.m2e_scud      =  scud(app.uif);        %

       
            app.m4_content.m2a_pingpoong        =  pingpong(app.uif);        %
            app.m4_content.m2e_etchasketch      =      etchasketch(app.uif);        %  
            % set visibility to "off" by default
            
            app.m2_launch.m2a_stinger.main_Panel.Visible       ='off'; %
            app.m2_launch.m2d_icbm.main_Panel.Visible          ='off'; %
            app.m2_launch.m2e_scud.main_Panel.Visible     ='off'; %
            
            %
            
            app.m4_content.m2a_pingpoong.main_Panel.Visible     ='off'; %        
            app.m4_content.m2e_etchasketch.main_Panel.Visible     ='off'; %      
            
            app.HomePanel.Visible                    ='on';
            
            
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
            panel_visibility_switch(app,event);
        end

        % Menu selected function: SettingsMenu
        function SettingsMenuSelected(app, event)
            d=popup_settings; % singleton
        end

        % Menu selected function: ICBMMenu
        function ICBMMenuSelected(app, event)
            panel_visibility_switch(app,event)
        end

        % Menu selected function: StingerMenu
        function StingerMenuSelected(app, event)
            panel_visibility_switch(app,event)
        end

        % Menu selected function: scudMenu
        function scudMenuSelected(app, event)
            panel_visibility_switch(app,event)
        end

        % Menu selected function: AboutMenu
        function AboutMenuSelected(app, event)
            d=popup_about;
        end

        % Menu selected function: PingPongMenu
        function PingPongMenuSelected(app, event)
                        panel_visibility_switch(app,event)

        end

        % Menu selected function: etchAsketchMenu
        function etchAsketchMenuSelected(app, event)
                        panel_visibility_switch(app,event)

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
            app.uif.Name = 'Ultra Mega Super Duper Bien App';
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

            % Create contentMenu
            app.contentMenu = uimenu(app.uif);
            app.contentMenu.Text = 'content';

            % Create PingPongMenu
            app.PingPongMenu = uimenu(app.contentMenu);
            app.PingPongMenu.MenuSelectedFcn = createCallbackFcn(app, @PingPongMenuSelected, true);
            app.PingPongMenu.Text = 'PingPong';

            % Create etchAsketchMenu
            app.etchAsketchMenu = uimenu(app.contentMenu);
            app.etchAsketchMenu.MenuSelectedFcn = createCallbackFcn(app, @etchAsketchMenuSelected, true);
            app.etchAsketchMenu.Text = 'etchAsketch';

            % Create HelpMenu
            app.HelpMenu = uimenu(app.uif);
            app.HelpMenu.Text = 'Help';

            % Create AboutMenu
            app.AboutMenu = uimenu(app.HelpMenu);
            app.AboutMenu.MenuSelectedFcn = createCallbackFcn(app, @AboutMenuSelected, true);
            app.AboutMenu.Text = 'About';

            % Create DocumentationMenu
            app.DocumentationMenu = uimenu(app.HelpMenu);
            app.DocumentationMenu.Text = 'Documentation';

            % Create LicenceMenu
            app.LicenceMenu = uimenu(app.HelpMenu);
            app.LicenceMenu.Text = 'Licence';

            % Create SettingsMenu
            app.SettingsMenu = uimenu(app.HelpMenu);
            app.SettingsMenu.MenuSelectedFcn = createCallbackFcn(app, @SettingsMenuSelected, true);
            app.SettingsMenu.Text = 'Settings';

            % Create HomePanel
            app.HomePanel = uipanel(app.uif);
            app.HomePanel.AutoResizeChildren = 'off';
            app.HomePanel.Title = 'Home';
            app.HomePanel.Position = [1 1 1024 640];

            % Create MessageTextArea
            app.MessageTextArea = uitextarea(app.HomePanel);
            app.MessageTextArea.Position = [468 294 315 224];
            app.MessageTextArea.Value = {''; ''; 'option for static or dynamic welcome content'};
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

