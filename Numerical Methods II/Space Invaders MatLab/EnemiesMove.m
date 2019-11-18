function [enemiesPos, speed, lose] = EnemiesMove(col, row, enemiesPos, ...
    enemiesTab, speed, stepDown, minX, maxX, minY)
%Walczak Patryk 13.11.2019
%The funtion move all active enemies by speed (vertial) and by stepDown
%horizontal between minX and maxX till eny active enemy reaches the minY
%then return lose=true == Game is Over

%Input:
%col          - number of enemies in column    
%row          - number of enemies in row
%enemiesPos   - array of all enemies' positions before move
%enemiesTab   - array of all enemies' statementus 
                    %true  - enemy is active (still in game)
                    %false - enemy is inactive (not in game)
%speed        - speed of enemy (horizontal)
%stepDown     - step in down before the move(change of vertical coordiantes)
%minX         - left bound of the enemies
%maxX         - right bound of the enemies
%minY         - minimal y coordinate - if enemy reachs the level game is
                                       %lost

%Output:
%enemiesPos   - array of all enemies' positions after move
%speed        - speed of enemy after the move (horizontal)
%lose         - true if enemy reachs minY, false otherwise

%init return variable
lose=false;
%init statemen 'step'- true if reachs any (right||left) bound, then change y
%coordinate by stepDown, false otherwise
step=false;

%right - coordinates of the right-most enemy 
for i = 1:col  %for all enemies in a column
    for j = 1:row %for all enemies in a row
        if enemiesTab(i, j)
            right = enemiesPos(:, :, i, j);
            break;
        end
    end
end
%letf - coordinates of the left-most enemy 
for i = col:-1:1 %for all enemies in a column (but from RHS to LHS)
    for j = 1:row %for all enemies in a row
        if enemiesTab(i, j)
            left = enemiesPos(:, :, i, j);
            break;
        end
    end
end
%low - coordinates of the lowest enemy 
for j = 1:row %for all enemies in a row
    for i = 1:col %for all enemies in a column
        if enemiesTab(i, j)
            low = enemiesPos(:, :, i, j);
            break;
        end
    end
end

%did lowest enemy reach the minimal level
if low(2, 1) <= minY
    %if yes then return lost game
    lose = true;
    return;
end

%did the eigth-most enemy reach rigth bound
if max(right(1, :)) > maxX && speed > 0
    %if yes then change direction
    speed = speed*(-1); 
    step = true;
%did the letf-most enemy reach rigth bound    
elseif min(left(1, :)) < minX && speed < 0
    %if yes then change direction
    speed = speed*(-1);
    step = true;
end

for i = 1:col %for all enemies in a column
    for j = 1:row %for all enemies in a row
        %if enemy is active (still in game)
        if enemiesTab(i, j)
            %take enemy position
            tmpEn = enemiesPos(:, :, i, j);
            %move enemy
            tmpEn(1, :) = tmpEn(1, :)+speed;
            %should be a step
            if step
                %if yes then change y coordinate of the enemy
                tmpEn(2, :) = tmpEn(2, :)-stepDown;
            end
            %save enemy position
            enemiesPos(:, :, i, j) = tmpEn;  
        end
    end
end

