function conversion_func_generator(project_dir)
    %% creates the function to extract .m-files out of .mlapp files

    if nargin == 0
        project_dir = pwd();
    end
    opt = project_parts();

    %% generate the function from the configuration struct
    code_cell = mat_codegen(opt);

    %% write result into an .m-file
    % write_conversion_launcher(code_cell);
   
	target_path = fullfile(project_dir, 'functions', 'auto_generated');
	file_name   = 'conversion_launcher.m';
	utf8_write_to_file(target_path, file_name, code_cell )

end

function code_cell_array = mat_codegen(opt)
    %% generates conversion_launcher

    %% ---------------- views ------------------------
    folder_names = fieldnames(opt.views);
    k = 1;
    for i = 1 : numel(folder_names)
        file_names = fieldnames(opt.views.(folder_names{i}));
        for j = 1 : numel(file_names)
            fmt = '    mlapp_to_m(fullfile(project_dir, ''%s'', ''%s.mlapp''), ''plugin'');';
            c1(k, 1) = {sprintf(fmt, folder_names{i}, file_names{j})};
            k = k + 1;        
        end
    end
    clear k  i j 

    %% ---------------- popups ------------------------
    folder_names = fieldnames(opt.popups);
    k = 1;
    for i = 1 : numel(folder_names)
        file_names = fieldnames(opt.popups.(folder_names{i})) ;
        for j = 1 : numel(file_names)
            fmt = '    mlapp_to_m(fullfile(project_dir, ''%s'', ''%s.mlapp''), ''popup'');';
            c2(k, 1) = {sprintf(fmt, folder_names{i}, file_names{j})};
            k = k + 1;
        end
    end
    clear k  i j

    %% ----------------- host ------------------------
    folder_names = {'host'};
    k = 1;
    for i = 1: numel(folder_names)
        
        file_names = fieldnames(opt.(folder_names{i})) ;
        for j = 1 : numel(file_names)
            fmt = '    mlapp_to_m(fullfile(project_dir, ''%s'', ''%s.mlapp''), ''host'');';
            c3(k, 1) = {sprintf(fmt, folder_names{i}, file_names{j})};
            k = k + 1;        
        end
    end
    clear k  i j

    %% ------------- collect number of lines ----------------------
    number_lines_c1 = size(c1, 1);
    number_lines_c2 = size(c2, 1);
    number_lines_c3 = size(c3, 1);

    total_number_lines = number_lines_c1 ...
                        + number_lines_c2 ...
                        + number_lines_c3 ...
                        + 2;  % 'function' definition and 'end'
    
    %% ------------- put the pieces together ----------------------
    k = 1;
    code_cell_array = cell(total_number_lines, 1);
    for n = 1 : 3
        if n == 1
            code_cell_array(k) = {'function conversion_launcher(project_dir)'};
            k = k + 1;
            for jj = 1 : numel(c1)
                code_cell_array(k, 1) = c1(jj);
                k = k + 1;
            end
        elseif n == 2
           for jj = 1 : numel(c2)
                code_cell_array(k, 1) = c2(jj);
                k = k + 1;
            end
        elseif n == 3
                code_cell_array(k, 1) = c3;
                k = k + 1;            
                code_cell_array(k) = {'end'};
        end
    end
    
    %% add a comment header to the created f(x)
    % contains sphinx rst formatting
    header = {...
    '    %% generates the `classdef` .m-files in the subdirectory' 
    '    % of each .mlapp-file called `mfiles` ';
    '    % ';
    '    % :input: no input '; 
    '    % :returns: void';
    '    % ';
    '    % .. warning:: ANY CHANGE IN THIS AUTOMATICALLY CREATED FUNCTION WILL BE LOST';
    '    %              a) RATHER APPEND YOUR CODE TO :func:`conversion_func_generator` ';
    '    %              b) OR WRITE YOUR OWN FUNCTIONS AND APPEND THEM TO THE FLOW';
    '    % ';
    '    % .. see also:: :ref:`conversion_func_generator() <conversion_func_generator>`_ ';
    '    % ';
    '     ';
    };

    % bugifx: call with abs rather than rel path 
    abs_path = {...
    '    ';
    '    if nargin == 0'           ;
    '        project_dir = pwd();';
    '    end';
    '    ';
    };

    % split codel_cell and recompose
    fDef      = code_cell_array(1, :);
    fBody     = code_cell_array(2:end, :);
    
    code_cell_array = [fDef;
                       header;
                       abs_path;
                       fBody];

end
