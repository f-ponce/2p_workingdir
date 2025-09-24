function numberOfLines = CheckIfStringContainsSeparatorsAndReturnNumberOfLines( stringToCheck )
    result = regexp(stringToCheck,'\s\n','match');
    numberOfLines = length(result);
