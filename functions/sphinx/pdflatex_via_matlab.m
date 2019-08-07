function pdflatex_via_matlab()
    %% a way of executing pdflatex within the MATLAB workflow
    % .. todo:: export settings into a external settings file
    %
    % .. seealso:: `Python Invoke <https://www.pyinvoke.org/ >`_
    %
    %
    % https://en.wikipedia.org/wiki/Comparison_of_documentation_generators
    
    [status, ~] = system('python --version');
    if status ~= 0
        error([' `python --version` returned an error,',... 
               ' \n Python installed and added to systempath?'])     
    end

    currentdir  = pwd();
    parts       = strsplit(currentdir, filesep());
    cd('..')
    latex_dir = fullfile([parts{end}, '-docs'], 'latex');
    if ~(exist(latex_dir, 'dir'))
        mkdir(latex_dir);
    end
    cd(latex_dir)
    [status, ~] = system(['pdflatex ', parts{end},'.tex'], '-echo');
        if status ~= 0 
            error([' pdflatex raised an error,',... 
               ' \nDo you have a verion of pdflatex installed on your system?'])     
        end
    cd(currentdir);

end
