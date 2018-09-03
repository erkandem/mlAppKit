function conversion_func_generator()
    %% creates the  f(x) to extract the .m-files out of the .mlapp file
    opt= project_parts();

    %% generate the f(x) from the configuration struct
    code_cell = mat_codegen(opt);

    %% write result into an .m-file
    % write_conversion_launcher(code_cell);
   
	target_path = fullfile('functions','auto_generated');
	file_name   = 'conversion_launcher.m';
	utf8_write_to_file(target_path, file_name, code_cell )

end

function code_cell=mat_codegen(opt)
%% generate conversion_launcher 

    func_dec={'function conversion_launcher()'};
    func_end={'end'};
    
    one_sp=' ';
    four_sp= '    ';

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
                
                c1(k,1) = {[four_sp,fHead_views,rb_o,'fullfile',rb_o,char(39),folder_names{i},char(39),',',char(39),(file_names{j}),'.mlapp',char(39),rb_c,',',ffoot_views ]};
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
                
                c2(k,1) = {[four_sp,fHead_popups,rb_o,'fullfile',rb_o,char(39),folder_names{i},char(39),',',char(39),(file_names{j}),'.mlapp',char(39),rb_c,',',ffoot_popups ]};
                k=k+1;        
        end
    end
clear k  i j
%% ----------------host------------------------
    folder_names ={'host'};
    k = 1;
    for i = 1: numel(folder_names)
        
        file_names = fieldnames(opt.(folder_names{i})) ;
        for j =1:numel(file_names)
            
            c3(k,1) ={[four_sp,fHead_popups,rb_o,'fullfile',rb_o,char(39),folder_names{i},char(39),',',char(39),(file_names{j}),'.mlapp',char(39),rb_c,',',ffoot_host ]};
            k = k+1;        
        end
    end
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
    '    %% generates the `classdef` .m-files in the subdirectory' 
    '    % of each .mlapp-file called `mfiles` ';
    '    % ';
    '    % :input: no input '; 
    '    % :returns: void';
    '    % ';
    '    % :warning: ANY CHANGE IN THIS FUNCTION AUTOMATICALLY CREATED FUNCTION WILL BE LOST';
    '    %           a) RATHER APPEND YOUR CODE TO the MOTHER FUNCTIONS :func:`conversion_func_generator` ';
    '    %           b) OR WRITE YOUR OWN FUNCTIONS AND APPEND THEM TO THE FLOW';
    '    % ';
    '    % :note: see also: :ref:`conversion_func_generator() <conversion_func_generator>` ';
    '    % ';
    '     ';
    };

    % split codel_cell
    fDef      = code_cell(1,:);
    fBody     = code_cell(2:end,:);
    code_cell =[fDef;header;fBody];
    
end