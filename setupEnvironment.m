function obstacles = setupEnvironment(envWidth, envHeight)
    % Define the number of obstacles around the perimeter
    numObstaclesPerSide = 100;  % Adjust for boundary density

    % Define the number of random obstacles inside the grid
    numRandomObstacles = 30;  % Adjust based on desired obstacle density

    % Initialize obstacle positions
    totalObstacles = numObstaclesPerSide * 4 + numRandomObstacles;
    obstacles = zeros(totalObstacles, 2);

    % Fill in the boundary obstacles
    % Top and bottom boundaries
    for i = 1:numObstaclesPerSide
        % Top boundary
        obstacles(i, :) = [i * envWidth / numObstaclesPerSide, envHeight];
        % Bottom boundary
        obstacles(numObstaclesPerSide + i, :) = [i * envWidth / numObstaclesPerSide, 0];
    end

    % Left and right boundaries
    for i = 1:numObstaclesPerSide
        % Left boundary
        obstacles(2 * numObstaclesPerSide + i, :) = [0, i * envHeight / numObstaclesPerSide];
        % Right boundary
        obstacles(3 * numObstaclesPerSide + i, :) = [envWidth, i * envHeight / numObstaclesPerSide];
    end

    % Add random obstacles inside the grid
    for i = 1:numRandomObstacles
        randomX = rand() * envWidth;
        randomY = rand() * envHeight;
        obstacles(4 * numObstaclesPerSide + i, :) = [randomX, randomY];
    end

    % Display the environment with obstacles for verification
    figure;
    plot(obstacles(:,1), obstacles(:,2), 'kx', 'MarkerSize', 10, 'LineWidth', 2);
    axis([0 envWidth 0 envHeight]);
    title('Simulation Environment with Mixed Obstacles');
    xlabel('X Position');
    ylabel('Y Position');
    grid on;
end
