function [Length] = length_after_reaction(Input)
    Reactions = true();

    while Reactions    
        for i = 1:length(Input)-1
            Reactions = false();
            if abs(int16(Input(i)) - int16(Input(i+1))) == 32
                Input = [Input(1:(i-1)) Input((i+2):end)];
                Reactions = true(); 
                break;
            end;
        end;
    end;
    
    Length = length(Input);
end