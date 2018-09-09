function conversion_launcher()
    %% generates the `classdef` .m-files in the subdirectory
    % of each .mlapp-file called `mfiles` 
    % 
    % :input: no input 
    % :returns: void
    % 
    % :warning: ANY CHANGE IN THIS FUNCTION AUTOMATICALLY CREATED FUNCTION WILL BE LOST
    %           a) RATHER APPEND YOUR CODE TO the MOTHER FUNCTIONS :func:`conversion_func_generator` 
    %           b) OR WRITE YOUR OWN FUNCTIONS AND APPEND THEM TO THE FLOW
    % 
    % :note: see also: :ref:`conversion_func_generator() <conversion_func_generator>` 
    % 
     
    mlapp_to_m(fullfile('firstplugin','bigredone.mlapp'),'plugin');
    mlapp_to_m(fullfile('firstplugin','secondbigredone.mlapp'),'plugin');
    mlapp_to_m(fullfile('firstplugin','smallredone.mlapp'),'plugin');
    mlapp_to_m(fullfile('popups','popup_about.mlapp'),'popup');
    mlapp_to_m(fullfile('popups','popup_settings.mlapp'),'popup');
    mlapp_to_m(fullfile('host','host_app.mlapp'),'host');
end
