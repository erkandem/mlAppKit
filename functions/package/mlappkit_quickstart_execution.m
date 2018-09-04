function mlappkit_quickstart_execution(project_dir)
% inspired by the sphinx-quickstart utility


% ask for the author ?
% ask for the project name ?
% known structure `? or build as you go ?
% run the manual ?
error ('not operational yet')

mkdir (project_dir)
mkdir (project_dir,'-docs');

mkdir (fullfile( project_dir, 'functions'))
mkdir (fullfile( project_dir, 'host_app') );
mkdir (fullfile( project_dir, 'popups' ));
mkdir (fullfile( project_dir, 'settings' ));
mkdir (fullfile( project_dir, 'docs' ));

% create files
mig= fopen(fullfile ( project_dir, '.mignore' ));
fclose(mig);

gitig=fopen(fullfile ( project_dir, '.gitignore' ));
fclose(gitig);

% create a readme
% write  a licence

end