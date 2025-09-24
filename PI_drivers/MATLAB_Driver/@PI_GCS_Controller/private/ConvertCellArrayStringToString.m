function outputString = ConvertCellArrayStringToString( inputString )
   
    if (iscell(inputString))
        outputString = '';
        for idx = 1 : length ( inputString )
            if(idx < length ( inputString ))
                outputString = [outputString sprintf('%s ', inputString {idx})];
            else
                outputString = [outputString sprintf('%s', inputString {idx})];
            end
                
        end
    else
         outputString = inputString;
    end
   



