function quickstart_template_creator()
   % create a boilerplate from the current app 
   % and save it into functions/template/ <project_name>
   %
   % working directory == current_prj
   %
   % .. todo:: automate the quickstart template generation
   %
   %
   % .. todo:: great potential to remove redundant file copying code
   %
   %

    current_prj = pwd();
    
    project_name = 'mlappkit_qst';
    pseudo_random_str = char(randi([65, 90], [1, 20]));
    path_to_project = fullfile(userpath(), 'tmp_mlappkit', pseudo_random_str);
    complete_path = fullfile(path_to_project, project_name);
    
    %% create the minimum folder structure
    mkdir(complete_path)
    mkdir(fullfile(path_to_project, [project_name, '-docs']));
    mkdir(fullfile(complete_path, 'host'));
    mkdir(fullfile(complete_path, 'popups'));
    mkdir(fullfile(complete_path, 'firstplugin'));
    mkdir(fullfile(complete_path, 'functions', 'start_up'));
    mkdir(fullfile(complete_path, 'functions', 'panel_visibility'));
    mkdir(fullfile(complete_path, 'settings'));
    mkdir(fullfile(complete_path, 'docs'));
    
    fn_static = {'icons', 'audio', 'img', 'misc'};
    
    for j = 1: numel ( fn_static)
        mkdir(fullfile( complete_path, 'static', fn_static{j}));
    end
    
    clear j 
    %% create files
    mig = fopen(fullfile(complete_path, '.mignore'), 'w');
        fprintf(mig, '%s',['docs', newline()]);
        fprintf(mig, '%s',['static', newline()]);
        fprintf(mig, '%s',['readme', newline()]);
        fprintf(mig, '%s',['license', newline()]);
    fclose(mig);

    gitig = fopen(fullfile(complete_path, '.gitignore' ), 'w');
    fclose(gitig);

    %% copy a set of boilerplate apps
    
    [~ , ~, ~] = copyfile(...
            fullfile(current_prj, 'popups', 'popup_about.mlapp'), ...
            fullfile(complete_path , 'popups'), ...
            'f') ;
         
    [~ , ~, ~] = copyfile(...
            fullfile(current_prj, 'popups', 'popup_settings.mlapp'), ...
            fullfile(complete_path, 'popups' ), ...
            'f') ;
         
    [~ , ~, ~] = copyfile(...
            fullfile(current_prj, 'host', 'host_app.mlapp' ), ...
            fullfile(complete_path, 'host' ), ...
            'f');

    [~ , ~, ~] = copyfile(...
            fullfile(current_prj, 'firstplugin', 'calculator.mlapp'), ...
            fullfile(complete_path , 'firstplugin' ), ...
            'f');

    [~ , ~, ~] = copyfile(...
            fullfile(current_prj, 'firstplugin', 'redbutton.mlapp'), ...
            fullfile(complete_path, 'firstplugin'), ...
            'f');
         
    %% copy set of project specific functions
    % projectPaths.appuser = ...
    %    matlab.codetools.requiredFilesAndProducts(fullfile(pwd(), 'host','host_app.mlapp'))';

    [~ , ~, ~] = copyfile(...
            fullfile(current_prj, 'functions', 'panel_visibility', 'panel_visibility_switch.m'), ...
            fullfile(complete_path, 'functions', 'panel_visibility'), ...
            'f');
    [~ , ~, ~] = copyfile(...
            fullfile(current_prj, 'make.m'), ...
            fullfile(complete_path), ...
            'f');
    [~ , ~, ~] = copyfile(...
            fullfile(current_prj, 'functions', 'start_up', 'ext_start_up.m'), ...
            fullfile(complete_path, 'functions', 'start_up'), ...
            'f');
    % create a readme
    % write  a licence
    %% add  contents of the static/icons .. folder

    for j = 1:numel(fn_static)
        
        m = dir (fullfile(current_prj, 'static',  fn_static{j}));
        isfile = ~cell2mat({m.isdir}');
    
        m = m(isfile);
        s = cell(1, 1);
    
        for i = 1 : numel(m) 
            s{end+1, 1} = fullfile(m(i).folder, m(i).name);
        end
        s = s(2:end); % delete the empty first cell
    
        for i = 1:numel (s) 
            [~, ~, ~] =...
                copyfile(s{i},...
                         fullfile( complete_path , 'static', fn_static{j}), ...
                         'f') ;
        end
        clear m i s 
    end

    %% package it  
    % zip it   % copy it into template folder
    if  exist(fullfile(current_prj, 'functions', 'templates'), 'dir') ~= 7
        mkdir(fullfile(current_prj, 'functions', 'templates'));
    end
    
    zip(fullfile(current_prj, 'functions', 'templates', 'mlappkit_qst.zip'), ...
        complete_path);
    
    % delete temporary files
    rmdir(complete_path, 's');
   
end
