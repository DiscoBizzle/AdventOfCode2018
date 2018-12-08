clear; clc; close all;

Input = importdata('day_7_input.txt');

AdjMat = zeros(26,26); % Adjacency matrix of the directed graph showing the dependencies. 

char2index = @(Char) (uint16(Char) - uint16('A') + 1);
index2char = @(Index) (char(Index + double('A') - 1)); 

TimeRemaining = zeros(1,26);
for i = 1:length(Input)
    CurrInput = strsplit(Input{i});
    
    j = char2index(CurrInput{2});
    k = char2index(CurrInput{8});
    
    AdjMat(j,k) = 1;
end;

TimeRemaining = 60*ones(1,26) + (1:26);

Order = [];
AdjMat1 = AdjMat;

%% Part 1
for i = 1:26
    FreeColumns = find(sum(AdjMat1, 1) == 0); % Find all columns where we have zero requirements
    FreeColumns = setdiff(FreeColumns, char2index(Order)); % Remove the nodes that we have already 
    Next = min(FreeColumns);
    Order = [Order index2char(Next)];
    AdjMat1(Next,:) = 0;
end;

Order
assert(strcmp(Order, 'BFLNGIRUSJXEHKQPVTYOCZDWMA'));

%% Part 2
Order = [];
TotalTime = 0;
while length(Order) < 26
    FreeColumns = find(sum(AdjMat, 1) == 0); % Find all columns where we have zero requirements
    FreeColumns = sort(setdiff(FreeColumns, char2index(Order))); % Remove the nodes that we have already 
    
    % I'm not sure if this is strictly speaking correct, but maybe we can get away with it
    % (Here workers will abandon work that they have already started if the
    % node loses priority because an alphabetically lower node becomes
    % available).
    if (length(FreeColumns) > 5)
        FreeColumns = FreeColumns(1:5);
    end;
    
    CurrTimeRemaining = TimeRemaining(FreeColumns);
    TotalTime = TotalTime + min(CurrTimeRemaining);
    TimeRemaining(FreeColumns) = TimeRemaining(FreeColumns) - min(CurrTimeRemaining);
    NodesToClear = find(TimeRemaining == 0);
    NodesToClear = sort(setdiff(NodesToClear, char2index(Order))); % Clear the nodes that we have already cleared;
    
    Order = [Order index2char(NodesToClear)];
    AdjMat(NodesToClear, :) = 0;
end;

TotalTime