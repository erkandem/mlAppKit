
make()

close all force
s = struct();
 
s.currentDir      = pwd();
s.slashesPos      = regexp(s.currentDir, filesep());
s.projectFolder   = s.currentDir (s.slashesPos(end)+1:end);
s.folderPath      = s.currentDir (1:s.slashesPos(end)-1);
s.fullProjectPath = s.currentDir;

quickstart_template_creator()

mlappkit_static_bundle_creator()

%% prepare new batch of documentation files
s.folderName = [s.projectFolder, '-docs'];
try
    rmdir(fullfile('..', s.folderName, 'latex'   ), 's');
catch
end
try
%    rmdir(fullfile('..', s.folderName, 'html'    ), 's');   % GIT !!!!
catch
end
try
    rmdir(fullfile('..', s.folderName, 'doctrees'), 's');
catch
end

%% execute sphinx  and  pdflatex build
% pdflatex is called multiple times because elements
% like the table of contents and internal references are not created
% corectly after the first run
sphinx_make_via_matlab({'html'; 'latex'});
pdflatex_via_matlab();
pdflatex_via_matlab();
pdflatex_via_matlab();

%% copy pdf into new folder
copyfile(...
    fullfile('..', s.folderName, 'latex', [s.projectFolder, '.pdf']), ...
    pwd()...
);

%% copy installation bundle and pdf into a new folder
nowstr_ = datestr(now(), 'yyyymmdd_HHMMSS');
s.new_folderName      = [s.projectFolder, '-egg-', nowstr_];
s.new_fullProjectPath = fullfile(s.folderPath, s.new_folderName);
    
mkdir(s.new_fullProjectPath);

copyfile(fullfile('..', s.folderName, 'latex', [s.projectFolder, '.pdf']), ...
                s.new_fullProjectPath);
     
copyfile(fullfile('functions', 'templates', [s.projectFolder, '_static_bundle.zip']), ...
                s.new_fullProjectPath);
   
fprintf('The egg was sucessfully layed.\nHowever, the egg was not tested\n');
