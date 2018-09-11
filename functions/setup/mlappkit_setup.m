function mlappkit_setup()

    % This is Setup script to installl mlAppKit 
    % the Setup will:
    %
    % #. suggest and let you confirm the target directory
    % #. unpack the generic files into the confirmed location
    % #. add those particular files to your MATLAB searchpath
    % #. save your current MATLAB searchpath
    %
    % :todo: CREATE THE INSTALLATION BUNDLE / PACKAGE A RELEASE
    %
    % If at any time you should notice that something broke on your 
    % system please report the issue o the respective GitHub page with
    % some Background on the environment in which  it failed.
    %
    % A list of the files added as well as the procedure executed will be
    % saved in a log file.
    %
    % Before submit and files or content please clean them of your 
    % personal data.



    % make  a default selection on the installation path
    install_path    =  fullfile ( userpath, 'mlAppKit');
    opt.Interpreter = 'tex';
    opt.Resize      = 'on';
    prompt = ['\fontsize{12} mlAppKit will be installed here ',... 
              '(will be created if it doesn`t exist)'];

    install_path = inputdlg(prompt, ...  % question
                           'Setup',...
                 [1 90],...              % window size
                 {install_path},...      % suggestion
                 opt);                   % styling options

    install_path = install_path{1};      % cast from cell

    if exist( install_path  ,'dir') ~=7  % create directory
        mkdir( install_path  )
    end

    %
    % :todo: CREATE THE INSTALLATION BUNDLE / PACKAGE A RELEASE
    %

    % unzip bundle in target location
    unzip ('mlAppKit_bundle.zip',path_to_project);

    % rename if nececary
    % movefile(fullfile(path_to_project,'test'),complete_path ,'f');

    % run the addpath cascade for the generic function and templates

    addpath(genpath ( path_to_project));
    savepath;

    % drop log, save log, and I dialog, run next steps / getting started /
    % readme etc....
end