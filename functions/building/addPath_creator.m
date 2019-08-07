function addPath_creator(project_dir)
    %% create a function to add all relevant folders to the **current** MATLAB path
    %
    % 1. filter out any level one directory 
    % 2. create the file calls 
    % 3. write the function to an .m-file
    %
    if nargin == 0
        project_dir = pwd();
    end

    pFolder_dirNames = levelOneDirQuery();
    delList = mignore_reader();
    [del_index, ~] = ismember(pFolder_dirNames, delList);
    pFolder_dirNames_screened = pFolder_dirNames(~del_index);

    % options struct to hold the configureation  
    opt = struct();
    for i = 1 :numel(pFolder_dirNames_screened)
        qPar       = pFolder_dirNames_screened{i};
        m          = add_subfolder(qPar);
        m          = m.(qPar);
        opt.(qPar) = m;
    end

    code_cell = addPath_creator_core(opt);
    target_path = fullfile(project_dir, 'functions', 'auto_generated');
    file_name = 'builder_addPath.m';
    utf8_write_to_file(target_path, file_name, code_cell)

end


function code_cell = addPath_creator_core(opt)
    %% creates the addPath function from the previously obtained configuration
    % :param opt: configuration
    % :type opt: struct
    % 

    cPar_array = fieldnames(opt);
    k = 1;

    for i = 1:numel(cPar_array)
        cPar = cPar_array{i};
        cf   = fieldnames(opt.(cPar));
        for jj = 1 : numel(cf)
            fmt = '    addpath(fullfile(''%s'', ''%s''));';
            code_cell{k, 1} = sprintf(fmt, cPar, cf{jj});
            k = k + 1;
        end
    end
    
    header = {...
        '    %% adds `builder` and custom function folders(only first level)';
        '    % in a second run this function will also add the `mfiles` subdirectories';
        '    % of each .mlapp-file.';
        '    % ';
        '    % :input: no input '; 
        '    % :returns: void';
        '    % ';
        '    % .. warning:: ANY CHANGE IN THIS AUTOMATICALLY CREATED FUNCTION WILL BE LOST';
        '    %              a) RATHER APPEND YOUR CODE TO :ref:`addPath_creator` ';
        '    %              b) OR WRITE YOUR OWN FUNCTIONS AND APPEND THEM TO THE FLOW';
        '    % ';
        '    % .. todo:: save your code in `mfiles` folder aswell ';
        '    %           currently, a level beneeth `mfiles` is not recognized ';
        '    % ';
        '    % .. todo:: define/declare/offer standerdized `hooks` like in WordPress ';
        '    % ';
        '    % ';
        '    % ';
        '    % ';
        '    % ';
        '     ';
        };
    
    static_folder = {sprintf('    addpath(genpath(fullfile(''static'')));')};
    code_cell = [{'function builder_addPath()'};
                header;
                code_cell;
                static_folder;
                {'end'}];

end
