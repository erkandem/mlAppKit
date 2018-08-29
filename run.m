% This script is going to "build" and run the app 

%% Look at the  dependencies 
% An analogon to `import this from that` in python 
% add dependencies without saving them. 
% every restart of MATLAB will forget the added paths.
% MATLAB pathdef stays clean

addpath(fullfile('functions','building'));
addPath_creator()

%% add the project files to MATLAB's <session> search  path
% this function was auto created by "path_adder_creator"
addpath(fullfile('functions','auto_generated'));
builder_addPath();

%%  prepare m-code extraction
% app_template_path_adder has to have the following functions included
% "auto_child_registerer" will recognize every folder as 
% a part of the application to be created.
%
% ".mignore" file

conversion_func_generator();
% creates the "conversion_launcher()" function.
%% extract m-code
% essentially a script turned into a funtion
% runs the appdesigner to m file function 
%
% inspired by stackoverflowmatlabchat on github
% https://github.com/StackOverflowMATLABchat/mlapp2classdef
%
% "ad_to_m(mlappfile_loc,view_type)" 
% take the m code and adjust it to our needs
%
% input:
% mlappfile_loc -  location of the appdesigner file                 - char array
% view_type     - one of the three cases, host, plugin or popup     - char array
%
% output: classdef saved in a ".m" file
conversion_launcher();

% :TODO: compatibility to mlapp2classdef() ?

%% re-run the path search
% in order to capture the location of the new m-files
addPath_creator()
builder_addPath();

%% launch the app 
% started from the obtained m-files not the .mlapp file

%app_launch();