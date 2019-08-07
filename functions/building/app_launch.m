function app_launch()
    %% scans the root directory for the ``host app`` and launches it from its ``.mlapp`` file
    %

    dir_query  = dir(fullfile('host', '*.mlapp')); % dir_query = dir(fullfile('host', 'mfiles' '*.m'));
    is_dir     = {dir_query.isdir};
    file_names = {dir_query.name};
    file_names = file_names(~cell2mat(is_dir)) ;
    file_names = file_names(:);
    if numel(file_names) > 1
        fprintf('%s\n', 'WARNING!, Found more than one .mlapp file in `host` directory.\nLaunching first one.')
    end
    file_names  =   file_names{1};

    % strip off extension
    dotloc =  regexp(file_names, '[.]');
    app_name  =  file_names(1:dotloc-1);
    out = [datestr(now()),'  |  starting app: `', app_name, '`'];
    fprintf('%s\n', out);
    eval(app_name);

end
