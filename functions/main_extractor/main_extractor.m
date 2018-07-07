function main_extractor(appname)

% light weight code to extract the shell component of the app to be created
% from the mlappp bloatet structure
% inspired and butchered from components in "mlapp2classdef"

if nargin ==0
    appname='host_app';
end


% post r2014 the code can be easily extracted via 2 lines of code ;)
    evalcstr = sprintf('type(''%s'')', fullfile('main', [appname,'.mlapp']));
    mymcode = evalc(evalcstr);
     if isspace(mymcode(1))
        mymcode(1) = [];
    end
    % Convert to cell array for compatibility with other routines
    mymcode = strsplit(mymcode, '\n', 'CollapseDelimiters', 0)';
    
    fid=fopen(fullfile('main', 'mfiles',[appname,'.m']),'w');

    % Write a cell array of strings to a *.m file
    % Assumes each cell is a separate line
for ii = 1:length(mymcode)
    fprintf(fid, '%s\n', mymcode{ii});
end
fclose(fid);

end