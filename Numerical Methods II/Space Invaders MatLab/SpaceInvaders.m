%File contins two funtions SpaceInvaders() and keypress(varargin)
function SpaceInvaders()
%Walczak Patryk 13.11.2019
%MatLab version of Space Invaders
%startin file using : Player.m, Laser.m, Enemis.m, EnemisMove.m,
                     %hitEnemy.m
%several variables for user
col = 8; 				%number of enemies in a col >0
row = 4;				%number of enemirs in a row >0
screen = [640, 480];	%size of screen
playerSpeed = 7.5;      %player movement speed
enemySpeed = 1.1;		%enemy movement speed
laserSpeed = 4.5;      %laser movement speed
enemyScale = 4;		    %scale of enemy
playerScale = 4;		%scale of player
maxLasers = 5 ;        %upper bound of number of lasers  
minY = 1/5*screen(2);   %lower bound, if enemy reaches this level game is over

%Set up a window       
f = figure('color', 'red', 'Resize', 'off');
set(f, 'Menu', 'none', 'Position', [400 400 screen(1) screen(2)]);
ax = axes('NextPlot', 'add');
title(ax, 'MatLab Space Invaders');
axis(ax, [0 screen(1) 0 screen(2)]);
set(ax, 'XTick', [], 'YTick', [], 'Xcolor', 'red', 'Ycolor', 'red');
set(ax, 'OuterPosition', [-0.05 -0.025 1.065 1.02]);

%Welcome Screen
set(gca, 'color', [0 0 0]);
t1 = text(screen(1)/10, screen(2)*(6/7), 'Space', 'color', 'white', 'FontSize', 39);
t2 = text(screen(1)/10+3, screen(2)*(6/7)+3, 'Space', 'color', 'blue', 'FontSize', 39);
t3 = text(screen(1)/10, screen(2)*(5/7), 'Invaders', 'color', 'white', 'FontSize', 59);
t4 = text(screen(1)/10+3, screen(2)*(5/7)+3, 'Invaders', 'color', 'blue', 'FontSize', 59);
t5 = text(screen(1)/5, 30, 'Press Any key to Start', 'color', 'w', 'FontSize', 20);
text(screen(1)-90, -40, 'by Patryk Walczak', 'color', 'w', 'FontSize', 10);
drawnow;
%wait for any key
waitforbuttonpress ;
%delete all texts from Welcome Screen
delete(t1);
delete(t2);
delete(t3);
delete(t4);
delete(t5);

%get default keypresfcn and set keypress as new one
key = get(f, 'keypressfcn');
set(f, 'keypressfcn', @keypress);
%draw minimal line, if enemy reaches the line game is over
yLine = yline(minY, 'color', 'w');

%Create Player and Enemies
[posPlayer, plotPlayer] = Player(playerScale, 20, (screen(1)-(11*playerScale))/2);
[col, row, EnemiesPos, EnemiesPolts, EnemiesTab]=Enemies(enemyScale, col, row,...
    screen(2)-50, 30, 40, 60);
%write on the screen current number of enemies and lasers
text(3, -10, 'Number of enemies :', 'color', 'w', 'FontSize', 10, 'fontweight', 'bold');
t_NoE = text( 190, -10, num2str(col*row), 'color', 'w', 'FontSize', 10, 'fontweight', 'bold');
text(screen(1)-280, -10, 'Number of avaiable lasers :', 'color', 'w', 'FontSize', 10, 'fontweight', 'bold');
t_NoL = text(screen(1)-20, -10, num2str(maxLasers), 'color', 'w', 'FontSize', 10, 'fontweight', 'bold');

%init variables
%array of all lasers' pointers to plots
lasersPlots = (zeros(maxLasers)); 
%array of all lasers' positions
LasersPos = zeros(2, 3, maxLasers, 1);
%array of all lasers' status before the new laser
                    %true  - laser is active (still on screen)
                    %false - laser is inactive (not on screen)
laserTab = logical(zeros(maxLasers));
%current number of enemies
numOfEnemies = row*col;
%current number of lasers
numOfLasers = maxLasers;
%status if game is over
lose = false;

