function [Scores, ListLength] = simulate_marble_game(NumPlayers, LastMarble)

    Circle = [0 2 1];
    PlayerIndex = 3;
    CurrMarble = 2;
    InsertionIndex = 4;

    Scores = zeros(1, NumPlayers);

    while CurrMarble < LastMarble
        if (mod(CurrMarble, 1000) == 0)
            disp(CurrMarble);
        end;
        L = length(Circle);
        CurrMarble = CurrMarble+1; % Get the next marble
        assert(L == CurrMarble - 2*fix((CurrMarble-1)/23));  
        
        if mod(CurrMarble, 23) ~= 0
            if InsertionIndex > (L + 1)
                InsertionIndex = mod(InsertionIndex-1, L) + 1;
            end;
            Circle = [Circle(1:(InsertionIndex-1)) CurrMarble Circle((InsertionIndex):L)];
            InsertionIndex = InsertionIndex + 2;
        else 
            RemovalIndex = InsertionIndex - 9;
            if (RemovalIndex < 1)
                RemovalIndex = mod(RemovalIndex-1,L) + 1;
            end;
            Scores(PlayerIndex) = Scores(PlayerIndex) + Circle(RemovalIndex) + CurrMarble;
            Circle = [Circle(1:(RemovalIndex-1)) Circle((RemovalIndex + 1):L)];
            InsertionIndex = RemovalIndex+2;
        end;
        
        PlayerIndex = mod(PlayerIndex, NumPlayers) + 1; % Get the next player index
        assert(PlayerIndex >= 1 && PlayerIndex <= NumPlayers);
        CurrLength = length(Circle);
        
        assert(CurrLength == 1 + CurrMarble - 2*fix(CurrMarble/23)); 
    end;
    
    ListLength = length(Circle);
end