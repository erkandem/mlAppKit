function package_app(confi)
%% enable the user to create  files to compile or distribute as source
%
% :param confi: configuration struct (optional)
% :type struct:
%
    if nargin == 0
        confi    = struct();
        confi    = package_app_query_part(confi);
    end

    % final configuration could be offered to the user
    package_app_export_part(confi)
    
    msgbox('Done!');
    
end

function confi = package_app_query_part(confi)
%% returns some default (source) packaging options
    fn_confi = fieldnames(confi);
    
    % make a default selection of the parts of the application to package
    currentDir = pwd();
    if ismac || isunix
        pathsep= '/';
    elseif ispc
        pathsep = '\';
    end
    
    slashesPos      = regexp(currentDir,pathsep);
    projectFolder   = currentDir (slashesPos(end)+1:end);
    folderPath      = currentDir (1:slashesPos(end)-1);
    fullProjectPath = currentDir;
        
    confi.('projectFolder')        = projectFolder ;
    confi.('fullProjectPath')    = fullProjectPath ;
     
    % ask for the default file and folder name
    if  isempty(fn_confi)
        confi.('fileName') = [projectFolder,'_',datestr(now(),'yyyymmddHHMMSS')];
    end
    
    if  isempty(fn_confi)
        confi.('folderPath') =         folderPath ;
    end
    
    % parts to package
    if  isempty(fn_confi)

    fList = matlab.codetools.requiredFilesAndProducts(...
        fullfile(confi.('fullProjectPath'),'host','mfiles','host_app.m'));
    fList = fList(:);
    confi.('fList')=fList;
    
    end
    
end

function package_app_export_part(confi)
%% apply the previously obtained export configuration 

% create a  project directory
    targetDir = fullfile(  confi.('folderPath'), confi.('fileName'));
    confi.('targetDir') = targetDir ;
    
    if exist( confi.('targetDir'),'dir') ~=7
        mkdir(confi.('targetDir'));
    end

    if ismac || isunix
        pathsep= '/';
    elseif ispc
        pathsep = '\';
    end
    
    for i = 1: numel(confi.('fList'))
        % copies files into one single directory
        % :todo: write a filename check to prevent overwriting
        slashpos = regexp(confi.('fList'){i}, pathsep);
        
        fName    = confi.('fList'){i}(slashpos (end)+1 :end);
        
        target_loc   = fullfile (confi.('targetDir') ,fName );
        
        copyfile( confi.('fList'){i}, target_loc )    
        
    end
    
    target_dir = dir ( confi.('targetDir'));
    target_names = {target_dir.name};
    target_isdir = [target_dir.isdir];
    target_names= target_names(~target_isdir );
     
    zip(fullfile ( confi.('targetDir'), [confi.fileName,'.zip']) ,...
        target_names,...
        confi.('targetDir'))
    

end