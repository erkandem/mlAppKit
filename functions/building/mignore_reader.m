

function c = mignore_reader()
% Subfunction handling files and folders to ignore with respect to building
% the application / ``classdef`` files

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