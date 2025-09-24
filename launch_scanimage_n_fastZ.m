function launch_SI_with_fastZ
    
    % Start ScanImage
    scanimage;
    
    % Get SI handle from base workspace
    hSI = evalin('base','hSI');
    
    % Launch GUI
    fastZ_gui;
    
    assignin('base','hSI',hSI);
end