%half of a second to prepare
pause(0.5);
%while window is open
while ishandle(f)
    %drawing player
    set(plotPlayer, 'XData', posPlayer(1, :));
    set(plotPlayer, 'YData', posPlayer(2, :));
    %moving enemies
    [EnemiesPos, enemySpeed, lose] = EnemiesMove(col, row, EnemiesPos,...
        EnemiesTab, enemySpeed, 10, 10, screen(1)-10, 100);
    %drawing all enemies
    for i = 1:col 
        for j = 1:row
            if EnemiesTab(i,j)
                tmpEn = EnemiesPos(:, :, i, j);
                set(EnemiesPolts(i, j),'XData',tmpEn(1, :));
                set(EnemiesPolts(i, j),'YData',tmpEn(2, :));
            end
        end
    end
    %for all lasers
    for i=1:maxLasers
        %if laser is active
        if laserTab(i)
            tmp = LasersPos(:, :, i, 1);
            %if the laser is on the screen
            if max(tmp(2, :)) < screen(1)-100 
                tmp(2, :) = tmp(2, :)+laserSpeed;
                %checking if the laser hit any enemy
                [stat, corY, corX] = hitEnemy(tmp, col, row, EnemiesPos,...
                    EnemiesTab, enemyScale);
                %if enemy is shooted
                if stat
                    %change laser status to inactive (false)
                    laserTab(i) = false;
                    %increase number of avaiable lasers
                    numOfLasers = numOfLasers+1;
                    %delete laser plot
                    delete(lasersPlots(i));
                    lasersPlots(i) = 0;
                    %change status od the enemy to inactive (false)
                    EnemiesTab(corY, corX) = false;
                    %delete enemy's plot
                    delete(EnemiesPolts(corY, corX));
                    %decrease number of enemies by 1
                    numOfEnemies = numOfEnemies-1;
                    %update text number of enemies 
                else
                    %save laser position
                    LasersPos(:, :, i, 1) = tmp;
                    %draw laser
                    set(lasersPlots(i), 'XData', tmp(1, :));
                    set(lasersPlots(i), 'YData',tmp(2, :)); 
                end
            else
                %change laser status to inactive (false)
                laserTab(i) = false;
                %increase number of avaiable lasers
                 numOfLasers = numOfLasers+1;
                %delete laser plot
                delete(lasersPlots(i));
                lasersPlots(i) = 0;
            end
        end
        %update number of avaiable lasers
        delete(t_NoL);
        t_NoL = text(screen(1)-20, -10, num2str(numOfLasers), 'color', 'w', 'FontSize', 10, 'fontweight', 'bold'); 
        delete(t_NoE);
        t_NoE = text( 190, -10, num2str(numOfEnemies), 'color', 'w', 'FontSize', 10, 'fontweight', 'bold'); 
    end
    drawnow;
    %Win/Lose conditions
    %if number of enemies == 0 then Win
    if numOfEnemies == 0
        %delete player and line from screen
        delete(plotPlayer);
        delete(yLine);
        %ser backgroud to balck
        set(gca, 'color', [0 0 0]);
        %set default keypressfcn
        set(f, 'keypressfcn', key);
        %text message
        text(screen(1)/10, screen(2)*(6/7), 'Win !!!', 'color', 'white', 'FontSize', 39);
        text(screen(1)/10+3, screen(2)*(6/7), 'Win !!!', 'color', 'green', 'FontSize', 39);
        text(screen(1)/5, 30, 'Press Any key to Exit', 'color', 'w', 'FontSize', 20);
        drawnow;
        pause(0.5);
        waitforbuttonpress;
        %exit
        close(f);
        return;
    %if enemy reaches minY then game is over
    elseif lose
        %delete player and line from screen and rest enemies
        delete(plotPlayer);
        delete(yLine);
        for i = 1:col 
        	 for j = 1:row
                if EnemiesTab(i, j)
                    delete(EnemiesPolts(i, j));
                end
            end
        end
        %ser backgroud to balck
        set(gca, 'color', [0 0 0]);
        %set default keypressfcn
        set(f, 'keypressfcn', key);
        %text message
        text(screen(1)/10, screen(2)*(6/7), 'Game over', 'color', 'white', 'FontSize', 39);
        text(screen(1)/10+3, screen(2)*(6/7), 'Game over', 'color', 'red', 'FontSize', 39);
        text(screen(1)/5, 30, 'Press Any key to Exit', 'color', 'w', 'FontSize', 20);
        drawnow;
        waitforbuttonpress;
        pause(0.5);
        %exit
        close(f);
        return;
    end
end



function keypress(varargin)
%Walczak Patryk 13.11.2019
%The funtion in real time chech if a key is pressed
key = get(gcbf, 'CurrentKey');
if strcmp(key, '')
%if space is preesed
elseif strcmp(key, 'space')
    %player shoots, make a new laser
     [LasersPos, lasersPlots, laserTab, numOfLasers]= Laser(1, posPlayer(1,8),...
         posPlayer(2,8), LasersPos, lasersPlots, laserTab, maxLasers, numOfLasers);
     %update number of avaiable lasers
     delete(t_NoL);
     t_NoL = text(screen(1)-20, -10, num2str(numOfLasers), 'color', 'w', 'FontSize', 10, 'fontweight', 'bold'); 
%if leftarrow is preesed
elseif strcmp(key, 'leftarrow')
    %moving player left.
    if posPlayer(1, 1)-playerSpeed >= 0
        posPlayer(1, :) = posPlayer(1, :)-playerSpeed;
    end
%if rightarrow is preesed
elseif strcmp(key, 'rightarrow')
    %moving player right.
     if posPlayer(1, 15) < screen(1)-10
        posPlayer(1, :) = posPlayer(1, :)+playerSpeed;
    end
end
end
end


