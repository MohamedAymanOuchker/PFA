function robot = initRobot(envWidth, envHeight)
    % Initialize robot parameters
    robot.position = [envWidth / 2, envHeight / 2]; % Start at the center of the environment
    robot.orientation = 0; % Facing right (0 degrees)
    robot.sensorRange = 50; % Sensor range of 50 units
    robot.sensorAngle = 90; % Sensor field of view (degrees)
    robot.speed = 1; % Robot speed units per time step
    robot.turnAngle = 45; % Maximum turning angle per time step (degrees)

    % Display robot's initial position and orientation on the plot
    hold on; % Keep the previous plot visible
    quiver(robot.position(1), robot.position(2), cosd(robot.orientation), ...
           sind(robot.orientation), 'MaxHeadSize', 2, 'Color', 'r', 'LineWidth', 2);
    hold off;
    legend('Obstacles', 'Robot Start and Orientation');
end
