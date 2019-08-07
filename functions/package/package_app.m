function package_app(confi)
    %% enable the user to create copy all dependencies into a single folder
    %
    % :param confi: configuration struct (optional)
    % :type confi: struct
    %
    % .. todo:: (a) beware of duplicate filename conflict !
    %
    %
    % .. todo:: (b) offer option to reproduce source directory structure
    %
    %
    % .. todo:: (c) also copy the `static` folder, with assets like icon...
    %
    % .. todo:: (d) some kind of `launch_app` routine, to account fot the
    %           different file locations seethe  `todos` (a), (b) and(c)
    %

    if nargin == 0
        confi = struct();
        confi = package_app_query_part(confi);
    end

    % final configuration could be offered to the user
    package_app_export_part(confi)
    fprintf('<strong>Done!</strong>\n');
    
end

function confi = package_app_query_part(confi)
    %% returns some default (source) packaging options

    fn_confi = fieldnames(confi);
    
    % make a default selection of the parts of the application to package
    %
    current_dir      = pwd();
    slashes_pos      = regexp(current_dir,filesep() );
    projectFolder   = current_dir(slashes_pos(end)+1:end);
    folderPath      = current_dir(1:slashes_pos(end)-1);
    fullProjectPath = current_dir;
        
    confi.('projectFolder')      = projectFolder ;
    confi.('fullProjectPath')    = fullProjectPath ;
     
    % ask for the default file and folder name?
    % default rojectname + timestamp for now
    if  isempty(fn_confi)
        confi.('fileName') = [projectFolder, '_', datestr(now(), 'yyyymmddHHMMSS')];
    end
    
    if  isempty(fn_confi)
        confi.('folderPath') = folderPath ;
    end
    
    % parts to package - run MATLABs dependency analysis
    if  isempty(fn_confi)

        fList = matlab.codetools.requiredFilesAndProducts(...
            fullfile(confi.('fullProjectPath'), 'host', 'mfiles', 'host_app.m'));
        fList = fList(:);
        confi.('fList') = fList;
    end

    %% add contents of the static/icons .. folder
    fn_static = {'icons', 'audio', 'img', 'misc'};

    for j = 1:numel(fn_static)
        
        m = dir(fullfile(confi.('fullProjectPath'), 'static',  fn_static{j}));
        isfile = ~cell2mat({m.isdir}');
    
        m = m(isfile);
        s = cell(1, 1);
    
        for i = 1 : numel(m) 
            s{end+1,1} = fullfile(m(i).folder, m(i).name);
        end
        s = s(2:end); % delete the empty first cell
        confi.('fList')=[ confi.('fList'); s];
    end
 
end

function package_app_export_part(confi)
    %% apply the previously obtained export configuration

    % create a  project directory
    targetDir = fullfile(confi.('folderPath'), confi.('fileName'));
    confi.('targetDir') = targetDir ;
    
    if exist( confi.('targetDir'), 'dir') ~= 7
        mkdir(confi.('targetDir'));
    end


    for i = 1: numel(confi.('fList'))
        % copies files into one single directory
        % .. todo:: write a filename check to prevent overwriting existing files
        %
        slashpos = regexp(confi.('fList'){i}, filesep());
        fName = confi.('fList'){i}(slashpos(end)+1 : end);
        target_loc = fullfile (confi.('targetDir'), fName);
        copyfile(confi.('fList'){i}, target_loc)    
    end
    
    target_dir   = dir(confi.('targetDir'));
    target_names = {target_dir.name};
    target_isdir = [target_dir.isdir];
    target_names = target_names(~target_isdir );
     
    % zip(zipfilename, filenames, rootfolder)
    zip(fullfile(confi.('targetDir'), [confi.fileName, '.zip']),...
        target_names,...
        confi.('targetDir'))
    fprintf('The project was packaged at:\n %s\n', target_dir)
    
end
