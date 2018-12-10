clear; clc; close all;

Inputs = importdata('day_10_input.txt');

Position = zeros(length(Inputs), 2);
Velocity = zeros(length(Inputs), 2);

for j = 1:length(Inputs)
    CurrInput  = strsplit(Inputs{j} ,{'\s', 'position=<', ',', '>', '\s', 'velocity=<', ',', '>'}, 'DelimiterType','RegularExpression');
    Position(j,:) = [str2double(CurrInput{2}), str2double(CurrInput{3})];
    Velocity(j,:) = [str2double(CurrInput{4}), str2double(CurrInput{5})];
end;

InitialPosition = Position;

N = length(Inputs);
COM = mean(Position,1);
figure; 

StartTime = 10800;
Position = Position + StartTime *Velocity;
for t = 1:100;
    Position = Position + Velocity;
    COM = mean(Position,1);
    YSpread(t) = sqrt(mean((Position(:,2) - COM(2)*ones(N,1)).^2));
end

figure; plot(YSpread);

MinTime = StartTime + find(min(YSpread) == YSpread)

Position = InitialPosition + MinTime * Velocity;
scatter(Position(:,1), Position(:,2))
ylim([120, 150])