function mlappkit_setup()
    % :func:`mlappkit_setup` will walk a GUI designer (i.e. regular user)
    % through the setup during the first run on the user machine.
    % It will:
    %
    % #. suggest a target directory and let you confirm or change it
    % #. unpack the ``static files`` into the confirmed location
    % #. add those particular files to your MATLAB searchpath
    % #. and save your current MATLAB searchpath
    %
    %
    % A list of the files added as well as the procedure executed will be
    % saved in a log file.
    %
    % Before submitting files or content please clean them of your 
    % personal data.
    %
    
    
    % suggest a installation path
    install_path    =  fullfile(userpath(), 'mlAppKit');
    opt.Interpreter = 'tex';
    opt.Resize      = 'on';
    prompt = ['\fontsize{12} mlAppKit will be installed here ',... 
              '(will be created if it doesn`t exist)'];
    
    install_path = inputdlg(prompt, ...   % question
                           'Setup', ...
                 [1 90], ...              % window size
                 {install_path}, ...      % suggestion
                 opt);                    % styling options
    
    install_path = install_path{1};      % cast from cell
    
    if exist(install_path, 'dir') ~= 7  % create directory
        mkdir(install_path)
    end
    
    %
    % :todo: CREATE THE INSTALLATION BUNDLE / PACKAGE A RELEASE
    %

    % unzip bundle in target location
    unzip('mlAppKit_static_bundle.zip', install_path);
    
    % rename if nececary
    % movefile(fullfile(path_to_project,'test'),complete_path ,'f');
    
    % run the addpath cascade for the generic function and templates
    
    addpath(genpath(install_path));
    savepath;
    
    % drop log, save log, and I dialog, run next steps / getting started /
    % readme etc....
    
    fprintf('%s\n', '  Done. mlAppKit is installed in: ')
    fprintf('%s\n',   install_path );
    fprintf('%s\n', '  ');
    fprintf('%s\n', ' Next Steps:');
    fprintf('%s\n', '  ');
    fprintf('%s\n', ' target_dir = pwd(); ');
    fprintf('%s\n', ' prj_name = ''helloWorld'' ');
    fprintf('%s\n', ' mlappkit_quickstart( target_dir , prj_name ) ');
    
    
end