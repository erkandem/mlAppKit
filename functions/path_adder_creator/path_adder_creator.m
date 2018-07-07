function path_adder_creator()
%% python virtual environment ...
% what?
% is a standard option when creating a new project.
% dependencies are more clear to analyze.
% MATLABs works different but to keep things tidy
% I decided to add the file paths in a function.
%
% An analogon to this would be a "requirements.txt" file in the master
% directory and and "import this from that"
%
% How?
% 1. gather intel in a struct 
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
a_Name_dir = a_Name_dir(~boolV) ;

%% part [1.I] add the functions


%% part [1.II]add the main app


%% part [1.III] add the m-class defs


%% [2] create the file


%% [3] write it down

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