function utf8_write_to_file(target_path, file_name, my_m_code)
    %% Write code [n x 1] cell array to text-file in unicode encoding
    %
    % :param target_path: relative path to target 
    % :type target_path: Char Array
    % :param file_name: filename including fileextension
    % :type file_name: Char Array
    % :param my_m_code: code to be written to file
    % :type file_name: Cell Array
    %
    
    % [1] check for an existing path
    if exist(target_path, 'dir') ~= 7
        mkdir(target_path);
    end
    
    % [2] get file handle
    fid = fopen(fullfile(target_path, file_name), 'w');
    
    if fid < 3
        error([target_path,file_name, ' could not be created '])
    end
    
    for i = 1 : numel(my_m_code)
        encoded_str = unicode2native(my_m_code{i}, 'UTF-8'); 
        fwrite(fid, [encoded_str, 10], 'uint8');
    end

    fclose(fid);
    out = [datestr(now()), '  |  ', fullfile(target_path, file_name), ' created'];
    disp(out)
end
