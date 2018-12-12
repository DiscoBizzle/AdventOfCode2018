clear; clc; close all;

xstart = -10;
xend = 500;

Labels = xstart:xend;

State = repmat('.',1,length(Labels));

%Input = '#..#.#..##......###...###'
Input = '####..##.##..##..#..###..#....#.######..###########.#...#.##..####.###.#.###.###..#.####..#.#..##..#'

State((1-xstart):(length(Input)-xstart)) = Input;

InitialState = State;

% Rules =    ['...## => #';
%             '..#.. => #';
%             '.#... => #';
%             '.#.#. => #';
%             '.#.## => #';
%             '.##.. => #';
%             '.#### => #';
%             '#.#.# => #';
%             '#.### => #';
%             '##.#. => #';
%             '##.## => #';
%             '###.. => #';
%             '###.# => #';
%             '####. => #'];
        
Rules =    ['.#.## => .';
'...## => #';
'..#.. => .';
'#.#.. => .';
'...#. => .';
'.#... => #';
'..... => .';
'#.... => .';
'#...# => #';
'###.# => .';
'..### => #';
'###.. => .';
'##.## => .';
'##.#. => #';
'..#.# => #';
'.###. => .';
'.#.#. => .';
'.##.. => #';
'.#### => .';
'##... => .';
'##### => .';
'..##. => .';
'#.##. => .';
'.#..# => #';
'##..# => .';
'#.#.# => #';
'#.### => .';
'....# => .';
'#..#. => #';
'#..## => .';
'####. => #';
'.##.# => #'];

RuleIn = Rules(:, 1:5);
RuleOut = Rules(:, 10);

[NumRules, ~] = size(RuleIn);

for Generation = 1:200
    NextState = State;
    for i = (1+2):(length(State)-2)
        Window = (i-2):(i+2);

        Matched = false();
        for j = 1:NumRules
            %s = State(Window)
            %r = RuleIn(j,:)
            if strcmp(State(Window), RuleIn(j,:))
                Matched = true();
                NextState(i) = RuleOut(j);  
            end;
        end;
        if ~Matched
            NextState(i) = '.';
        end;
    end;
    State = NextState
    
    
    [TrimmedState, StartIndex] = trim_state(State);
    LT(Generation) = length(TrimmedState);
    if strcmp(TrimmedState, Input)
        disp(['Found repetition after ' num2str(Generation) 'Generations']);
        break;
    end;
end;

sum(Labels(State == '#'))

% figure; plot(LT)

% After some number of generations < 200, we form a glider which travels to
% the right at a rate of 1 square per generation. 
StartLabel0 = Labels(StartIndex);
StartLabelFinal = StartLabel0 - 200;
LabelFinal = StartLabelFinal:(StartLabelFinal+length(TrimmedState));

sum(LabelFinal(TrimmedState == '#'));
Solution = int64(sum(LabelFinal(TrimmedState == '#')) + sum(TrimmedState == '#') * 50000000000)

% A = sum(LabelFinal(TrimmedState == '#'))
% B = sum(TrimmedState == '#')
% C = 50000000000
% The only way for this to be tractable is if at some point we get the same
% state back again. So let's search for when this happens.