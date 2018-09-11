function make(pdir)
% Actually a script in a function shell is going to "build" and run the app 

%% Look at the  dependencies 
    if nargin ==0
        projectDir = pwd();
    else 
        projectDir = pdir;
    end
    
    
    % git clone has it
    % loaded bundle has it centrally on the MATLABpath and doesn't
    % need to have the `building` in each project
    try
        if exist (fullfile(projectDir ,'functions','building'),'dir')==7 
            addpath(fullfile('functions','building'));
        end
    catch
        sprintf('%s',"warning: function/building doesn't exist yet")
    end
    
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
 app_launch();
 sprintf('%s','Aplication built successfully! ');
end