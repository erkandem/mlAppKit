
function d=conversion_launcher()
%% start the conversion of the app files to m class definitions
% void function
%

%% ---[ 1 ] Strip m-classdef from .mlapp  and erase/comment 
% out referneces to creating a UI figure class
% These files a re primarely 1 Level below the main Application
% credit to: http://www.mathworks.com/matlabcentral/fileexchange/56237-mlapp2classdef
% or https://github.com/StackOverflowMATLABchat/mlapp2classdef
% 
% $_$ modified for new pupose
mlapp2classdef_edit('launch/icbm.mlapp','ReplaceAppUI',true);
mlapp2classdef_edit('launch/stinger.mlapp','ReplaceAppUI',true);

%% ---[ 2 ] Strip m-classdef from .mlapp  with UI Figure
% 
% These files are autonomous since the wille be left with their UI Figure
% reference
% credit to: http://www.mathworks.com/matlabcentral/fileexchange/56237-mlapp2classdef
% or https://github.com/StackOverflowMATLABchat/mlapp2classdef

mlapp2classdef('pop-ups/shitstorm.mlapp','ReplaceAppUI',false);


%% ---[ 3 ] Lightweight extraction of core code
% This is Ground Zero
% Views/Windgets/pop-ups/windows/Panels  or however one might call obejects
% which are pluged in into the core have to registered here
%
%---------- TODO: automate the registration
%
% automate creation of new child structure
% 1. make menu entry
% 2. create folder structure( menuentry + mfiles)
% 3. copy child template inside
% 4. rename the child 
% 
% (5.0 create a resieving property)
% 5. plugin child into some parent-property
% 6. add menu selected callback
% 7. add visibility regulation function into the callback
% -------------------------------------
% $_$
    main_extractor();
% $_$

% invoke ze application

     d=app_template;

end