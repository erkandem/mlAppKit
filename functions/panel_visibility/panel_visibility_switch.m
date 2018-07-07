function panel_visibility_switch(app,target_tag)
%todo: menu entries must be the same as the TITLE of the panel in the class
% purpose: regulates the visibility of panels/views in the main app. so
% instead of replicating on/off switches with each menu selection we would
% prefer to to know
% [ 1 ] which panel/view needs to be set to visible
% [ 2 ] -[1] implies which panels need to be turned off


fn_app      = fieldnames(app );
fn_app_type = cell(numel(fn_app),1);

for i = 1 : numel(fn_app)
    fn_app_type{i}= class(app.(fn_app{i}));
end
% strip off unwanted element
% TODO: extend on other elements

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
    if isa(app.(fn_app{i}),'matlab.ui.Figure')
        continue
    end
    try
        level3_fn=fieldnames(app.(fn_app{i}));
        
        for z =1:numel( level3_fn)
            try
                level4_fn=fieldnames(app.(fn_app{i}).(level3_fn{z}));
                if ismember('main_Panel',level4_fn)
                    
                    if isa(app.(fn_app{i}).(level3_fn{z}).main_Panel,'matlab.ui.container.Panel')
                        % compare the title
                        %todo: menu entries must be the same as the TITLE of the panel in the class
                        % Example: app.m2_launch.m2a_stinger.main_Panel.Title
                        % app.(fn_app{i}).(level3_fn{z}).main_Panel.Title='Stinger'
                        % call_raised_by = CMEcalcpanel

                        
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