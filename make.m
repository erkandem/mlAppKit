function make(pdir)
% Actually a script in a function shell is going to "build" and run the app 

%% Look at the  dependencies 
    if nargin ==0
        projectDir = pwd;
    else 
        currentdir = pdir;
    end

    addpath(fullfile('functions','building'));
    addPath_creator()

%% add the project files to MATLAB's <session> search  path
% this function was auto created by "path_adder_creator"
    addpath(fullfile('functions','auto_generated'));
    builder_addPath();

%%  prepare m-code extraction

    conversion_func_generator();
% creates the "conversion_launcher()" function.

%% extract m-code
% essentially a script turned into a funtion
% runs the appdesigner to m file function 

    conversion_launcher();
%
% :todo: compatibility to mlapp2classdef() ?
%
%% re-run the path search
% in order to capture the location of the new m-files
    addPath_creator()
    builder_addPath();

%% launch the app 
% started from the obtained m-files not the .mlapp file
  %  app_launch();
 sprintf('%s','Aplication built successfully! ')
end