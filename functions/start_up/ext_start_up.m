function ext_start_up(app)
    %% The :func:`ext_start_up`    is used to:
    %   + intatiate the plugins
    %   + assign appropriate tags to the plugins
    %   + and resize the window and center it on the user screen
    % 
    % :param app: a reference to itself
    % :type app: :class: `matlab.apps.AppBase`
    % 
    % create all subpanels from different m-filers
    %
    % :todo: autogenerate the connections below
    %
    % :todo: mandatory tag names  of plugins? Way to automate that ? 
    %
    % :todo: mandatory name  `main_Panel` for UIPanel  of plugins? (main_Panel)

    %% get the name of the ui figure 
    
    fn_app      = fieldnames(app);
    fn_app_type = cell(numel(fn_app), 1);

    for i = 1 : numel(fn_app)
        fn_app_type{i}= class(app.(fn_app{i}));
    end
    
    [isisnot, ~] = ismember(fn_app_type, {'matlab.ui.Figure'});
    f = cell2mat(fn_app(isisnot));
    
    %% [ 1 ] create an instance...
    % ... of your plugin class and save its handle inside
    % a the `plugin `property of the application
    % 
    %
    %  Syntax: 
    %
    %  app :         handle to host application
    % .plugins :     property to hold the plugin handles
    % .firstplugin : a specific term to group certain plugins
    % .calculator :  for simplicity reasons same as the application name
    % 
    app.plugins.firstPlugin.redbutton      =  redbutton(app.(f));         %
    app.plugins.firstPlugin.calculator     =  calculator(app.(f));        %
    % YOUR NEW APPLICATION HERE ( or replace the ones above)
    % example:
    % app.plugins.yourGroup.yourApp        =  yourApp(app.(f));
    
	%% [ 2 ] assign a tag to each individual app ( simply use its appname e.g.)
    app.plugins.firstPlugin.redbutton.main_Panel.Tag    = 'redbutton';    %
    app.plugins.firstPlugin.calculator.main_Panel.Tag   = 'calculator';   %
    %app.plugins.yourGroup.yourApp.main_Panel.Tag       = 'yourApp';      %
    app.homePanel.Tag                    = 'home';
    
    %---------------------------------------------------------------------%  
    %----------95% of the users can save and exit ;) ---------------------% 
    %---------------------------------------------------------------------%
    % turn off everyone else but "home"
    panel_visibility_switch(app, 'home')

    
    %% Center window and apply deployment target resultion
    % see wikipedia for a list some default resolutions
    value = '1024x640'; % a default target resolution
            
    xPos = regexp(value,'x');
    d1 = str2double(value(1      : xPos-1));
    d2 = str2double(value(xPos+1 : end   ));
            
    % center the application window on the screen of the user
    st = get(0,'ScreenSize');
            
    xDif = (st(3) - d1) / 2;
    yDif = (st(4) - d2) / 2;
            
    nSize = [xDif, yDif, d1, d2];
    app.(f).Position = nSize;  
    
end  