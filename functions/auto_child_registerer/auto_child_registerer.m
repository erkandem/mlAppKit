function auto_child_registerer()
% once completed this will be an add-on to the registration functions 
%
% Specifically, this file should collect information about the current
% project and generate an parameter structure to generate
%--- [1] "app_template_path_adder" functions

% ---[2] m-file extractions via "conversion_launcher"

%% filter out any level 1  directory 
a=dir;
a_IsDir = {a.isdir};
a_Name  = {a.name};
a_Name_dir=a_Name(cell2mat(a_IsDir )) ; 
a_Name_dir=a_Name_dir(:);


%% ignore list
% usual candidates from unix dir query but could also include folder for
% whatever reason, which are not part of the production code
%
ignore_list={'.git';...
    '__overhead';...
    'settings';...
    '.';...
    '..';...
    'functions'};

[bool, l_num]=ismember(ignore_list,a_Name_dir);

a_Name_dir_filted=a_Name_dir;
a_Name_dir_filted(l_num(bool))=[];

%% the main 
% folder contains the core application code and will be parsed via 
% option [ 3 ] in conversion_launcher


%% the pop-ups folder...
% contains code for windows with an UI Figure
%
% typical usage would be to set certain options which do not need to be
% changed that often and hence can be stored in an external UI Figure
% instead our precious application real estate
% option [ 2 ] in conversion_launcher


%% any other folder...
% can be recognized as a lavel 1 plugin to the core application 
% TODO: figure out a way to deal with child menus in the menu
%
% option [ 1 ] in conversion_launcher


% create/ compile the function files 
% and write them down

end

