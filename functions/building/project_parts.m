function opt = project_parts()
% Analyze the project structure
% Uses the :ref:`mignore_reader() <mignore_reader>`
%

%% filter out any level 1  directory 
    a_Name_dir            = levelOneDirQuery();
    ignore_list           = [mignore_reader();{'functions'}];
    [del_index, line_num] = ismember(ignore_list,a_Name_dir);
    a_Name_dir_filted     = a_Name_dir;

    a_Name_dir_filted(line_num(del_index))=[];

%% the host folder contains
% remove "main" from "to parse" list
 
    meta = dir ( fullfile('host','*mlapp') );
    lfn = {meta.name};
    opt.host =struct();
    emsg= ['Sad to say: the dir query in the `host` folder resulted in more than one `.mlapp` file'];
    if  numel(lfn) > 1; error(emsg);end
    j = 1;
    % strip of file extension
    dotloc =  regexp(lfn{j},'[.]');
    fName  =  lfn{j}(1:dotloc-1);
    opt.host.(fName) = true;
        
    [a,b] = ismember('host',a_Name_dir_filted);
    a_Name_dir_filted(b(a)) = [];
    clear a b j
    
%% scan the the pop-ups folder

    opt.popups=struct();
    opt.popups.popups= struct();
    
    meta = dir ( fullfile('popups','*mlapp'));
    lfn = {meta.name};
    
    for j=1:numel(lfn)
        % strip of file extension
        dotloc =  regexp(lfn{j},'[.]');
        fName  =  lfn{j}(1:dotloc-1);
        opt.popups.popups.(fName)=true;
    end
    
% remove "pop-ups" from "to parse" list
    [a,b] = ismember('popups',a_Name_dir_filted);
    a_Name_dir_filted(b(a)) = [];

clear a b 

%% any other folder lavel 1 plugin 
%
% :todo: figure out a way to deal with child menus in the menu
%
    opt.views=struct();
    for i = 1:numel( a_Name_dir_filted)
    
        opt.views.(a_Name_dir_filted{i}) = struct();
    
        meta = dir ( fullfile(a_Name_dir_filted{i},'*mlapp'));
        lfn = {meta.name};
    
        for j=1:numel(lfn)
            % strip of file extension
            dotloc =  regexp(lfn{j},'[.]');
            fName  =  lfn{j}(1:dotloc-1);
            opt.views.(a_Name_dir_filted{i}).(fName)=true;
        end
    end
    
end