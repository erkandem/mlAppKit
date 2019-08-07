function plugger(opt)
    %% creates the `properties`, visbility settings, in
    %
    % :param opt: input struct reflecting the views of the project
    % :type struct:
    %
    %
    %
    fn = fieldnames(opt);
    for i = 1 : numel(fn)
        cfn = fieldnames(opt.(fn{i}));
        for j = 1: numel(cfn)
           % {'Properties'}
        end
    end

end
