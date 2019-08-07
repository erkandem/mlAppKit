function mlappkit_quickstart(path_to_project, projectName)
    % inspired by the ``sphinx-quickstart`` utility
    %
    % ask for the author ?
    % ask for the project name ?
    % known structure `? or build as you go ?
    % run the manual ?
    % error ('not operational yet')
    
    complete_path = fullfile(path_to_project, projectName);
    unzip('mlappkit_qst.zip', path_to_project);
    
    movefile(fullfile(path_to_project, 'mlappkit_qst'), complete_path, 'f');
end
