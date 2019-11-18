function [col, row, enemiesPos,enemiesPlots,enemiesTab] = Enemies(scale, col, row,...
    pY, pX, spaceY, spaceX)
%Walczak Patryk 13.11.2019
%The funtion prepares the enemy shapes, positions and plots it on the screen

%Input:
%scale        - scale of the enemy
%col          - number of enemies in column before the corectness test    
%row          - number of enemies in row after the corectness test 
%pY           - y coordinate of the initial first enemy position
%pX           - x coordinate of the initial first enemy position
%spaceY       - space between two enemies in Y axis(without height of the enemy shape)
%spaceX       - space between two enemies in X axis(without width of the enemy shape)

%Output:
%col          - number of enemies in column after the corectness test    
%row          - number of enemies in row after the corectness test 
%enemiesPos   - array of all enemies' positions
%enemiesPlots - array of all enemies' pointers to plots
%enemiesTab   - array of all enemies' status 
                    %true  - enemy is active (still in game)
                    %false - enemy is inactive (not in game)

%corectness test
%minimal number of enemis per row or 
if col <= 0
    col = 1;
end
if row <= 0
    row = 1;
end

%basic shape of enemy
em = [ 0 2 2 4 4 5 5 7 7 8 8 10 10 12 12 10 10 9 9 12 12 11 11 8 8 4 4 1 1 0 0 3 3 2 2 0 0 ; ...
       0 0 1 1 2 2 1 1 2 2 1  1  0  0  1  1  2 2 3  3  6  6  7 7 8 8 7 7 6 6 3 3 2 2 1 1 0];
%resize shape  
em = em*scale;
%change coordinates
em(1, :) = em(1, :)+pX;
em(2, :) = em(2, :)+pY;
%init return variables
enemiesPlots = (0);
enemiesTab = logical(ones(col, row));
enemiesPos = zeros(2, 37, col, row);

for i = 1:col %for all enemies in a column
    for j = 1:row %for all enemies in a row
        %set proper coordinates of each enemy
        tmp = em;
        tmp(1, :) = tmp(1, :)+(spaceX*(i-1));
        tmp(2, :) = tmp(2, :)-(spaceY*(j-1));
        %add enemy coordinates to array enemiesPos
        enemiesPos(:, :, i, j) = tmp;
        %plot enemy and add the plot to array enemiesPlots
        enemiesPlots(i, j) = (plot(tmp(1, :), tmp(2, :), 'color', 'red',...
            'linewidth', 5));
    end
end


