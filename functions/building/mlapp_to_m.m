%% extract modify save
function mlapp_to_m(mlappfile_loc,view_type)
    % Hardest part is to identify the methods and properties to edit
    % :param mlappfile_loc: filepath to the .mlapp file which is going to be linked
    % :param view_type: one of the three specific view types


    %% [I] get the code from the mlapp file
    % post r20XX the code can be easily extracted via 2 lines of code ;)
    % thx @ mlapp2classdef()
    [fpath, appname, ~] = fileparts(mlappfile_loc);
    evalcstr = sprintf('type(''%s'')', fullfile(fpath, [appname,'.mlapp']));
    my_m_code = evalc(evalcstr);
    
    if isspace(my_m_code(1))
        my_m_code(1) = [];
    end
    
    % Convert to cell array for compatibility with other routines
    my_m_code = strsplit(my_m_code, '\n', 'CollapseDelimiters', 0)';

    %% [II] edit the acquired code 
    % [0] find the component declarations and edit them 
    %           currently (R2018a/b) buttons, menu, etc. are defined 
    %           in the first paragraph after the "calssdef" string 
    switch view_type
    case {'popup'}    
    case {'host'}    
    case {'plugin'}
        %% lines to comment out completly 
        % [1.1] comment out the `self`.UI Figure declaration
        ui_index1  = find( ~cellfun('isempty',(regexp(my_m_code,'\w*matlab.ui.Figure\w*') ) ));
        
        % while we are there, get the handle of the UIFigure
        uif_handle = split(strtrim(my_m_code{ui_index1}));
        uif_handle = uif_handle{1};

        % [1.2] comment the createComponents instructions referencing to UI Figure
        ui_index2  =  find( ~cellfun('isempty',(regexp(my_m_code,['[.]',uif_handle,'[.]']     ) ) ));
        
        % [1.3] 
        ui_index3  =  find( ~cellfun('isempty',(regexp(my_m_code,['[.]',uif_handle,'\s'] ) ) ));
        
        % [1.4] comment "delete("
        ui_index4  =  find( ~cellfun('isempty',(regexp(my_m_code,['delete(app[.]',uif_handle] ) )) );
        
        % [1.5] comment "register("
        ui_index5  =  find( ~cellfun('isempty',(regexp(my_m_code,'(registerApp.*)'            ) )) );
        
        ui_index_1to5   =   unique([ui_index1;
                                    ui_index2;
                                    ui_index3;
                                    ui_index4;
                                    ui_index5]);
        % just add a " % " at the front 
            for z = 1: numel(ui_index_1to5 )
        	    my_m_code(ui_index_1to5 (z)) ={['%', my_m_code{ui_index_1to5 (z)}]};
            end
        %% lines to customize

        % [1.6]  add a `uifigure` parameter to `class constructor` declaration
        % function app = icbm --------> app = icbm(external_handle)
        ui_index6  =  find( ~cellfun('isempty',(regexp(my_m_code,'function app =') )) );
        new_code=['            function app = ',appname,'(external_handle) % $_$ flipped '];
        
        % replace complete line
        my_m_code(ui_index6(1)) ={new_code };    

        % [1.7]  add the parameter to `createComponents` function
        % declaration aswell
        ui_index7  =  find( ~cellfun('isempty',(regexp(my_m_code,'createComponents[(]app[)]') )) );
        new_code=' createComponents(app,external_handle) % $_$ flipped ';
    
        for z=1:numel(ui_index7)
            my_m_code(ui_index7(z)) =...
            {regexprep(my_m_code{ui_index7(z)},'createComponents[(]app[)]',{new_code })  } ;   
        end
    
        % [1.8] switch parameter passed to the main_Panel from `self.UIFigure`to`host.UIFigure`
        ui_index8  =  find( ~cellfun('isempty',(regexp(my_m_code,['uipanel(app[.]',uif_handle]) )) );
        ui_index8   =  unique(ui_index8);
            
        for z = 1: numel(ui_index8)
            my_m_code(ui_index8(z)) ={ regexprep( my_m_code{ui_index8(z)},['app[.]',uif_handle],'external_handle') };
        end
    
    otherwise
       error('Could not identify - "popup" "host" or "plugin" ?')
    end

    %% [III] write and quit
    target_path = fullfile(fpath, 'mfiles');
    file_name   = [appname,'.m'];
    utf8_write_to_file(target_path, file_name, my_m_code )
    
end

function     utf8_write_to_file(target_path, file_name, my_m_code )
    % [1] check for an existing filepath to "mfiles" subdirectory
    if exist(target_path ,'dir')~=7
        mkdir(target_path );
    end
    
    % [2] create file write code
    fid=fopen(fullfile(target_path,file_name),'w');
  
    for i = 1:numel(my_m_code)
        encoded_str = unicode2native(my_m_code{i}, 'UTF-8'); 
        fwrite(fid, [encoded_str, 10], 'uint8');
    end

    fclose(fid);
    out= [datestr(now()),'  |  ',fullfile(target_path,file_name),' created'];
    disp(out)
end
