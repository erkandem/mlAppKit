
function d=conversion_launcher()
% start the conversion of the app files to m class definitions

mlapp2classdef_edit('launch/icbm.mlapp','ReplaceAppUI',true);
mlapp2classdef_edit('launch/stinger.mlapp','ReplaceAppUI',true);
%mlapp2classdef_edit('shitstorm/shitstorm.mlapp','ReplaceAppUI',true);

 main_extractor();
    
d=app_template;

end