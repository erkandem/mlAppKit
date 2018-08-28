function conversion_launcher()
%% generates the `classdef` .m-files in the subdirectory
% of each .mlapp-file called `mfiles` 
% 
% :input: no input 
% :returns: void
% 
% ANY CHANGE IN THIS AUTOMATICALLY CREATED FUNCTION WILL BE LOST
% a) RATHER CHANGE APPEND YOUR CODE TO MOTHER FUNCTIONS
% b) or  OR WRITE YOUR OWN FUNCTION AND APPEND IT TO THE FLOW
% 
% see also :func:`conversion_func_generator` 
 
mlapp_to_m(fullfile('launch','icbm.mlapp'),'plugin');
mlapp_to_m(fullfile('launch','scud.mlapp'),'plugin');
mlapp_to_m(fullfile('launch','stinger.mlapp'),'plugin');
mlapp_to_m(fullfile('popups','popup_about.mlapp'),'popup');
mlapp_to_m(fullfile('popups','popup_settings.mlapp'),'popup');
mlapp_to_m(fullfile('host','host_app.mlapp'),'host');
end
