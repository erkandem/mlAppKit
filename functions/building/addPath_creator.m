function addPath_creator()
%% create a function to add all relevant folders to the **current** MATLAB path
% [1] filter out any level 1  directory 
% [2] create the file calls 
% [3] write the function to an .m-file 

%% [1] filter out any level 1  directory
pFolder_dirNames = levelOneDirQuery();

% read in .mignore file
delList           = mignore_reader();
[del_index, ~]    = ismember(pFolder_dirNames , delList);

% and disscard unneded files
pFolder_dirNames_screened = pFolder_dirNames(~del_index) ;

% options struct to hold the configureation options 
opt     =   struct();
for i =1 :numel(pFolder_dirNames_screened)
    
    qPar       = pFolder_dirNames_screened{i};
    m          = add_subfolder(qPar);
    m          = m.(qPar);
    opt.(qPar) = m;
end


%% [2] create the file

code_cell = addPath_creator_core(opt);

%% [3] write the function to an .m-file 
%
% :todo: change addpath to addpath(genpath('file'))
%
addPath_creator_write(code_cell)

out= [datestr(now()),'  |  builder_addpath() created'];
disp(out)

end





function code_cell = addPath_creator_core(opt)
%% creates the addPath function from the previously obtained configuration
% :param opt: hold the configurations 
% :type opt: struct


% define some strings 
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


cPar_array=fieldnames(opt);

k=1; %line counter

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
%% writes the created function to a .m file

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

