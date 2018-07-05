

% app.icbm_Panel = uipanel(ext_hand);
function mycode=uif_createComponents_switcher(mycode, appname)

% My purpose: add a parameter to the creator function in the class
% definition
%
%  input: MATLAB-code of classdef 
%  input: appname
%
% output:  class replaced with a additionol parameters input in creator
%

if isa(appname,'cell')
    appname=appname{1};
end


%----- $_$ core 
%----- $_$ replace function definition with one with parameter
% Construct app
% function app = icbm------------------------->app = icbm(external_handle)

            ui_index  =  find( ~cellfun('isempty',(regexp(mycode,'function app =') )) );
            new_code=['            function app = ',appname,'(external_handle) % $_$ replaced '];
            
            % replace complete line
            z=1;
            mycode(ui_index(z)) ={new_code };    
            
%---- $_$  replace function call with new call with parameter

% fuction createComponents(app) -----------> function createComponents(app,external_handle)
% createComponents(app) -----------> createComponents(app,external_handle)

            ui_index  =  find( ~cellfun('isempty',(regexp(mycode,'createComponents[(]app[)]') )) );
            new_code=' createComponents(app,external_handle) % $_$ replaced ';
            
            % replace complete line
            for z=1:numel(ui_index)
                mycode(ui_index(z)) =...
                    {regexprep(mycode{ui_index(z)},'createComponents[(]app[)]',{new_code })  } ;   
            end
%---- $_$  
        
end