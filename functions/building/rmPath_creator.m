function rmPath_creator(project_dir) 
 %% create a function to remove app realted folders from the **current** MATLAB path
 % .. seealso:: :ref:`addPath_creator`_
 %   
    if nargin == 1
    
    elseif nargin == 0
        project_dir = pwd();
    end

    %% [1] 
    pFolder_dirNames = levelOneDirQuery();
    % read in .mignore file and disscard unneded files
    delList           = mignore_reader();
    [del_index, ~]    = ismember(pFolder_dirNames , delList);
    pFolder_dirNames_screened = pFolder_dirNames(~del_index) ;

    % options struct to hold the configureation  
    opt     =   struct();
    for i =1 :numel(pFolder_dirNames_screened)
        % wtf does add_subfolder do ???
        qPar       = pFolder_dirNames_screened{i};
        m          = add_subfolder(qPar);
        m          = m.(qPar);
        opt.(qPar) = m;
    end
    %% [2] 
    code_cell = rmPath_creator_core(opt);

    %% [3] 
    %
    % :todo: change addpath to addpath(genpath('file')) ?
    %
    target_path = fullfile(project_dir,v'functions',v'auto_generated');
    file_name = ('builder_rmPath.m');
    
    utf8_write_to_file(target_path, file_name, code_cell )
%     addPath_creator_write(code_cell)
% 
%     out= [datestr(now()),'  |  builder_addpath() created'];
%     disp(out)

end



function code_cell = rmPath_creator_core(opt)
    %% creates the addPath function from the previously obtained configuration
    % :param opt: configuration
    % :type opt: struct
    % 

    % define some strings 
	func_dec={'function builder_rmPath()'};
    func_end={'end'};

    rb_o  = '(';
    rb_c  = ')';
    comma = ',';
    sm = ';';
    gp = 'genpath';
    ap = 'rmpath';
    ff = 'fullfile';
    st = 'static';
    
    four_spaces='    '; % equal one tab

    %% create the code for the functions folders

    cPar_array=fieldnames(opt);
    k=1; % line counter

    for i = 1:numel(cPar_array)

        cPar = cPar_array{i} ;
        cf   = fieldnames(opt.(cPar));
    % sure,... preallocate and stuff
        for jj= 1: numel(cf)
   
            code_cell{k,1}= [four_spaces,...
                            ap,rb_o,...
                            ff,rb_o,...
                            char(39),cPar,char(39),comma,...
                            char(39),cf{jj},char(39),...
                            rb_c,...
                            rb_c,sm...
                            ];
            
            k=k+1; % +1 loop counter
        end
    end
    
    k=k+1;

    % insert comment header
    header = {...
        '    %% REMOVES `builder` and custom function folders(only first level)';
        '    % in a second run this function will also add the `.m-files` subdirectories';
        '    % of each .mlapp-file.';
        '    % ';
        '    % ';
        '    % .. warning:: ANY CHANGE IN THIS AUTOMATICALLY CREATED FUNCTION WILL BE LOST';
        '    %              a) RATHER APPEND YOUR CODE TO :ref:`rmPath_creator` ';
        '    %              b) OR WRITE YOUR OWN FUNCTIONS AND APPEND THEM TO THE FLOW';
        '    % ';
        '    % .. todo:: save your code in `mfiles` folder aswell ';
        '    %           currently, a level beneeth `mfiles` is not recognized ';
        '    % ';
        '    % .. todo:: define/declare/offer standerdized `hooks` like in WordPress ';
        '    % ';
        '    % ';
        '    % ';
        '    % ';
        '    % ';
        '     ';
        };
        
    static_folder={[four_spaces,ap,rb_o, gp,rb_o, ff, rb_o, char(39),st, char(39),rb_c,rb_c,rb_c,sm]};


    code_cell=[ func_dec;
                header;
                code_cell;
                static_folder;
                func_end];



end
