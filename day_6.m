clear; clc; close all;

Input = load('day_6_input.txt');

[NumInputs,~] = size(Input);

MinX = min(Input(:,1));
MinY = min(Input(:,2));
MaxX = max(Input(:,1));
MaxY = max(Input(:,2));

%% Part 1
% Note: Here we cheat a little bit. Rather than computing which of the
% plots have an infinite area and ignoring those, we shrink the grid as
% much as possible so the areas at the boundary are as small as possible
% and hence not the maximum. This will not work for general inputs, but
% works fine for ours. 

Grid = zeros(MaxX-MinX+1, MaxY-MinY+1);
PlotSize = zeros(NumInputs,1);

for x = MinX:MaxX
    for y = MinY:MaxY
        Coord = repmat([x, y],NumInputs,1);
        ManhattanDistances = sum(abs(Coord-Input),2);
        [MinDist, PlotID] = min(ManhattanDistances);
        
        % Only count the plot as marked if it is uniquely close to one of the markers. 
        if sum(ManhattanDistances == MinDist) == 1
            PlotSize(PlotID) = PlotSize(PlotID) + 1;
        end;

    end;
end;

max(PlotSize)

% Visualisation
for x = MinX:MaxX
    for y = MinY:MaxY
        Coord = repmat([x, y],NumInputs,1);
        [MinDist, PlotID] = min(sum(abs(Coord-Input),2));
        
        Grid(x - MinX + 1, y - MinY + 1) = PlotSize(PlotID);
    end;
end;

surf(Grid);

%%  Part 2
Grid2 = zeros(MaxX-MinX+1, MaxY-MinY+1);

RegionSize = 0;
for x = MinX:MaxX
    for y = MinY:MaxY
        Coord = repmat([x, y],NumInputs,1);
        ManhattanDistances = sum(abs(Coord-Input),2);
        
        if (sum(ManhattanDistances) < 10000)
            RegionSize = RegionSize + 1;
            Grid2(x - MinX + 1, y - MinY + 1) = 1;
        end;
    end;
end;

RegionSize

figure; contourf(Grid2);