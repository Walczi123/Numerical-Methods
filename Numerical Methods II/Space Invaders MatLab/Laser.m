function [lasersPos, lasersPlots, laserTab, numOfLasers] = Laser(scale, pY, pX,...
    lasersPos, lasersPlots, laserTab, maxLasers, numOfLasers)
%Walczak Patryk 13.11.2019
%The funtion prepares the new laser shape, position and plot it on the screen

%Input:
%scale        - scale of the player
%pY           - y coordinate of the initial laser position
%pX           - X coordinate of the initial laser position
%lasersPos   - array of all lasers' positions before the new laser
%lasersPlots - array of all lasers' pointers to plots before the new laser
%laserTab    - array of all lasers' status before the new laser
                    %true  - laser is active (still on screen)
                    %false - laser is inactive (not on screen)
%maxLasers   - maximal number of lasers on the screen

%Output:
%lasersPos   - array of all lasers' positions after the new laser
%lasersPlots - array of all lasers' pointers to plots after the new laser
%laserTab    - array of all lasers' status after the new laser
                    %true  - laser is active (still on screen)
                    %false - laser is inactive (not on screen)

                         
%check if on the screen is less then maxLasers active lasers
for i = (1:maxLasers) %for all lasers
   if ~laserTab(i)
       %if yes then break
       break;
   end
   if i == maxLasers
       %if on screen is maxLasers active lasers then return
       return
   end
end

%basic shape of laser
posLaser = [ 0 0 0; ...
              0 1 0];
%resize the shape
posLaser = posLaser*scale;
%change coordinates
posLaser(1, :) = posLaser(1, :)+pY;
posLaser(2, :) = posLaser(2, :)+pX;   
%plot new laser
plotLaser = plot(posLaser(1, :), posLaser(2, :), 'color',...
    [ 0.7 0.7 0 ], 'linewidth', 5);
%check if there is a plot in the inactive laser
if lasersPlots(i) ~= 0
    %if yes then delete, free space for new laser plot
    delete(lasersPlots(i));
end
%add laser coordinates to array lasersPos
lasersPos(:, :, i, 1) = posLaser;
%add laser plot to array lasersPlots
lasersPlots(i) = plotLaser;
%change laser status to active
laserTab(i) = true;
%
numOfLasers=numOfLasers-1;