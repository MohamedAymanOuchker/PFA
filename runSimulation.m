% Initialize variables for data storage
dataInputs = [];  % To store sensor readings and other relevant inputs
dataOutputs = []; % To store responses like turning angles or speeds

% Initialize the environment and robot
envWidth = 100;
envHeight = 100;
obstacles = setupEnvironment(envWidth, envHeight);
robot = initRobot(envWidth, envHeight);

% Prepare the figure for visualization
figure;
hold on;
plot(obstacles(:,1), obstacles(:,2), 'kx', 'MarkerSize', 10, 'LineWidth', 2);
xlim([0 envWidth]);
ylim([0 envHeight]);
title('Robot Simulation');
xlabel('X Position');
ylabel('Y Position');
grid on;

% Run simulation for a set number of steps or until a stop condition
numSteps = 500; % Total number of simulation steps
for t = 1:numSteps
    % Simulate sensor readings
    [frontDist, rightDist, leftDist] = simulateSensors(robot, obstacles);

    % Make a decision based on sensor readings
    moveCommand = makeDecision(frontDist, rightDist, leftDist);

    % Update the robot's position and orientation with boundary checks
    robot = updateRobot(robot, moveCommand, envWidth, envHeight);

    % Plot the robot's new position
    quiver(robot.position(1), robot.position(2), cosd(robot.orientation), ...
           sind(robot.orientation), 'MaxHeadSize', 0.5, 'AutoScale', 'off', 'Color', 'r');

    % Optional: pause for animation effect
    pause(0.05);

    % Collect input and output data
    % currentInputs = [frontDist, rightDist, leftDist, robot.orientation];
    % currentOutputs = [moveCommand.speed, moveCommand.turnAngle];
    currentInputs = [frontDist, rightDist, leftDist, robot.orientation];
    currentOutputs = [moveCommand.turnAngle];
    dataInputs = [dataInputs; currentInputs];
    dataOutputs = [dataOutputs; currentOutputs];
end
hold off;

% Save the collected data to a file for later use
save('robot_navigation_data.mat', 'dataInputs', 'dataOutputs');

% Define column headers
% inputHeaders = {'FrontDistance', 'RightDistance', 'LeftDistance', 'Orientation'};
% outputHeaders = {'Speed', 'TurnAngle'};
inputHeaders = {'FrontDistance', 'RightDistance', 'LeftDistance', 'Orientation'};
outputHeaders = {'TurnAngle'};
allHeaders = [inputHeaders, outputHeaders];

% Create a table from the matrix
combinedData = [dataInputs, dataOutputs];
dataTable = array2table(combinedData, 'VariableNames', allHeaders);

% Save the table to a CSV file
writetable(dataTable, 'robot_navigation_data.csv');


disp('Data has been successfully saved.');