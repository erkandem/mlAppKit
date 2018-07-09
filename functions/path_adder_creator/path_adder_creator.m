function path_adder_creator()
% short story:
% An analogon to "import this from that" in python for a session
%
% long story:
% ... is a standard option when creating a new python project.
% dependencies are more clear to analyze.
% MATLABs works different but to keep things tidy
% I decided to add the file paths in a function.
%
%
% How?
% 1. gather intel in a struct about project directory 
% 2. send that to a processor
% 3. and save the file to function directory with a predefined* filename
%
%  *( notice how I am trying to avoid the term "hardcoded")
%-----------Function Start----
%% filter out any level 1  directory 
a=dir;
a_IsDir    = {a.isdir};
a_Name     = {a.name};
a_Name_dir = a_Name(cell2mat(a_IsDir )) ; 
a_Name_dir = a_Name_dir(:);

%read in .mignore file
delList       = mignore_reader();
[boolV, ~]    = ismember(a_Name_dir , delList);

% and disscard unneded files
a_Name_dir_filted = a_Name_dir(~boolV) ;

% options struct to hold the configureation options 
% which will passed over to the processor/core

opt     =   struct();
%----cut
for i =1 :numel(a_Name_dir_filted)

qPar       = a_Name_dir_filted{i};
m          = add_subfolder(qPar);
m          = m.(qPar);
opt.(qPar) = m;

end
%-cut end

%----- paste

%---- paste end

%% [2] create the file

code_cell = path_adder_creator_core(opt);

%% [3] write it down

path_adder_creator_writer(code_cell)

out= [datestr(now()),'  |  app_template_path_adder() created'];
disp(out)

end


function c = mignore_reader()

fid =fopen('.mignore');
y = 1;
c     = cell(1);
tline = fgetl(fid);

while ischar(tline)
    % TODO: add some character analyziz to strip off comments
    comment_start=min(regexp(tline,'[%]'));
    if ~isempty(comment_start) 
        
        tline = tline(1:comment_start);
    end
    
    % only collect data,
    if ~strcmp(tline,'%')
        c(y,1)={tline};
    end
    y= y+1;
    tline = fgetl(fid);
end

% only collect cells with data
empt=cellfun('isempty',c); %'unfiorminput',false

c=c(~empt);

fclose(fid);
end

function meta_Name_dir  = leveOneDirQuer(qPar)
% save code 
% define function to just get folder from a dir query
% Level one ( one subdirecotry below, as defined by qPar);

        %some error handling - although....unnecessary
        if exist ( fullfile(qPar),'dir') ~= 7
            error([' the folder', qPar, ' does not exist.'])
        end
        
        meta = dir ( fullfile(qPar));
        meta_IsDir    = {meta.isdir};
        meta_Name     = {meta.name};
        meta_Name_dir = meta_Name(cell2mat(meta_IsDir )) ; 
        meta_Name_dir = meta_Name_dir(:);
        meta_Name_dir = meta_Name_dir(3:end);
        
end    


function o = add_subfolder( p)

o=struct();

% input:    opt - struct carrying configuration for processor/core
% outpout:  opt - added substructs and fields (boolean
%-----------verify input
if isa(p,'char')
    o.(p)=   struct();
elseif isa(p,'cell')
    if numel(p)==1
        p     =   p{1};
        o.(p) =   struct();
    else
        error('Input is type cell, but not one single cell');
    end
else 
    error('Input is neither char nor cell'); 
end
%----------actual function
qPar           = p;
meta_Name_dir  = leveOneDirQuer(qPar);

for i = 1 : numel(meta_Name_dir )
    o.(p).(meta_Name_dir{i}) = true;
end

%-----return o - struct
end


function code_cell = path_adder_creator_core(opt)

% define strings to put tegether
func_dec={'function app_template_path_adder()'};
func_end={'end'};


rb_o  ='(';
rb_c  =')';
comma = ',';
semicolon =';';

ap= 'addpath';
ff='fullfile';

three_spaces='   ';

%% create the code for the functions folders

%cPar_array={'functions','main','popups','views'};
cPar_array=fieldnames(opt);

k=1;
%-----
for i = 1:numel(cPar_array)

cPar = cPar_array{i} ;
cf   = fieldnames(opt.(cPar));
    
    for jj= 1: numel(cf)
   
     code_cell{k,1}= [three_spaces,...
                        ap,rb_o,...
                              ff,rb_o,...
                                     char(39),cPar,char(39),comma,...
                                     char(39),cf{jj},char(39),...
                                rb_c,...
                          rb_c,semicolon...
                       ];
       % + 1 loop counter
        k=k+1;
    end
end 
%-----
% add the app_template_path_adder itself
    code_cell{k,1}= [three_spaces,...
                        ap,rb_o,...
                              ff,rb_o,...
                                     char(39),'functions',char(39),comma,...
                                     char(39),'app_template_path_adder',char(39),...
                                rb_c,...
                          rb_c,semicolon...
                       ];
    % + 1 loop counter
    k=k+1;
%-----
% collect number of lines
code_cell=[func_dec;...
           code_cell;...
           func_end];

end


function path_adder_creator_writer(code_cell)
% write the results in a .m file
% if necessary create the folder for that file

ext=exist(fullfile('functions','app_template_path_adder'),'dir');
if ext~=7
    mkdir(fullfile('functions','app_template_path_adder'));
end

fid=fopen(fullfile('functions','app_template_path_adder','app_template_path_adder.m'),'w');
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

