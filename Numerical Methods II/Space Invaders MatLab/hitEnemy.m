function [statement,corY,corX] = hitEnemy(laser,col,row,enemiesPos,...
    enemiesTab,enemyScale)
%Walczak Patryk 13.11.2019
%The funtion chech if the laser hit any active enemy

%Input:
%laser       - coordinates of the laser
%enemiesPos   - array of all enemies' positions
%col          - number of enemies in column    
%row          - number of enemies in row
%enemiesTab   - array of all enemies' statementus 
                    %true  - enemy is active (still in game)
                    %false - enemy is inactive (not in game)
%enemyScale   - scale of the enemy

%Output:
%statement    - true if laser hit enemy, false otherwise
%corY         - y coordinate of the shooted enemy
%corX         - x coordinate of the shooted enemy

%init return variables
statement = false;
corY = -1;
corX = -1;
%enemy height
EnHeight = 8*enemyScale;  
%enemy width
EnWidth = 12*enemyScale;  

for i = 1:col %for all enemies in a column
    for j = 1:row %for all enemies in a row
        if enemiesTab(i, j) %if enemy is active
            %tmpEn=[x coordinate of enemy, y coordinate of enemy]
            tmpEn = enemiesPos(:, :, i, j);
            tmpEn = [tmpEn(1, 1), tmpEn(2, 1)]; 
            %if laser is in the shape of enemy
            if laser(2, 2) >= tmpEn(2) && laser(2, 2) <= (tmpEn(2)+EnHeight) && ...
                    laser(1, 2) >= tmpEn(1) && laser(1, 2) <= (tmpEn(1)+EnWidth)
                %save the shooted enemy and return
                corY = i;
                corX = j;
                statement = true;
                return;
            end
        end
    end
end

