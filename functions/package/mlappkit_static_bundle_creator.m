function mlappkit_static_bundle_creator()
    %% creates a bundle of static parts of mlappkit
    % These functions are shared with each project
    %
    % .. warning:: untested
    %
    % system(['tree ',pwd(),' /f /a > foo.txt '])
    %

    %% path intel
    conf.current_dir       = pwd();
    conf.slashesPos        = regexp(conf.current_dir, filesep());
    conf.project_folder    = conf.current_dir(conf.slashesPos(end)+1 : end);
    conf.folder_path       = conf.current_dir(1 : conf.slashesPos(end)-1);
    conf.full_project_path = conf.current_dir;

    conf.project_name    = [conf.project_folder, '_static_bundle'];
    conf.path_to_project = fullfile(userpath(), conf.project_name);
    conf.complete_path   = fullfile(conf.path_to_project, conf.project_name);
    
    %% create minmal folder structure
    mkdir(conf.complete_path)
    mkdir(fullfile(conf.complete_path, 'functions', 'building'))   % [i  ]
    mkdir(fullfile(conf.complete_path, 'functions', 'package'))    % [ii ]
    mkdir(fullfile(conf.complete_path, 'functions', 'setup'))      % [iii]
    mkdir(fullfile(conf.complete_path, 'functions', 'templates'))  % [iv ]

    %% copy buidling functions [ i   ]
    m = dir (fullfile ( conf.current_dir, 'functions', 'building', '*.m'));
    
    s = cell(1, 1);
    for i = 1 : numel(m) 
        s{end+1, 1} = fullfile(m(i).folder, m(i).name);
    end
    s = s(2:end);
    
    for i = 1:numel (s) 
    [~, ~, ~] = copyfile(...
        s{i},...
        fullfile(conf.complete_path, 'functions', 'building'),...
        'f') ;
    end
    
    clear m i s

    %% copy packaging functions [ ii  ]
    m = dir(fullfile(conf.current_dir, 'functions', 'package', '*.m'));
    
    s = cell(1, 1);
    for i = 1 : numel(m) 
        s{end+1, 1} = fullfile(m(i).folder, m(i).name);
    end
    s = s(2:end);
    
    for i = 1 : numel(s) 
        [~ , ~, ~] = copyfile(...
            s{i},...
            fullfile(conf.complete_path , 'functions', 'package'),...
            'f');
    end
    clear m i s

    %% copy the quickstart function  [ iii ]
    [~ , ~, ~] = copyfile(...
        fullfile(conf.current_dir, 'functions', 'setup', 'mlappkit_quickstart.m'),...
        fullfile(conf.complete_path, 'functions', 'setup'),...
        'f');

    %% copy the quickstart template    [ iv  ]
    if exist(fullfile(conf.current_dir, 'functions', 'templates', 'mlappkit_qst.zip'), 'file') ~= 2
        error('run the generic bundle packager first')
    end
    
    [~ , ~, ~] = copyfile(...
        fullfile(conf.current_dir, 'functions', 'templates', 'mlappkit_qst.zip'),...
        fullfile(conf.complete_path, 'functions', 'templates' ),...
        'f');

    %% zip it  [ v ]
    if  exist(fullfile(conf.current_dir, 'functions', 'templates'),'dir') ~= 7
        mkdir(fullfile(conf.current_dir, 'functions', 'templates'));
    end
   
    zip(conf.complete_path, conf.complete_path);

    %% copy the setupfile into the toplevel  [ vi ]
    [~, ~, ~] = copyfile(...
        fullfile(conf.current_dir, 'functions', 'setup', 'mlappkit_setup.m'),...
        fullfile(conf.path_to_project),...
        'f');    
    rmdir(conf.complete_path, 's');

    %% copy the package into the templates directory [ vii ]
    zip(...
        fullfile(conf.current_dir, 'functions', 'templates', [conf.project_name, '.zip']),...
        conf.path_to_project);

   %% delete temporary files and folders [ vii ]
   rmdir(conf.path_to_project, 's');
   
end
