
% run this function to add the necessary functions and classes into the
% MATLAB searchpaths
% todo: automate this in the style of conversion_launcher 
% which was fullfilled by autochild registerer


function app_template_path_adder()

    addpath(fullfile('launch' ,'mfiles'));
    addpath(fullfile('main'   ,'mfiles'));
    addpath(fullfile('popups','mfiles'));

    addpath(fullfile('functions','panel_visibility'));
    addpath(fullfile('functions','mlapp2classdef_edit'));
    addpath(fullfile('functions','mlapp2classdef'));
    addpath(fullfile('functions','main_extractor'));
    addpath(fullfile('functions','conversion_launcher'));
    addpath(fullfile('functions','auto_child_registerer'));
    

end
