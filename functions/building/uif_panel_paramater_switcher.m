function mycode=uif_panel_paramater_switcher(mycode, uif_handle)

% purpose:  replace the standard parameter fed into element of the target
%           class by the name of the uifigure of the mainwindow
%
%  input 1 : MATLAB-code of classdef 
%  input 2 : name of the handle to the uifigue
%
%  output  :  class with replaced handle to parent

if isa(uif_handle,'cell')
    uif_handle=uif_handle{1};
end

%----- $_$ core $_$
            ui_index3  =  find( ~cellfun('isempty',(regexp(mycode,['uipanel(app[.]',uif_handle]) )) );
            
            ui_index   =   unique([ui_index3 ]);
            
            for z = 1: numel(ui_index)
                mycode(ui_index(z)) ={ regexprep( mycode{ui_index(z)},['app[.]',uif_handle],'external_handle') };
            end
    
%---- $_$  
        
        
end