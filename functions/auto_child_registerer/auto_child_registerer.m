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

% remove "main"
[a,b] = ismember('main',a_Name_dir_filted);
a_Name_dir_filted(b(a)) = [];

clear a b 
%% the pop-ups folder...
% contains code for windows with an UI Figure
%
% typical usage would be to set certain options which do not need to be
% changed that often and hence can be stored in an external UI Figure
% instead our precious application real estate
% option [ 2 ] in conversion_launcher

opt.popups=struct();
%%% for i = 1:numel( a_Name_dir_filted)
    
    opt.popups.popups= struct();
    
    meta = dir ( fullfile('popups','*mlapp'));
    lfn = {meta.name};
    
    for j=1:numel(lfn)
        % strip of file extension
        dotloc =  regexp(lfn{j},'[.]');
        fName  =  lfn{j}(1:dotloc-1);
        opt.popups.popups.(fName)=true;
    end
%%% end
% remove "pop-ups"
[a,b] = ismember('popups',a_Name_dir_filted);
a_Name_dir_filted(b(a)) = [];

clear a b 

%% any other folder...
% can be recognized as a lavel 1 plugin to the core application 
% TODO: figure out a way to deal with child menus in the menu
%
% option [ 1 ] in conversion_launcher
% Sample mlapp2classdef_edit('launch/icbm.mlapp','ReplaceAppUI',true);

opt.views=struct();
for i = 1:numel( a_Name_dir_filted)
    
    opt.views.(a_Name_dir_filted{i}) = struct();
    
    meta = dir ( fullfile(a_Name_dir_filted{i},'*mlapp'));
    lfn = {meta.name};
    
    for j=1:numel(lfn)
        % strip of file extension
        dotloc =  regexp(lfn{j},'[.]');
        fName  =  lfn{j}(1:dotloc-1);
        opt.views.(a_Name_dir_filted{i}).(fName)=true;
    end
end

%codeBox = struct();
code_cell = mat_codegen(opt);

%% create/ compile the function files
% and write them down
write_conversion_launcher(code_cell);

end

%% generate conversion_launcher 
function code_cell=mat_codegen(opt)

% Sample mlapp2classdef_edit('launch/icbm.mlapp','ReplaceAppUI',true);
% Sample mlapp2classdef('pop-ups/shitstorm.mlapp','ReplaceAppUI',false);
% +  
func_dec={'function conversion_launcher()'};
func_end={'end'};
    
one_sp={' '};

fHead_views ='mlapp2classdef_edit';
fHead_popups ='mlapp2classdef_edit';
fHead_main ={'main_extractor();'} ;

rb_o  ='(';
rb_c  =')';

ffoot_views =[char(39),'ReplaceAppUI',char(39),',','true);'] ;
ffoot_popups =[char(39),'ReplaceAppUI',char(39),',','false);'] ;

dir_name = 'default';
fName    = 'default';
%----------------views------------------------
folder_names = fieldnames(opt.views);
k=1;
    for i = 1: numel(folder_names)
        file_names = fieldnames(opt.views.(folder_names{i})) ;

        for j =1:numel(file_names)
                
                c1(k,1) = {[fHead_views,rb_o,'fullfile',rb_o,char(39),folder_names{i},char(39),',',char(39),(file_names{j}),'.mlapp',char(39),rb_c,',',ffoot_views ]};
                k=k+1;        
        end
    end
clear k  i j 
%---end----------------views------------------------



%----------------popups------------------------

    folder_names = fieldnames(opt.popups);
k=1;
    for i = 1: numel(folder_names)
        file_names = fieldnames(opt.popups.(folder_names{i})) ;

        for j =1:numel(file_names)
                
                c2(k,1) = {[fHead_popups,rb_o,'fullfile',rb_o,char(39),folder_names{i},char(39),',',char(39),(file_names{j}),'.mlapp',char(39),rb_c,',',ffoot_popups ]};
                k=k+1;        
        end
    end
clear k  i j
%----------------popups------------------------

% collect number of lines
num_c1   = size(c1,1) ;
num_c2   = size(c2,1) ;
num_main = size(fHead_main,1) ;
%-----------------------------------
%------------------------------------
total_num_lines= num_c1   +num_c2 +   num_main +2; % func_dec func_end 
k=1;
    code_cell=cell(total_num_lines,1);
    for n= 1:3 % 3 types of codes; views .mlapp, popups, and main .mlapp
        %--------------------
        if n==1
            code_cell(k)=func_dec;
            k=k+1;
            for jj=1:numel(c1)
                code_cell(k,1)= c1(jj);
                k=k+1;
            end
        %--------------------    
        elseif n==2
           
            for jj=1:numel(c2)
                 code_cell(k,1)= c2(jj);
                 k=k+1;
            end
        %--------------------
        elseif n==3
            
            code_cell(k,1)= fHead_main;
            k=k+1;
        
            code_cell(k)=func_end;
            k=k+1;
        end
        %--------------------        
    end
    1+1; % debugger breakpoint hook
end


%%
function write_conversion_launcher(code_cell)

ext=exist(fullfile('functions','conversion_launcher'),'dir');
if ext~=7
    mkdir(fullfile('functions','conversion_launcher'));
end

fid=fopen(fullfile('functions','conversion_launcher','conversion_launcher.m'),'w');
if fid~=3
    error('conversion_launcher.m could not be created (the file itself not the code)')
end

    % Write a cell array of strings to a *.m file
    % Assumes each cell is a separate line
for ii = 1:size(code_cell,1)
    fprintf(fid, '%s\n', code_cell{ii});
end

fclose(fid);

end