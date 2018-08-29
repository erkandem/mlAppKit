function app_launch()
%% scans the root directory for the app name and launches it
% 
%

    a=dir('host/mfiles');
    a_IsDir = {a.isdir};
    a_Name  = {a.name};
    a_Name_dir  =   a_Name(~cell2mat(a_IsDir )) ;
    a_Name_dir  =   a_Name_dir(:);
    a_Name_dir  =   a_Name_dir{1};

    % strip off extension
    dotloc =  regexp(a_Name_dir,'[.]');
    fName  =  a_Name_dir(1:dotloc-1);
    
    %
    out=[datestr(now()),'  |  starting app'];
    disp( out )
    
    eval(fName);

end