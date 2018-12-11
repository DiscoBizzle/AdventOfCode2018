clear; clc; close all;

SerialNumber = 5177;
%SerialNumber = 18;

hundreds_digit = @(num)(fix((num - fix(num/1000)*1000)/100));

xcoord = repmat([1:300], 300, 1);
ycoord = repmat([1:300]', 1, 300);

RackID = xcoord + 10;
PowerLevel = RackID .* ycoord;

PowerLevel = PowerLevel + SerialNumber;
PowerLevel = PowerLevel.*RackID;
PowerLevel = hundreds_digit(PowerLevel) - 5;

%for SquareSize = 2:300 % For part 1, restrict this loop to be 3:3
for SquareSize = 2:300 % For part 1, restrict this loop to be 3:3
    SquareSize
    if mod(SquareSize,2) == 1
        w = (SquareSize-1)/2;
        PowerLevelSum = zeros(300,300);
        for i = (1+w):(300-w)
            for j = (1+w):(300-w)
                PowerLevelSum(i,j) = sum(sum(PowerLevel((i-w):(i+w), (j-w):(j+w))));
            end;
        end;
        
    else
        w = SquareSize/2;
        
        PowerLevelSum = zeros(300,300);
        for i = (1+w):(300-w)
            for j = (1+w):(300-w)
                PowerLevelSum(i,j) = sum(sum(PowerLevel((i-w):(i+w-1), (j-w):(j+w-1))));
            end;
        end;
        

    end;

    LargestPower(SquareSize) = max(max(PowerLevelSum))
    [y, x] = find(max(max(PowerLevelSum)) == PowerLevelSum); % Get the central coordinate of the square
    
    % The top left coordinate of the square (in the case of a tie just take
    % the first coord)
    x = x(1)-w;
    y = y(1)-w;
    
    LargestCoord(SquareSize,1:2) = [x, y];
    if (LargestPower(SquareSize) == 0)
        break;
    end;
end;

i = find(max(LargestPower) == LargestPower);
disp(['Solution = ' num2str(LargestCoord(i,1)) ',' num2str(LargestCoord(i,2)) ',' num2str(i)]);

