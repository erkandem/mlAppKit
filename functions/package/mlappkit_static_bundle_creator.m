function mlappkit_static_bundle_creator()
    % creates s bundle of static parts of mlappkkit
    % these functions are share with each project, since there is nothing
    % project specific about them
    %
    % .. warning:: untested
    %
    % system(['tree ',pwd(),' /f /a > foo.txt '])
    %
    currentPrj = pwd();
    
    projectName     = 'mlappkit_static_bundle';
    path_to_project = fullfile ( userpath()      , 'mlappkit_static_bundle');
    complete_path   = fullfile ( path_to_project , projectName) ;
    
    %% create the minimum folder structure
    mkdir (complete_path)

    mkdir (fullfile( complete_path , 'functions','building'))
    mkdir (fullfile( complete_path , 'functions','package'))
    mkdir (fullfile( complete_path , 'functions','templates'))
    mkdir (fullfile( complete_path , 'functions','setup'))

    %% copy buidling functions
    m = dir (fullfile ( currentPrj,'functions', 'building','*.m' ));
    
    s = cell(1,1);
    for i = 1 : numel(m) 
        s{end+1,1} = fullfile(m(i).folder,m(i).name);
    end
    s= s(2:end);
    
    for i = 1:numel ( s) 
    [~,~,~] =...
             copyfile( s{i},...
                       fullfile( complete_path , 'functions','building' ),...
                       'f') ;
    end
    
    clear m i s 
    %% copy package functions
    
    m = dir (fullfile ( currentPrj,'functions', 'package','*.m' ));
    
    s = cell(1,1);
    for i = 1 : numel(m) 
        s{end+1,1} = fullfile(m(i).folder,m(i).name);
    end
    s= s(2:end);
    
    for i = 1:numel ( s) 
        [~,~,~] =...
                 copyfile( s{i},...
                           fullfile( complete_path , 'functions','package' ),...
                            'f') ;
    end
       clear m i s 
    %% copy the quickstart function
    
   [~,~,~] =...
         copyfile( fullfile( currentPrj,'functions','setup' ,'mlappkit_quickstart.m'),...
                   fullfile( complete_path , 'functions','setup' ),...
                    'f') ;    
    %% copy the quickstart template
    if exist(fullfile(currentPrj,'functions','templates','mlappkit_qst.zip'),'file') ~= 2
        error ( 'run the generic bundle packager first')
    end
    
    [~,~,~] =...
         copyfile( fullfile( currentPrj,'functions','templates' ,'mlappkit_qst.zip'),...
                   fullfile( complete_path , 'functions','templates' ),...
                    'f') ;

   %% package it  
   % zip it   % copy it into template folder
   if  exist(fullfile(currentPrj,'functions','templates'),'dir')~= 7 
       mkdir (fullfile(currentPrj,'functions','templates'));
   end
   
   zip(complete_path,complete_path);
    %% copy the setupfile on the toplevel
    
    [~,~,~] =...
         copyfile( fullfile( currentPrj,'functions','setup' ,'mlappkit_setup.m'),...
                   fullfile( path_to_project ),...
                    'f') ;    
   rmdir(complete_path, 's');

    %% copy the package into the templates directory
    zip(fullfile(currentPrj,'functions','templates','mlappkit_static_bundle.zip'),...
       path_to_project);
   
   
   % delete temporary files
   rmdir(path_to_project, 's');
   
   
end
