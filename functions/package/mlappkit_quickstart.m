function mlappkit_quickstart(path_to_project, projectName)
    % inspired by the sphinx-quickstart utility
    %
    % ask for the author ?
    % ask for the project name ?
    % known structure `? or build as you go ?
    % run the manual ?
    % error ('not operational yet')
    
    complete_path = fullfile(path_to_project,projectName);
    unzip ('mlappkit_qst.zip',path_to_project);
    
    movefile(fullfile(path_to_project,'test'),complete_path ,'f');

%    
%     
%     mkdir (complete_path)
%     mkdir (fullfile(path_to_project,[projectName,'-docs']));
% 
%     mkdir (fullfile( complete_path , 'functions'))
%     mkdir (fullfile( complete_path , 'host') );
%     mkdir (fullfile( complete_path , 'popups' ));
%     mkdir (fullfile( complete_path , 'settings' ));
%     mkdir (fullfile( complete_path , 'docs' ));
%     mkdir (fullfile( complete_path , 'static' ));
%     
%     % create files
%     mig= fopen(fullfile ( complete_path , '.mignore' ),'w');
%     fprintf(mig,'%s',['docs',newline()]);
%     fclose(mig);
% 
%     gitig=fopen(fullfile ( complete_path , '.gitignore' ),'w');
%     fclose(gitig);

    %
    % copy the necessary files
    
    % create a readme
    % write  a licence

end