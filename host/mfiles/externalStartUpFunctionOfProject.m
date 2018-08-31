function externalStartUpFunctionOfProject(app)
        %% The :func:`startupFnc`    is used to:
        %   + intatiate the plugins
        %   + assign appropriate tags to the plugins
        %   + and resize the window and center it on the user screen
        % 
        % :param app: a reference to itself
        % :type app: :class: `matlab.apps.AppBase`
        % 
        % create all subpanels from different m-filers
        %
        % :todo: mandatory name `app.uif` for UIFigure of host app? (app.uif)
        %
        % :todo: autogenerate the connections 
        %
            app.firstplugin.bigredone           =  bigredone(app.uif);        %
            app.firstplugin.secondbigredone     =  secondbigredone(app.uif);        %
            app.firstplugin.smallredone         =  smallredone(app.uif);        %
        %
        % :todo: mandatory name  `main_Panel` for UIPanel  of plugins? (main_Panel)
        %            
            
       % set visibility to "off" by default
            app.firstplugin.bigredone.main_Panel.Visible       = 'off'; %
            app.firstplugin.secondbigredone.main_Panel.Visible          = 'off'; %
            app.firstplugin.smallredone.main_Panel.Visible          = 'off'; %
            app.HomePanel.Visible                       = 'on';
           
        %
        % :todo: mandatory tag names  of plugins? Way to automate them ? 
        %           
        
       % assign tags
            app.firstplugin.bigredone.main_Panel.Tag         = 'bigredone'; %
            app.firstplugin.secondbigredone.main_Panel.Tag   = 'secondbigredone';    %
            app.firstplugin.smallredone.main_Panel.Tag       = 'smallredone';    %
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