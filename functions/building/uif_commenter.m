function [tmpblock, uif_handle ]=uif_commenter(tmpblock)
% purpose:  plugin function to mlappp2classdefm
%           uncomment the uifigure property in the private porperty class
%           as a result the class defines a panel
%
%  :param: textblock with properties formated as a cell vector
%           each cell represents a line of code
%
%  :param: same cell array with the difference that the 
%           line calling a  uifigure element is uncommented
%
%  :returns: later the handle is needed to uncomment the creation of a uifigure
%            and in order to replace the the parent for the main
%            panel/tabpanel with the parent app
%
%       Yes Shrelock, instead of directly placing the 
%       elements into the uifigure it is preferabl to 
%       embed them into a panel or multi tab panel (integrate later)
%       :todo: integrate UI tab panel ? maybe?
  
	ui_index     = find( ~cellfun('isempty',(regexp(tmpblock,'\w*matlab.ui.Figure\w*') ) ));
	uif_handle   = split(strtrim(tmpblock{1}));
	uif_handle   = uif_handle(1); % boooooOOOOOOoooooombaaaaaaaa ;)

	tmpblock(ui_index)={['%', tmpblock{ui_index} ]};
        
        
end