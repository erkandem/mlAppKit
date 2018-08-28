function builder_addPath()
%% adds `builder` and custom function folders(only first level)
% in a second run this function will also add the `mfiles` subdirectories
% of each .mlapp-file.
% :TODO: save your code in `mfiles` folder aswell 
%  - currently a level beneeth is not recognized 
% see also :func:`addPath_creator` 
% 
% :input: no input 
% :returns: void
% 
% ANY CHANGE IN THIS AUTOMATICALLY CREATED FUNCTION WILL BE LOST
% a) RATHER APPEND YOUR CODE TO the MOTHER FUNCTIONS :func:`addPath_creator` 
% b) OR WRITE YOUR OWN FUNCTIONS AND APPEND THEM TO THE FLOW
% 
% :TODO: define/declare/offer standerdized `hooks` like in WordPress 
 
   addpath(fullfile('functions','auto_generated'));
   addpath(fullfile('functions','building'));
   addpath(fullfile('functions','panel_visibility'));
   addpath(fullfile('host','mfiles'));
   addpath(fullfile('launch','mfiles'));
   addpath(fullfile('popups','mfiles'));
end
