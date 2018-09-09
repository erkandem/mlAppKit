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
    % :todo: autogenerate the connections below
    %
    
    % get the name of the ui figure
    fn_app      = fieldnames(app);
    fn_app_type = cell(numel(fn_app),1);

    for i = 1 : numel(fn_app)
        fn_app_type{i}= class(app.(fn_app{i}));
    end
    
    [isisnot,~]=ismember( fn_app_type,{'matlab.ui.Figure'});
    
    f = cell2mat(fn_app(isisnot));
    %-----------------------Edit this part------------------------%         
    app.plugins.firstplugin.bigredone      =  bigredone(app.(f));        %
    app.plugins.firstplugin.calculator     =  calculator(app.(f));  %    %
    %-----------------until here freely   ------------------------%
    %--- The syntax hereafter is given then derived from above
    
    %
    % :todo: mandatory name  `main_Panel` for UIPanel  of plugins? (main_Panel)
    %            
            
    % set visibility to "off" by default
    app.plugins.firstplugin.bigredone.main_Panel.Visible       = 'off'; %
    app.plugins.firstplugin.calculator.main_Panel.Visible = 'off'; %
 
    app.HomePanel.Visible                          = 'on';
           
    %
    % :todo: mandatory tag names  of plugins? Way to automate them ? 
    %           
        
    % assign tags
    app.plugins.firstplugin.bigredone.main_Panel.Tag         = 'bigredone'; %
    app.plugins.firstplugin.calculator.main_Panel.Tag   = 'calculator';    %
            %----
    app.HomePanel.Tag                    = 'home';

       
    % Center window and apply target resultion
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
end  