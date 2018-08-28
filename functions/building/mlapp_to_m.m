%% extract modify save
function mlapp_to_m(mlappfile_loc,view_type)
% Hardest part is to identify the methods and properties to edit

% :param mlappfile_loc: filepath to the .mlapp file which is going to be linked
%
% :param view_type: one of the three specific view types


%% [I] get the code from the mlapp file

[fpath, appname, ~] = fileparts(mlappfile_loc);

switch view_type
    case {'popup'}
        
    case {'host'}
    case {'plugin'}
    otherwise
       error('"popup" "host" or "plugin" ?')
end

%-----

% post r2014 the code can be easily extracted via 2 lines of code ;)
    evalcstr = sprintf('type(''%s'')', fullfile(fpath, [appname,'.mlapp']));
    my_m_code = evalc(evalcstr);
    
     if isspace(my_m_code(1))
        my_m_code(1) = [];
     end
    
    % Convert to cell array for compatibility with other routines
    my_m_code = strsplit(my_m_code, '\n', 'CollapseDelimiters', 0)';
%-----
%% [II] edit the aquired code 
% [0] find the component declarations and edit it 
%           currently (R2018a/b) buttons menu etc are defined 
%           in the first paragraf after the "calssdef" string 
switch view_type
    case {'popup'}
        
    case {'host'}
        
    case {'plugin'}

excerpt = p_block(my_m_code);
% unpack response
if isa(excerpt,'struct') && numel(fieldnames(excerpt))~=0
    
    tmpblock = excerpt.tmpblock;
    p_start  = excerpt.p_start;
    p_end    = excerpt.p_end;

else
    error('no p-block identified');
end
% [1.1]   cache the UI Figure component name for later replacement
[tmpblock, uif_handle ]   = uif_commenter(tmpblock);
uif_handle= uif_handle{1};

my_m_code(p_start: p_end,1) =               tmpblock;

% [1.2] comment the createComponents instructions referencing to UI Figure 
% [1.3] comment "delete("
% [1.4] comment "register("
%my_m_code   =   uif_create_commenter(my_m_code, uif_handle);
for gamma=1 %---fold
ui_index1  =  find( ~cellfun('isempty',(regexp(my_m_code,['[.]',uif_handle,'[.]']     ) ) ));
ui_index2  =  find( ~cellfun('isempty',(regexp(my_m_code,['[.]',uif_handle,'\s']      ) ) ));
ui_index3  =  find( ~cellfun('isempty',(regexp(my_m_code,['delete(app[.]',uif_handle] ) )) );
ui_index4  =  find( ~cellfun('isempty',(regexp(my_m_code,'(registerApp.*)'            ) )) );

ui_index   =   unique([ui_index1  ;ui_index2; ui_index3; ui_index4]);

            % just add a " % " at the front 
            for z = 1: numel(ui_index)
                my_m_code(ui_index(z)) ={['%', my_m_code{ui_index(z)}]};
            end
end %----fold%%%%% OK %%%%%
 
% [1.5]  edit the createComponents function declaration
% my_m_mcode  =   uif_createComponents_switcher(my_m_code, appname);

for gamma =1
% function app = icbm------------------------->app = icbm(external_handle)

            ui_index  =  find( ~cellfun('isempty',(regexp(my_m_code,'function app =') )) );
            new_code=['            function app = ',appname,'(external_handle) % $_$ replaced '];
            
            % replace complete line
            z=1;
            my_m_code(ui_index(z)) ={new_code };    
            
            ui_index  =  find( ~cellfun('isempty',(regexp(my_m_code,'createComponents[(]app[)]') )) );
            new_code=' createComponents(app,external_handle) % $_$ replaced ';
            
            % replace complete line
            for z=1:numel(ui_index)
                my_m_code(ui_index(z)) =...
                    {regexprep(my_m_code{ui_index(z)},'createComponents[(]app[)]',{new_code })  } ;   
            end
end %--- fold
% [1.6] switch out the parameter passed to the main_Panel 
 %my_m_code  =  uif_panel_paramater_switcher(my_m_code,uif_handle);
for gamma =1
            ui_index3  =  find( ~cellfun('isempty',(regexp(my_m_code,['uipanel(app[.]',uif_handle]) )) );
            
            ui_index   =   unique([ui_index3 ]);
            
            for z = 1: numel(ui_index)
                my_m_code(ui_index(z)) ={ regexprep( my_m_code{ui_index(z)},['app[.]',uif_handle],'external_handle') };
            end
    
end %---fold

    otherwise
       error('"popup" "host" or "plugin" ?')
end

%% [III] write and quit

% [1] check for an existing filepath to "mfiles" subdirectory

    if exist(fullfile(fpath, 'mfiles'),'dir')~=7
        mkdir(fullfile(fpath, 'mfiles'));
    end
% [2] create file write code


    fid=fopen(fullfile(fpath, 'mfiles',[appname,'.m']),'w');
  
  %   fid = fopen('lol.m','w');
  % UTF-8 for compatibility reasons-
  % e.g. documenting the project with sphinx ( takes only utf8 input)
  
for i = 1:numel(my_m_code)
    % fprintf(fid, '%s\n', my_m_code{i}); % dependend on local encoding
    encoded_str = unicode2native(my_m_code{i}, 'UTF-8'); 
    fwrite(fid, [encoded_str, 10], 'uint8');

end


fclose(fid);

out= [datestr(now()),'  |  ',fullfile(fpath, 'mfiles',[appname,'.m']),' created'];
disp(out)
end

        

function excerpt = p_block(my_m_code)
% a subfunction which takes care of paring keywords with their respective
% ``end`` tag - This part is  in courtesy of `mlapp2classdef <https://github.com/StackOverflowMATLABchat/mlapp2classdef>`_
%
%

p_block_start = ...
find(~cellfun('isempty', regexp(my_m_code, '^\s*properties', 'start')));

end_statements = ...
find(~cellfun('isempty', regexp(my_m_code, '^\s*end', 'start')));


if ~isempty(p_block_start)
    % We have at least one property block
    % Pair property block(s) with their end statement(s). Assumes that
    % the end statement following each property closes the property
    % block, so any logic control inside the property block will be
    % broken
    n_p_blocks       = length(p_block_start );
    p_block_pair = zeros(n_p_blocks, 2);
    
    for j = 1 
        p_block_pair(j, 1) = p_block_start(j);
        
        % Find first end statement after the property block declaration
        end_statements_after       = end_statements(end_statements > p_block_start(j));
        p_block_pair(j, 2) = (min(end_statements_after));
        
        % excerpt
        
        p_start = p_block_pair(j,1)+ 1 ;
        p_end   = p_block_pair(j,2)- 1;
        
        excerpt.tmpblock = my_m_code(p_start : p_end);   
        
        
        excerpt.p_start = p_start ;
        excerpt.p_end   = p_end ;
        
    end
        
end
    
end