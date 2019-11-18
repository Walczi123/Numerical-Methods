function [posPlayer, plotPlayer] = Player(scale, pY, pX)
%Walczak Patryk 13.11.2019
%The funtion prepares the player shape, position and plot it on the screen

%Input:
%scale      - scale of the player
%pY         - y coordinate of the initial player position
%pX         - x coordinate of the initial player position

%Output:
%posPlayer  - current player position
%plotPlayer - pointer to plot of player

%basic shape of player
posPlayer = [ 0 0 1 1 4 4 5 5 6 6 7 7 10 10 11 11 0 ;...
              0 3 3 4 4 6 6 7 7 6 6 4  4  3  3  0 0];
%resize the shape
posPlayer = posPlayer*scale;
%change coordinates
posPlayer(1, :) = posPlayer(1, :)+pX;
posPlayer(2, :) = posPlayer(2, :)+pY;
%plot player
plotPlayer = plot(posPlayer(1, :), posPlayer(2, :), 'color', 'blue', 'linewidth', 5);