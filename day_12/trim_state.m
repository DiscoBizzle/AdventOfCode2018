function [Trimmed, StartIndex] = trim_state(State)

L = length(State);
for i = 1:L
    if (State(i) ~= '.')
        StartIndex = i;
        break;
    end;
end;

for i = L:(-1):1
    if (State(i) ~= '.')
        EndIndex = i;
        break;
    end;
end;

Trimmed = State(StartIndex:EndIndex);

end