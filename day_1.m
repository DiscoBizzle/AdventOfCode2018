clear; clc; close all;

frequencies = load('day_1_input.txt');

net_frequency_change = sum(frequencies)

previous_frequencies = [0];
curr_freq = 0;

found_repeat = false();
loop_number = 1;

while ~found_repeat
    curr_frequencies = previous_frequencies(end) + cumsum(frequencies);
    indices = ismember(curr_frequencies, previous_frequencies);
    
    if any(indices)
        disp(['Found frequency ' num2str(curr_frequencies(indices)') ' at positions ' num2str(find(indices)')])
        found_repeat = true();
    end;
    previous_frequencies = [previous_frequencies; curr_frequencies];
    loop_number = loop_number+1;
end;