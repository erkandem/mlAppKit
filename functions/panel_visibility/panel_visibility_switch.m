function panel_visibility_switch(app,target_tag)
% regulates the visibility of panels/views in the main app. so
% instead of replicating on/off switches with each menu
%
%
% :param app: an  MATLAB ``app`` class to which contains all parts of the
%             applications. Important in this case are the handles to each panel which
%             can be comfortably access via ``app`` instead of collecting and passing
%             it manually to this function
% :type app: app
% :param target_tag: marks the tag of the tab which raised the function
%                    call, as such, that panel is going to be made visible while every other
%                    panel will be set to invisable
%
% :type target_tag: str
% :returns: ` void `
%
    fn_app      = fieldnames(app);
    fn_app_type = cell(numel(fn_app),1);

    for i = 1 : numel(fn_app)
        fn_app_type{i}= class(app.(fn_app{i}));
    end
% strip off unwanted element
% :todo: extend on other elements

    dList= {'matlab.ui.container.Menu';...
            'matlab.ui.Figure';...
            'matlab.ui.control.TextArea'};
          
    [boolV,~]=ismember(fn_app_type,dList);
    fn_app_type = fn_app_type(~boolV);
    fn_app      = fn_app(~boolV);

    % who called the function?
    call_raised_by=target_tag;

    for i =1: numel( fn_app )
    % skip if it is the uifigure
    fgh = 1 + 1; % debugging hook
        if isa(app.(fn_app{i}),'matlab.ui.Figure')
            continue
        end
        try
            level3_fn=fieldnames(app.(fn_app{i}));
            for z =1:numel( level3_fn)
                try
                    level4_fn=fieldnames(app.(fn_app{i}).(level3_fn{z}));
                    if isa(app.(fn_app{i}).(level3_fn{z}), 'struct')
                        % new
                        for jj = 1:numel(level4_fn) 
                            level5_fn=fieldnames(app.(fn_app{i}).(level3_fn{z}).(level4_fn{jj}));
                            if ismember('main_Panel',level5_fn)
                         
                                if isa(app.(fn_app{i}).(level3_fn{z}).(level4_fn{jj}).main_Panel,'matlab.ui.container.Panel')
                                    % compare the tag
                                    if strcmp(call_raised_by,app.(fn_app{i}).(level3_fn{z}).(level4_fn{jj}).main_Panel.Tag)
                                        app.(fn_app{i}).(level3_fn{z}).(level4_fn{jj}).main_Panel.Visible ='On';
                                    else
                                        app.(fn_app{i}).(level3_fn{z}).(level4_fn{jj}).main_Panel.Visible ='Off';
                                    end
                            
                                end    
                        
                            end

                        end
                        
                    else 
                        % old
                    end
                    if ismember('main_Panel',level4_fn)
                        if isa(app.(fn_app{i}).(level3_fn{z}).main_Panel,'matlab.ui.container.Panel')
                        % compare the tag
                            
                            
                            if strcmp(call_raised_by,app.(fn_app{i}).(level3_fn{z}).main_Panel.Tag)
                                app.(fn_app{i}).(level3_fn{z}).main_Panel.Visible ='On';
                            else
                                app.(fn_app{i}).(level3_fn{z}).main_Panel.Visible ='Off';
                            end
                            
                        end
                    end
                catch
                end
            end
        catch
        end
    end

end