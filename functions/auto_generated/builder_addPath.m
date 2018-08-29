function builder_addPath()
%% adds `builder` and custom function folders(only first level)
% in a second run this function will also add the `mfiles` subdirectories
% of each .mlapp-file.
% 
% :input: no input 
% :returns: void
% 
% :warning: ANY CHANGE IN THIS FUNCTION AUTOMATICALLY CREATED FUNCTION WILL BE LOST
%           a) RATHER APPEND YOUR CODE TO the MOTHER FUNCTIONS :func:`addPath_creator` 
%           b) OR WRITE YOUR OWN FUNCTIONS AND APPEND THEM TO THE FLOW
% 
% :todo: save your code in `mfiles` folder aswell 
%        currently, a level beneeth `mfiles` is not recognized 
% 
% :todo: define/declare/offer standerdized `hooks` like in WordPress 
% 
% 
% see also :func:`addPath_creator` 
% 
% 
 
   addpath(fullfile('functions','auto_generated'));
   addpath(fullfile('functions','building'));
   addpath(fullfile('functions','panel_visibility'));
   addpath(fullfile('host','mfiles'));
   addpath(fullfile('launch','mfiles'));
   addpath(fullfile('popups','mfiles'));
end
