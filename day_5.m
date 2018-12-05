clear; clc; close all;

Input = importdata('day_5_input.txt');
Input = Input{1};


%% Part 1
length_after_reaction(Input)

%% Part 2
FinalLength = zeros(26,1);
for i = int16('A'):int16('Z')
    disp(['Iteration ' char(i)]);
    TruncatedInput = Input((Input ~= i) & (Input ~= (i+32)))
    FinalLength(i - int16('A') + 1) = length_after_reaction(TruncatedInput);
end;

min(FinalLength)
