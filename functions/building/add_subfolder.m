function o = add_subfolder(p)
% What does it do ?
% :param p:    opt - struct carrying configuration for processor/core
% :param type: struct
% :returns:  opt - added substructs and fields (boolean)
% :rtype: struct
    gustav=1+1;  %debgging hook

   if isa(p,'char')
      o.(p)=   struct();

   elseif isa(p,'cell')
      if numel(p)==1
         p     =   p{1};
         o.(p) =   struct();
      else
           error('Input is type cell, but not one single cell');
      end
   else 
      error('Input is neither char nor cell'); 
   end
%----------actual function
   qPar           = p;
   meta_Name_dir  = levelOneDirQuery(qPar);

   for i = 1 : numel(meta_Name_dir )
      o.(p).(meta_Name_dir{i}) = true;
   end

%-----return o - struct
end