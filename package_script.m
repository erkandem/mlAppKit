

tic
make()

close all force

quickstart_template_creator()

mlappkit_static_bundle_creator()
%% prepare new batch of documentation files
folderName = 'mlAppKit-docs';

rmdir(fullfile('..',folderName,'latex'   ), 's');    
rmdir(fullfile('..',folderName,'html'    ), 's');    
rmdir(fullfile('..',folderName,'doctrees'), 's');

%% execute sphinx  and  pdflatex build
sphinx_make_via_matlab({'html';'latex'});
pdflatex_via_matlab();
pdflatex_via_matlab();
pdflatex_via_matlab();
%% copy pdf into new folder

copyfile( fullfile ( '..','mlAppKit-docs','latex','mlAppKit.pdf'),...
          pwd());
%% copy install bundle and pdf into new folder

currentDir      = pwd();
slashesPos      = regexp(currentDir,filesep() );
projectFolder   = currentDir (slashesPos(end)+1:end);
folderPath      = currentDir (1:slashesPos(end)-1);
fullProjectPath = currentDir;

new_folderName          = [projectFolder,'-egg-',datestr(now(),'yyyymmddHHMMSS')];
new_fullProjectPath     = fullfile (folderPath ,new_folderName );
    
mkdir (new_fullProjectPath );

copyfile( fullfile ( '..','mlAppKit-docs','latex','mlAppKit.pdf'),...
                new_fullProjectPath);
     
copyfile( fullfile ( 'functions','templates','mlappkit_static_bundle.zip'),...
                new_fullProjectPath);
toc