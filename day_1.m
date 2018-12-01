clear; clc; close all;
%% Naive solution - requires looping many times - takes about 0.25s on my machine
% frequencies = load('day_1_input.txt');
% 
% net_frequency_change = sum(frequencies)
% 
% previous_frequencies = [0];
% curr_freq = 0;
% 
% found_repeat = false();
% loop_number = 1;
% 
% while ~found_repeat
%     curr_frequencies = previous_frequencies(end) + cumsum(frequencies);
%     indices = ismember(curr_frequencies, previous_frequencies);
%     
%     if any(indices)
%         disp(['Found frequency ' num2str(curr_frequencies(indices)') ' at positions ' num2str(find(indices)') char(10) ' on loop number ' num2str(loop_number)]);
%         found_repeat = true();
%     end;
%     previous_frequencies = [previous_frequencies; curr_frequencies];
%     loop_number = loop_number+1;
% end;

%% Cleverer solution based on modular arithmetic - takes about 0.02s on my machine

deltas = load('day_1_input.txt');

F = cumsum(deltas); % Convert the list of frequency deltas into the list of actual frequencies
L = length(deltas); 

F(L) % Answer to the first part

% On the Nth iteration through the list the frequency is F(j) + N*F(L)
% We seek solutions of the form F(i) == F(j) + N*F(L)
% This is the case when mod(F(i) - F(j), F(L)) == 0

G = F';
Diff = (repmat(F, 1, L) - repmat(G, L, 1)); % Create a matrix which contains the differences between F(i) - F(j)

Repeats = ((mod(Diff, F(L)) == 0) & (Diff > 0) ); % Note, this second condition will break if we have a repeated value on the first iteration.

% Now that we have found frequencies which are repeated, do an integer
% divide to get the Ns these repeatitions happened for

N = fix(Diff./F(L)); % Do an integer divide 

minN = min(N(Repeats));

[i, j] = find(N.*Repeats == minN);

% The first one to be repeated will be at the smallest value of j for the given N i.e.
FirstRepeated = F(min(j)) + minN*F(L) % Answer to the second part