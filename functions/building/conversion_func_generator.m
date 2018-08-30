function conversion_func_generator()
%% creates the  f(x) to extract the .m-files out of the .mlapp file


%% filter out any level 1  directory 
    a_Name_dir            = levelOneDirQuery();
    ignore_list           = [mignore_reader();{'functions'}];
    [del_index, line_num] = ismember(ignore_list,a_Name_dir);
    a_Name_dir_filted     = a_Name_dir;

    a_Name_dir_filted(line_num(del_index))=[];

%% the host folder contains

% doesn't do  anything - I know

% remove "main" from "to parse" list
    [a,b] = ismember('host',a_Name_dir_filted);
    a_Name_dir_filted(b(a)) = [];
    clear a b 
%% scan the the pop-ups folder

    opt.popups=struct();
    
    opt.popups.popups= struct();
    
    meta = dir ( fullfile('popups','*mlapp'));
    lfn = {meta.name};
    
    for j=1:numel(lfn)
        % strip of file extension
        dotloc =  regexp(lfn{j},'[.]');
        fName  =  lfn{j}(1:dotloc-1);
        opt.popups.popups.(fName)=true;
    end
    
% remove "pop-ups" from "to parse" list
    [a,b] = ismember('popups',a_Name_dir_filted);
    a_Name_dir_filted(b(a)) = [];

clear a b 

%% any other folder lavel 1 plugin 
%
% :todo: figure out a way to deal with child menus in the menu
%
    opt.views=struct();
    for i = 1:numel( a_Name_dir_filted)
    
        opt.views.(a_Name_dir_filted{i}) = struct();
    
        meta = dir ( fullfile(a_Name_dir_filted{i},'*mlapp'));
        lfn = {meta.name};
    
        for j=1:numel(lfn)
            % strip of file extension
            dotloc =  regexp(lfn{j},'[.]');
            fName  =  lfn{j}(1:dotloc-1);
            opt.views.(a_Name_dir_filted{i}).(fName)=true;
        end
    end

%% generate the f(x) from the configuration struct
    code_cell = mat_codegen(opt);

%% write result into an .m-file
    write_conversion_launcher(code_cell);

end

function code_cell=mat_codegen(opt)
%% generate conversion_launcher 

    func_dec={'function conversion_launcher()'};
    func_end={'end'};
    
    one_sp={' '};

    fHead_views  ='mlapp_to_m';
    fHead_popups ='mlapp_to_m';
    fHead_host   ='mlapp_to_m';

    rb_o  ='(';
    rb_c  =')';

    ffoot_views = [char(39),'plugin',char(39),');'] ;
    ffoot_popups =[char(39),'popup', char(39),');'] ;
    ffoot_host =  [char(39),'host',  char(39),');'] ;


%% ----------------views------------------------
    folder_names = fieldnames(opt.views);
    k=1;
    for i = 1: numel(folder_names)
        file_names = fieldnames(opt.views.(folder_names{i})) ;

        for j =1:numel(file_names)
                
                c1(k,1) = {[fHead_views,rb_o,'fullfile',rb_o,char(39),folder_names{i},char(39),',',char(39),(file_names{j}),'.mlapp',char(39),rb_c,',',ffoot_views ]};
                k=k+1;        
        end
    end
    clear k  i j 

%% ----------------popups------------------------

    folder_names = fieldnames(opt.popups);
    k=1;
    for i = 1: numel(folder_names)
        file_names = fieldnames(opt.popups.(folder_names{i})) ;

        for j =1:numel(file_names)
                
                c2(k,1) = {[fHead_popups,rb_o,'fullfile',rb_o,char(39),folder_names{i},char(39),',',char(39),(file_names{j}),'.mlapp',char(39),rb_c,',',ffoot_popups ]};
                k=k+1;        
        end
    end
clear k  i j
%% ----------------host------------------------
    k=1;
    c3(k,1) = {[fHead_popups,rb_o,'fullfile',rb_o,char(39),'host',char(39),',',char(39),'host_app','.mlapp',char(39),rb_c,',',ffoot_host ]};
    k=k+1;        
    clear k  i j

%% -------------collect number of lines----------------------
    num_c1   = size(c1,1) ;
    num_c2   = size(c2,1) ;
    num_main = size(c3,1) ;

    total_num_lines= num_c1   +num_c2 +   num_main +2; % func_dec func_end 
%% ------------- put the pieces together ----------------------

    k=1;
    code_cell=cell(total_num_lines,1);
    for n= 1:3 % 3 types of codes; plugins, popups, and the host
        %--------------------
        if n==1
            code_cell(k)=func_dec;
            k=k+1;
            for jj=1:numel(c1)
                code_cell(k,1)= c1(jj);
                k=k+1;
            end
        %--------------------    
        elseif n==2
           for jj=1:numel(c2)
                 code_cell(k,1)= c2(jj);
                 k=k+1;
            end
        %--------------------
        elseif n==3
            code_cell(k,1)= c3;
            k=k+1;
        
            code_cell(k)=func_end;
            k=k+1;
        end
        %--------------------        
    end
    
%% add a comment header to the created f(x)
% contains sphinx rst formatting
    header = {...
    '%% generates the `classdef` .m-files in the subdirectory' 
    '% of each .mlapp-file called `mfiles` ';
    '% ';
    '% :input: no input '; 
    '% :returns: void';
    '% ';
    '% :warning: ANY CHANGE IN THIS FUNCTION AUTOMATICALLY CREATED FUNCTION WILL BE LOST';
    '%           a) RATHER APPEND YOUR CODE TO the MOTHER FUNCTIONS :func:`conversion_func_generator` ';
    '%           b) OR WRITE YOUR OWN FUNCTIONS AND APPEND THEM TO THE FLOW';
    '% ';
    '% :note: see also: :ref:`conversion_func_generator() <conversion_func_generator>` ';
    '% ';
    ' ';
    };

    % split codel_cell
    fDef      = code_cell(1,:);
    fBody     = code_cell(2:end,:);
    code_cell =[fDef;header;fBody];
    
end



function write_conversion_launcher(code_cell)
%% writes the composed function to an .m-file

    ext = exist(fullfile('functions','auto_generated'),'dir');
    if ext~=7
        mkdir(fullfile('functions','auto_generated'));
    end

    fid=fopen(fullfile('functions','auto_generated','conversion_launcher.m'),'w');
    if fid~=3
         error('conversion_launcher.m could not be created (the file itself not the code)')
    end

    % Write a cell array of strings to a *.m-file
    % Assumes each cell is a separate line
    for ii = 1:size(code_cell,1)
    
        encoded_str = unicode2native(code_cell{ii}, 'UTF-8');
        fwrite(fid, [encoded_str, 10], 'uint8');
    
    end

    fclose(fid);

end