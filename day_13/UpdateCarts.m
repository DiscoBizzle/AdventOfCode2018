function [Carts, HasCrashed, CrashPosition] = UpdateCarts(Track, Carts)
    % First sort the carts by position - the one with the smallest y,x
    % first 
    
    [~, Lx] = size(Track);
    for CartIndex = 1:length(Carts)
        CartPos(CartIndex) = Carts(CartIndex).Position(2)*Lx + Carts(CartIndex).Position(1);
    end
    [~, CartPriority] = sort(CartPos);
    Carts = Carts(CartPriority);
    

    HasCrashed = false();
    CrashPosition = [];
    for CartIndex = 1:length(Carts)
        if Carts(CartIndex).Active
            switch Carts(CartIndex).Dir
                case '>'
                    Carts(CartIndex).Position = Carts(CartIndex).Position + [1, 0];
                    x = Carts(CartIndex).Position(1);
                    y = Carts(CartIndex).Position(2);

                    if Track(y, x) == '\'
                        Carts(CartIndex).Dir = 'v';
                    elseif Track(y, x) == '/'
                        Carts(CartIndex).Dir = '^';
                    elseif Track(y, x) == '+'
                        Carts(CartIndex) = HandleIntersection(Carts(CartIndex));
                    end;
                case '<'
                    Carts(CartIndex).Position = Carts(CartIndex).Position - [1, 0];
                    x = Carts(CartIndex).Position(1);
                    y = Carts(CartIndex).Position(2);

                    if Track(y, x) == '\'
                        Carts(CartIndex).Dir = '^';
                    elseif Track(y, x) == '/'
                        Carts(CartIndex).Dir = 'v';
                    elseif Track(y, x) == '+'
                        Carts(CartIndex) = HandleIntersection(Carts(CartIndex));
                    end;
                case '^'
                    Carts(CartIndex).Position = Carts(CartIndex).Position - [0, 1];
                    x = Carts(CartIndex).Position(1);
                    y = Carts(CartIndex).Position(2);

                    if Track(y, x) == '\'
                        Carts(CartIndex).Dir = '<';
                    elseif Track(y, x) == '/'
                        Carts(CartIndex).Dir = '>';
                    elseif Track(y, x) == '+'
                        Carts(CartIndex) = HandleIntersection(Carts(CartIndex));
                    end;
                case 'v'
                    Carts(CartIndex).Position = Carts(CartIndex).Position + [0, 1];
                    x = Carts(CartIndex).Position(1);
                    y = Carts(CartIndex).Position(2);
                    
                    if Track(y, x) == '\'
                        Carts(CartIndex).Dir = '>';
                    elseif Track(y, x) == '/'
                        Carts(CartIndex).Dir = '<';
                    elseif Track(y, x) == '+'
                        Carts(CartIndex) = HandleIntersection(Carts(CartIndex));
                    end;
                otherwise
                    error(['Cart had a direction ' Carts(CartIndex).Dir]);
            end;
        end;
        for CartIndex2 = 1:length(Carts)
            [Carts, Crash, CrashPos] = CheckCollision(Carts, CartIndex, CartIndex2);
            if Crash
                HasCrashed = true();
                CrashPosition = CrashPos;
            end;
        end;
        
    end;
end

function [Carts, HasCrashed, CrashPosition] = CheckCollision(Carts, i1, i2)
    HasCrashed = false();
    CrashPosition = [];
    if i1 ~= i2 && all(Carts(i1).Position == Carts(i2).Position) && Carts(i1).Active && Carts(i2).Active
            HasCrashed = true();
            CrashPosition = Carts(i1).Position;
            Carts(i1).Active = false();
            Carts(i2).Active = false();

    end;
end

function Cart = HandleIntersection(Cart) 
    switch(Cart.Dir)
        case '>'
            switch(Cart.LastTurn)
                case 0 % turn left
                    Cart.Dir = '^';
                case 1 % go straight
                case 2 % go right
                    Cart.Dir = 'v';
            end;
            Cart.LastTurn = mod(Cart.LastTurn+1,3);
        case '<'
            switch(Cart.LastTurn)
                case 0 % turn left
                    Cart.Dir = 'v';
                case 1 % go straight
                case 2 % go right
                    Cart.Dir = '^';
            end;
            Cart.LastTurn = mod(Cart.LastTurn+1,3);
        case '^'
            switch(Cart.LastTurn)
                case 0 % turn left
                    Cart.Dir = '<';
                case 1 % go straight
                case 2 % go right
                    Cart.Dir = '>';
            end;
            Cart.LastTurn = mod(Cart.LastTurn+1,3);
        case 'v'
            switch(Cart.LastTurn)
                case 0 % turn left
                    Cart.Dir = '>';
                case 1 % go straight
                case 2 % go right
                    Cart.Dir = '<';
            end;
            Cart.LastTurn = mod(Cart.LastTurn+1,3);
        otherwise
            error(['Cart had a direction ' Carts(CartIndex).Dir]);
    end
end