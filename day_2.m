clear; clc; close all;

Keys = importdata('day_2_input.txt');

NumTwos = 0;
NumThrees = 0;

for j = 1:length(Keys)
    CurrKeys = double(uint8(Keys{j}));
    [Occurences,b] = hist(CurrKeys, unique(CurrKeys));
    if (sum(Occurences == 2) > 0)
        NumTwos = NumTwos + 1;
    end;
    if (sum(Occurences == 3) > 0)
        NumThrees = NumThrees + 1;
    end;
end;

Checksum = NumTwos * NumThrees % Solution for the first part

KeyLength = length(Keys{1});

for j = 1:length(Keys)
    for k = (j+1):length(Keys)
        if (sum(Keys{j} == Keys{k}) == (KeyLength-1)) % Find the only two keys which differ by only one character
            disp(Keys{j}(Keys{j} == Keys{k})) % Solution for the second part
        end;
    end;
end;