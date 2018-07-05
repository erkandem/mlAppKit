function panel_visibility_switch(app,event)
%todo: menu entries must be the same as the TITLE of the panel in the class
% purpose: regulates the visibility of panels/views in the main app. so
% instead of replicating on/off switches with each menu selection we would
% prefer to to know
% [ 1 ] which panel/view needs to be set to visible
% [ 2 ] -[1] implies which panels need to be turned off


fn_app=fieldnames(app );

% who called the function?
call_raised_by=event.Source.Text;

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
                        if strcmp(call_raised_by,app.(fn_app{i}).(level3_fn{z}).main_Panel.Title)
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