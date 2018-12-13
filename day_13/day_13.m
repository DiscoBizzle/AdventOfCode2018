clear; clc; close all;

Track = textread('day_13_input.txt', '%s', 'whitespace', '', 'delimiter', '\n');
Track = cell2mat(Track);

[Ly, Lx] = size(Track);

% First extract all of the data about the carts. 
CartIndex = 1;
for j = 1:Ly
    for i = 1:Lx
        switch Track(j,i)
            case '>'
                Carts(CartIndex).Dir = Track(j,i);
                Carts(CartIndex).LastTurn = 0;
                Carts(CartIndex).Position = [i, j];
                Carts(CartIndex).Active = true();
                CartIndex = CartIndex + 1;
                Track(j,i) = '-';
            case '<'
                Carts(CartIndex).Dir = Track(j,i);
                Carts(CartIndex).LastTurn = 0;
                Carts(CartIndex).Position = [i, j];
                Carts(CartIndex).Active = true();
                CartIndex = CartIndex + 1;
                Track(j,i) = '-';
            case '^'
                Carts(CartIndex).Dir = Track(j,i);
                Carts(CartIndex).LastTurn = 0;
                Carts(CartIndex).Position = [i, j];
                Carts(CartIndex).Active = true();
                CartIndex = CartIndex + 1;
                Track(j,i) = '|';
            case 'v'
                Carts(CartIndex).Dir = Track(j,i);
                Carts(CartIndex).LastTurn = 0;
                Carts(CartIndex).Position = [i, j];
                Carts(CartIndex).Active = true();
                CartIndex = CartIndex + 1;
                Track(j,i) = '|';
            otherwise
                % Do nothing 
        end;
    end;
end
NumCarts = CartIndex-1;

State = Track;
for CartIndex = 1:NumCarts
    x = Carts(CartIndex).Position(1);
    y = Carts(CartIndex).Position(2);
    State(y,x) = Carts(CartIndex).Dir;
end;
State

HasCrashed = false();

while ~HasCrashed
    [Carts, HasCrashed, CrashPosition] = UpdateCarts(Track, Carts);
end

disp(['First crash happened at (' num2str(CrashPosition(1)-1) ',' num2str(CrashPosition(2)-1) ')']);

NumActiveCarts = length(Carts);
while NumActiveCarts > 1
    [Carts, HasCrashed, CrashPosition] = UpdateCarts(Track, Carts);
    
    LAC = NumActiveCarts;
    NumActiveCarts = 0;
    for i = 1:NumCarts
        if Carts(i).Active
            NumActiveCarts = NumActiveCarts+1;
        end
    end;
    if LAC ~= NumActiveCarts
        NumActiveCarts
    end;
end;

for i = 1:NumCarts
    if Carts(i).Active
        disp(['The last active cart is at position (' num2str(Carts(i).Position(1)-1) ',' num2str(Carts(i).Position(2)-1) ')']);
    end
end;