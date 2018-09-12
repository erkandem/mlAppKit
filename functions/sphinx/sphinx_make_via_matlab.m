
function sphinx_make_via_matlab(opts)
% execute the spinx build commands from matlan
% input single line char cell carrying the commands to execute
%
% :param opts:
% :param type: ( mx1 Cell of Char Arry 1xn or  Char Array 1xn )
% 

if  isa( opts,'char') && (size ( opts,1 )== 1 ) 
    fn = {opts};
elseif  isa( opts,'cell') 
    fn = opts;
else 
    error ('check input expected cell or one line char ( as one argument)') 
end


[syscode, ~] = system('python --version');
if syscode ~= 0
    error(' `python --version` was returned with an errorcode, Python installed and on systempath ?')     
end


currentdir = pwd();
parts = strsplit(currentdir, filesep());
cd docs
%cd(fullfile ( [parts{end},'-docs'],latex))

for i = 1:numel (fn ) 
    [~, ~] = system(['make ', fn{i}],'-echo');
end

cd(currentdir);

end

