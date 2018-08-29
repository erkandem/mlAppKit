function addPath_creator()
%% An analogon to python `*import* this *from* that``
% the idea is to NOT SAVE THE PATHDEF since MATLAB will get confused when
% you are working on multiple projects using the `mlAppFlex` tool
% the reason is that `mlAppFlex` does not have project specific
% functionsnames. Combine this with a First on List type of of selection
% process on the MATLAB `pathdef` and you get functions firing up on the
% hole disk
% 
% ... is a standard option when creating a new python project.
% dependencies are more clear to analyze.
% MATLABs works different but to keep things tidy
% I decided to add the file paths in a function.
%
%
% How It Works:
% 1. gather intel in a struct about project directory 
% 2. send that to a processor
% 3. and save the file to function directory with a predefined(1) filename
%
%  (1)( notice how I am trying to avoid the term "hardcoded")
%-----------Function Start----
%% filter out any level 1  directory 

pFolder_dirNames = levelOneDirQuery();

%read in .mignore file
delList           = mignore_reader();
[del_index, ~]    = ismember(pFolder_dirNames , delList);

% and disscard unneded files
pFolder_dirNames_screened = pFolder_dirNames(~del_index) ;

% options struct to hold the configureation options 
% which will passed over to the processor/core

opt     =   struct();
%----cut
for i =1 :numel(pFolder_dirNames_screened)
    
    qPar       = pFolder_dirNames_screened{i};
    m          = add_subfolder(qPar);
    m          = m.(qPar);
    opt.(qPar) = m;
end


%% [2] create the file

code_cell = addPath_creator_core(opt);

%% [3] write it down

addPath_creator_write(code_cell)

out= [datestr(now()),'  |  builder_addpath() created'];
disp(out)

end





function code_cell = addPath_creator_core(opt)

% define strings to put tegether
func_dec={'function builder_addPath()'};
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

%----
for i = 1:numel(cPar_array)

cPar = cPar_array{i} ;
cf   = fieldnames(opt.(cPar));
    % sure,... preallocate and stuff
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

    k=k+1;

    % insert comment header
header = {...
    '%% adds `builder` and custom function folders(only first level)';
    '% in a second run this function will also add the `mfiles` subdirectories';
    '% of each .mlapp-file.';
    '% ';
    '% :input: no input '; 
    '% :returns: void';
    '% ';
    '% :warning: ANY CHANGE IN THIS FUNCTION AUTOMATICALLY CREATED FUNCTION WILL BE LOST';
    '%           a) RATHER APPEND YOUR CODE TO the MOTHER FUNCTIONS :func:`addPath_creator` ';
    '%           b) OR WRITE YOUR OWN FUNCTIONS AND APPEND THEM TO THE FLOW';
    '% ';
    '% :todo: save your code in `mfiles` folder aswell ';
    '%        currently, a level beneeth `mfiles` is not recognized ';
    '% ';
    '% :todo: define/declare/offer standerdized `hooks` like in WordPress ';
    '% ';
    '% ';
    '% :note: see also: :ref:`addPath_creator() <addPath_creator>` ';
    '% ';
    '% ';
    ' ';
    };

code_cell=[func_dec;
           header;
           code_cell;
           func_end];


end


function addPath_creator_write(code_cell)
% write the results in a .m file
% if necessary create the folder for that file

ext=exist(fullfile('functions','auto_generated'),'dir');
if ext~=7
    mkdir(fullfile('functions','auto_generated'));
end

fid=fopen(fullfile('functions','auto_generated','builder_addPath.m'),'w');
if fid~=3
    error('builder_addPath.m could not be created (the file itself not the code)')
end

    % Write a cell array of strings to a *.m file
    % Assumes each cell is a separate line
    for ii = 1:size(code_cell,1)
        
        encoded_str = unicode2native(code_cell{ii}, 'UTF-8'); 
        fwrite(fid, [encoded_str, 10], 'uint8');

    end

fclose(fid);

end

