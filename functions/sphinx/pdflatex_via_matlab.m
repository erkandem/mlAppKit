
function pdflatex_via_matlab()

[syscode, ~] = system('python --version');
if syscode ~= 0
    error(' `python --version` was returned with an errorcode, Python installed and on systempath ?')     
end



currentdir = pwd();
parts = strsplit(currentdir, filesep());
cd ..
cd(fullfile ( [parts{end},'-docs'],'latex'))
[~, ~] = system(['pdflatex ',parts{end},'.tex'],'-echo');

cd(currentdir);

end

