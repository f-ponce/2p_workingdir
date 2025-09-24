function launch_scanimage_n_fastZ
    
    % Start ScanImage
    scanimage;
    
    % Get SI handle from base workspace
    hSI = evalin('base','hSI');
    
    % Launch GUI
    fastZ_gui;
    
    assignin('base','hSI',hSI);
end