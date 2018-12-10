clear; clc; close all;


%PlayerVec = [9 10 13 17 21 30];
PlayerVec = [459];
%LastMarbleVec = [25 1618, 7999, 1104, 6111, 5807];
LastMarbleVec = [71790];

for TestIndex = 1:length(PlayerVec)
    NumPlayers = PlayerVec(TestIndex);
    LastMarble = LastMarbleVec(TestIndex);
    
    [Scores, ListLength] = simulate_marble_game(NumPlayers, LastMarble);

    max(Scores)
end;


