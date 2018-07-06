function conversion_launcher()
mlapp2classdef_edit(fullfile('launch','icbm.mlapp'),'ReplaceAppUI',true);
mlapp2classdef_edit(fullfile('launch','scud.mlapp'),'ReplaceAppUI',true);
mlapp2classdef_edit(fullfile('launch','stinger.mlapp'),'ReplaceAppUI',true);
mlapp2classdef_edit(fullfile('popups','popup_settings.mlapp'),'ReplaceAppUI',false);
main_extractor();
end
