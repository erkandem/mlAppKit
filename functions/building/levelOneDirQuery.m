function meta_Name_dir  = levelOneDirQuery(qPar)
%% utility to  get only subfolders (if any) from a dir query
% :param qPar:  a directory path
% :type qPar: char array
%
% :returns: foldernames in the queryed directory
% :rtype: cell-array
%
% Level one ( one subdirecotry below, as defined by qPar)

	if nargin == 0
		qPar = pwd();
	end
        
	meta          = dir(fullfile(qPar));
	meta_IsDir    = {meta.isdir};
	meta_Name     = {meta.name};
	meta_Name_dir = meta_Name(cell2mat(meta_IsDir )) ; 
	meta_Name_dir = meta_Name_dir(:);
	meta_Name_dir = meta_Name_dir(3:end);
        
end    