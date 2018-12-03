clear; clc; close all;

Inputs = importdata('day_3_input.txt');

Grid = zeros(1001, 1001);

for j = 1:length(Inputs)
    % Inputs are e.g. #1 @ 817,273: 26x26
    CurrInput  = strsplit(Inputs{j} ,{'\s', '#', '@', ',', ':', 'x'}, 'DelimiterType','RegularExpression');
    CurrID = str2num(CurrInput{2});
    X = str2num(CurrInput{3})+1;
    Y = str2num(CurrInput{4})+1;
    W = str2num(CurrInput{5})-1;
    H = str2num(CurrInput{6})-1;
    
    if ((X == 308) && (Y == 185))
        disp(CurrID) % Solution to the second part
    end;
    
    Grid(X:(X+W), Y:(Y+H)) = Grid(X:(X+W), Y:(Y+H)) + 1;
end;

OverlappingCells = sum(sum(Grid > 1)) % Solution to the first part

% Plot the grid in a form where it is easy to see where the non-overlapping rectangle is
% Visually, the non-overlapping grid square is at 308, 185
NewGrid = (Grid > 1)*10 + (Grid == 1);
contourf(NewGrid)

