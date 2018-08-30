function my_m_code=uif_create_commenter(my_m_code, uif_handle)
% :purpose: plugin function to mlappp2classdefm
%             comment the uifigure property in the private porperty class
%             as a result the class defines a panel
%
% :param: MATLAB-code of classdef 
% :param: name of the handle to the uifigue
%
% :returns: same input cell array with the difference that the 
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
    ui_index1  =  find( ~cellfun('isempty',(regexp(my_m_code,['[.]',uif_handle,'[.]']) ) ));
    ui_index2  =  find( ~cellfun('isempty',(regexp(my_m_code,['[.]',uif_handle,'\s']) ) ));
    ui_index3  =  find( ~cellfun('isempty',(regexp(my_m_code,['delete(app[.]',uif_handle]) )) );
    ui_index4  =  find( ~cellfun('isempty',(regexp(my_m_code,'(registerApp.*)'           ) )) );

    ui_index   =   unique([ui_index1  ;ui_index2; ui_index3; ui_index4]);

    % now loop through and 
    % just add a " % " at the front 
    for z = 1: numel(ui_index)
        my_m_code(ui_index(z)) ={['%', my_m_code{ui_index(z)}]};
    end
        
end