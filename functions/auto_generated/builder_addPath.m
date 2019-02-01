function builder_addPath()
    %% adds `builder` and custom function folders(only first level)
    % in a second run this function will also add the `mfiles` subdirectories
    % of each .mlapp-file.
    % 
    % :input: no input 
    % :returns: void
    % 
    % .. warning:: ANY CHANGE IN THIS AUTOMATICALLY CREATED FUNCTION WILL BE LOST
    %              a) RATHER APPEND YOUR CODE TO :ref:`addPath_creator` 
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
     
    addpath(fullfile('firstplugin', 'mfiles'));
    addpath(fullfile('functions', 'auto_generated'));
    addpath(fullfile('functions', 'building'));
    addpath(fullfile('functions', 'package'));
    addpath(fullfile('functions', 'panel_visibility'));
    addpath(fullfile('functions', 'setup'));
    addpath(fullfile('functions', 'sphinx'));
    addpath(fullfile('functions', 'start_up'));
    addpath(fullfile('functions', 'templates'));
    addpath(fullfile('host', 'mfiles'));
    addpath(fullfile('popups', 'mfiles'));
    addpath(fullfile('static', 'audio'));
    addpath(fullfile('static', 'icons'));
    addpath(fullfile('static', 'img'));
    addpath(fullfile('static', 'misc'));
    addpath(genpath(fullfile('static')));
end
