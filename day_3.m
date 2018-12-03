clear; clc; close all;

Inputs = importdata('day_3_input.txt');

Grid = zeros(1001, 1001);
% Grid = spalloc(1001, 1001, 4000);

for j = 1:length(Inputs)
    % Inputs are e.g. #1 @ 817,273: 26x26
    CurrInput  = strsplit(Inputs{j} ,{'\s', '#', '@', ',', ':', 'x'}, 'DelimiterType','RegularExpression');
    CurrID = str2double(CurrInput{2});
    X = str2double(CurrInput{3})+1;
    Y = str2double(CurrInput{4})+1;
    W = str2double(CurrInput{5})-1;
    H = str2double(CurrInput{6})-1;
    
    Grid(X:(X+W), Y:(Y+H)) = Grid(X:(X+W), Y:(Y+H)) + 1;
end;

OverlappingCells = sum(sum(Grid > 1)) % Solution to the first part

for j = 1:length(Inputs)
    % Inputs are e.g. #1 @ 817,273: 26x26
    CurrInput  = strsplit(Inputs{j} ,{'\s', '#', '@', ',', ':', 'x'}, 'DelimiterType','RegularExpression');
    CurrID = str2double(CurrInput{2});
    X = str2double(CurrInput{3})+1;
    Y = str2double(CurrInput{4})+1;
    W = str2double(CurrInput{5})-1;
    H = str2double(CurrInput{6})-1;
    if all(all( Grid(X:(X+W), Y:(Y+H)) == 1))
        disp(['Non overlapping square is ' num2str(CurrID)]);
    end;
end;
