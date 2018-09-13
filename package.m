

tic
make()

close all force
s = struct();
 
s.currentDir      = pwd();
s.slashesPos      = regexp(s.currentDir,filesep() );
s.projectFolder   = s.currentDir (s.slashesPos(end)+1:end);
s.folderPath      = s.currentDir (1:s.slashesPos(end)-1);
s.fullProjectPath = s.currentDir;

quickstart_template_creator()

mlappkit_static_bundle_creator()

%% prepare new batch of documentation files
s.folderName = [s.projectFolder,'-docs'];

rmdir(fullfile('..',s.folderName,'latex'   ), 's');    
rmdir(fullfile('..',s.folderName,'html'    ), 's');    
rmdir(fullfile('..',s.folderName,'doctrees'), 's');

%% execute sphinx  and  pdflatex build
sphinx_make_via_matlab({'html';'latex'});
pdflatex_via_matlab();
pdflatex_via_matlab();
pdflatex_via_matlab();
%% copy pdf into new folder

copyfile( fullfile ( '..',s.folderName,'latex',[s.projectFolder,'.pdf']),...
          pwd());
%% copy install bundle and pdf into new folder



s.new_folderName          = [s.projectFolder,'-egg-',datestr(now(),'yyyymmddHHMMSS')];
s.new_fullProjectPath     = fullfile (s.folderPath ,s.new_folderName );
    
mkdir (s.new_fullProjectPath );

copyfile( fullfile ( '..',s.folderName,'latex',[s.projectFolder,'.pdf']),...
                s.new_fullProjectPath);
     
copyfile( fullfile ( 'functions','templates',[s.projectFolder,'_static_bundle.zip']),...
                s.new_fullProjectPath);
            
sprintf('%s','The egg was sucessfully [did not check] layed');
toc