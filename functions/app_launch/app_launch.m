function app_launch()
% scans the main directory for the app name and launches it

    a=dir('main/mfiles');
    a_IsDir = {a.isdir};
    a_Name  = {a.name};
    a_Name_dir=a_Name(~cell2mat(a_IsDir )) ; 
    a_Name_dir=a_Name_dir(:);
    
    eval(a_Name_dir);

end