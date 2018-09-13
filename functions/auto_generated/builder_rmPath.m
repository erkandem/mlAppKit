function builder_rmPath()
    %% REMOVES `builder` and custom function folders(only first level)
    % in a second run this function will also add the `.m-files` subdirectories
    % of each .mlapp-file.
    % 
    % 
    % .. warning:: ANY CHANGE IN THIS AUTOMATICALLY CREATED FUNCTION WILL BE LOST
    %              a) RATHER APPEND YOUR CODE TO :ref:`rmPath_creator` 
    %              b) OR WRITE YOUR OWN FUNCTIONS AND APPEND THEM TO THE FLOW
    % 
    % .. todo:: save your code in `mfiles` folder aswell 
    %           currently, a level beneeth `mfiles` is not recognized 
    % 
    % .. todo:: define/declare/offer standerdized `hooks` like in WordPress 
    % 
    % 
    % 
    % 
    % 
     
    rmpath(fullfile('firstplugin','mfiles'));
    rmpath(fullfile('functions','auto_generated'));
    rmpath(fullfile('functions','building'));
    rmpath(fullfile('functions','package'));
    rmpath(fullfile('functions','panel_visibility'));
    rmpath(fullfile('functions','setup'));
    rmpath(fullfile('functions','sphinx'));
    rmpath(fullfile('functions','start_up'));
    rmpath(fullfile('functions','templates'));
    rmpath(fullfile('host','mfiles'));
    rmpath(fullfile('popups','mfiles'));
    rmpath(fullfile('static','audio'));
    rmpath(fullfile('static','icons'));
    rmpath(fullfile('static','img'));
    rmpath(fullfile('static','misc'));
    rmpath(genpath(fullfile('static')));
end
