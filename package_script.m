

tic
make()

close all force

quickstart_template_creator()

mlappkit_static_bundle_creator()
%%
folderName = 'mlAppKit-docs';

rmdir(fullfile('..',folderName,'latex'   ), 's');    
rmdir(fullfile('..',folderName,'html'    ), 's');    
rmdir(fullfile('..',folderName,'doctrees'), 's');

sphinx_make_via_matlab({'html';'latex'});
pdflatex_via_matlab();
pdflatex_via_matlab();
pdflatex_via_matlab();

copyfile( fullfile ( '..','mlAppKit-docs','latex','mlAppKit.pdf'),...
          pwd());
toc