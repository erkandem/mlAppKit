function mycode=uif_create_commenter(mycode, uif_handle)

% My purpose: plugin function to mlappp2classdefm
%             comment the uifigure property in the private porperty class
%             as a result the class defines a panel
%
%  input: MATLAB-code of classdef 
%  input: name of the handle to the uifigue
%
% output: same input cell array with the difference that the 
%           LINES in the creator function are commented
%

if isa(uif_handle,'cell')
    uif_handle=uif_handle{1};
end
% The searchexpressions are  '.uif_handle.'
%                       and  '.uif_handle '
% compare this to standard creation:
%
%  % Create uif_handle
%          app.uif_handle = figure; %1 single space cahracter thereafter
%          app.uif_handle.Position = [a b c d]; % property after handle
%          app.uif_handle.Name = 'Title'; % property after handle

%----- $_$ core $_$
            ui_index1  =  find( ~cellfun('isempty',(regexp(mycode,['[.]',uif_handle,'[.]']) ) ));
            ui_index2  =  find( ~cellfun('isempty',(regexp(mycode,['[.]',uif_handle,'\s']) ) ));
            ui_index3  =  find( ~cellfun('isempty',(regexp(mycode,['delete(app[.]',uif_handle]) )) );
            
            ui_index   =   unique([ui_index1  ;ui_index2 ; ui_index3 ]);

            % now loop through and 
            % just add a " % " at the front 
            for z = 1: numel(ui_index)
                mycode(ui_index(z)) ={['%', mycode{ui_index(z)}]};
            end
    
%---- $_$  
        
        
end