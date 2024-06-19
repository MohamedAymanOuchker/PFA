% Create a new FIS
fis = mamfis('Name', 'RobotNavigation');

% Add inputs
fis = addInput(fis, [0 100], 'Name', 'FrontDistance');
fis = addInput(fis, [0 100], 'Name', 'RightDistance');
fis = addInput(fis, [0 100], 'Name', 'LeftDistance');
fis = addInput(fis, [0 360], 'Name', 'Orientation');

% Define membership functions for inputs
fis = addMF(fis, 'FrontDistance', 'trapmf', [-10 0 20 40], 'Name', 'Close');
fis = addMF(fis, 'FrontDistance', 'trapmf', [20 40 60 80], 'Name', 'Medium');
fis = addMF(fis, 'FrontDistance', 'trapmf', [60 80 100 110], 'Name', 'Far');

fis = addMF(fis, 'RightDistance', 'trapmf', [-10 0 20 40], 'Name', 'Close');
fis = addMF(fis, 'RightDistance', 'trapmf', [20 40 60 80], 'Name', 'Medium');
fis = addMF(fis, 'RightDistance', 'trapmf', [60 80 100 110], 'Name', 'Far');

fis = addMF(fis, 'LeftDistance', 'trapmf', [-10 0 20 40], 'Name', 'Close');
fis = addMF(fis, 'LeftDistance', 'trapmf', [20 40 60 80], 'Name', 'Medium');
fis = addMF(fis, 'LeftDistance', 'trapmf', [60 80 100 110], 'Name', 'Far');

fis = addMF(fis, 'Orientation', 'trapmf', [-10 0 90 180], 'Name', 'North');
fis = addMF(fis, 'Orientation', 'trapmf', [90 180 270 360], 'Name', 'South');
fis = addMF(fis, 'Orientation', 'trapmf', [180 270 360 450], 'Name', 'East');
fis = addMF(fis, 'Orientation', 'trapmf', [-90 0 90 180], 'Name', 'West');

% Add output
fis = addOutput(fis, [-180 180], 'Name', 'TurnAngle');

% Define membership functions for output
fis = addMF(fis, 'TurnAngle', 'trimf', [-180 -90 0], 'Name', 'Left');
fis = addMF(fis, 'TurnAngle', 'trimf', [-90 0 90], 'Name', 'Straight');
fis = addMF(fis, 'TurnAngle', 'trimf', [0 90 180], 'Name', 'Right');

% Define rules
rules = [
    "If FrontDistance is Close then TurnAngle is Left"
    "If FrontDistance is Close and RightDistance is Close then TurnAngle is Left"
    "If FrontDistance is Close and LeftDistance is Close then TurnAngle is Right"
    "If FrontDistance is Close and RightDistance is Medium then TurnAngle is Left"
    "If FrontDistance is Close and LeftDistance is Medium then TurnAngle is Right"
    "If FrontDistance is Close and RightDistance is Far then TurnAngle is Left"
    "If FrontDistance is Close and LeftDistance is Far then TurnAngle is Right"
    "If FrontDistance is Medium then TurnAngle is Straight"
    "If FrontDistance is Medium and RightDistance is Close then TurnAngle is Left"
    "If FrontDistance is Medium and LeftDistance is Close then TurnAngle is Right"
    "If FrontDistance is Medium and RightDistance is Medium then TurnAngle is Left"
    "If FrontDistance is Medium and LeftDistance is Medium then TurnAngle is Right"
    "If FrontDistance is Medium and RightDistance is Far then TurnAngle is Straight"
    "If FrontDistance is Medium and LeftDistance is Far then TurnAngle is Straight"
    "If FrontDistance is Far then TurnAngle is Straight"
    "If FrontDistance is Far and RightDistance is Close then TurnAngle is Left"
    "If FrontDistance is Far and LeftDistance is Close then TurnAngle is Right"
    "If FrontDistance is Far and RightDistance is Medium then TurnAngle is Left"
    "If FrontDistance is Far and LeftDistance is Medium then TurnAngle is Right"
    "If FrontDistance is Far and RightDistance is Far then TurnAngle is Straight"
    "If FrontDistance is Far and LeftDistance is Far then TurnAngle is Straight"
    "If FrontDistance is Far and RightDistance is Close and LeftDistance is Close then TurnAngle is Straight"
    "If RightDistance is Close then TurnAngle is Left"
    "If RightDistance is Close and LeftDistance is Close then TurnAngle is Straight"
    "If RightDistance is Close and LeftDistance is Medium then TurnAngle is Straight"
    "If RightDistance is Close and LeftDistance is Far then TurnAngle is Straight"
    "If RightDistance is Medium then TurnAngle is Straight"
    "If RightDistance is Medium and LeftDistance is Close then TurnAngle is Straight"
    "If RightDistance is Medium and LeftDistance is Medium then TurnAngle is Straight"
    "If RightDistance is Medium and LeftDistance is Far then TurnAngle is Straight"
    "If RightDistance is Far then TurnAngle is Straight"
    "If RightDistance is Far and LeftDistance is Close then TurnAngle is Right"
    "If RightDistance is Far and LeftDistance is Medium then TurnAngle is Right"
    "If RightDistance is Far and LeftDistance is Far then TurnAngle is Straight"
    "If LeftDistance is Close then TurnAngle is Right"
    "If LeftDistance is Close and RightDistance is Medium then TurnAngle is Straight"
    "If LeftDistance is Close and RightDistance is Far then TurnAngle is Straight"
    "If LeftDistance is Medium then TurnAngle is Straight"
    "If LeftDistance is Medium and RightDistance is Medium then TurnAngle is Straight"
    "If LeftDistance is Medium and RightDistance is Far then TurnAngle is Straight"
    "If LeftDistance is Far then TurnAngle is Straight"
    "If LeftDistance is Far and RightDistance is Close then TurnAngle is Left"
    "If LeftDistance is Far and RightDistance is Medium then TurnAngle is Left"
    "If LeftDistance is Far and RightDistance is Far then TurnAngle is Straight"
    "If Orientation is North and LeftDistance is Close then TurnAngle is Right"
    "If Orientation is North and RightDistance is Close then TurnAngle is Left"
    "If Orientation is East and FrontDistance is Close then TurnAngle is Left"
    "If Orientation is East and RightDistance is Close then TurnAngle is Left"
    "If Orientation is South and LeftDistance is Close then TurnAngle is Right"
    "If Orientation is South and FrontDistance is Close then TurnAngle is Left"
    "If Orientation is West and RightDistance is Close then TurnAngle is Right"
    "If Orientation is West and FrontDistance is Close then TurnAngle is Right"
];

% Add rules to the FIS
for i = 1:length(rules)
    fis = addRule(fis, rules(i));
end

% Save the FIS to a file
writeFIS(fis, 'robot_navigation_fis.fis');

% Initialize variables for data storage
dataInputs = [];  % To store sensor readings and other relevant inputs
dataOutputs = []; % To store responses like turn angles

% Initialize the environment and robot
envWidth = 100;
envHeight = 100;
obstacles = setupEnvironment(envWidth, envHeight);
robot = initRobot(envWidth, envHeight);

% Load the FIS
% load('robot_navigation_fis.mat', 'fis');

% Prepare the figure for visualization
figure;
hold on;
plot(obstacles(:,1), obstacles(:,2), 'kx', 'MarkerSize', 10, 'LineWidth', 2);
xlim([0 envWidth]);
ylim([0 envHeight]);
title('Robot Simulation with Mixed Obstacles');
xlabel('X Position');
ylabel('Y Position');
grid on;

% Run simulation for a set number of steps or until a stop condition
numSteps = 500; % Total number of simulation steps
for t = 1:numSteps
    % Simulate sensor readings
    [frontDist, rightDist, leftDist] = simulateSensors(robot, obstacles);

    % Make a decision using the FIS based on sensor readings
    moveCommand = makeDecision(fisfinal, frontDist, rightDist, leftDist, robot.orientation);

    % Update the robot's position and orientation with boundary checks
    robot = updateRobot(robot, moveCommand, envWidth, envHeight);

    % Plot the robot's new position
    quiver(robot.position(1), robot.position(2), cosd(robot.orientation), ...
           sind(robot.orientation), 'MaxHeadSize', 0.5, 'AutoScale', 'off', 'Color', 'r');

    % Optional: pause for animation effect
    pause(0.05);

    % Collect input and output data for further analysis if needed
    currentInputs = [frontDist, rightDist, leftDist, robot.orientation];
    currentOutputs = moveCommand.turnAngle;
    dataInputs = [dataInputs; currentInputs];
    dataOutputs = [dataOutputs; currentOutputs];
end
hold off;

% Save the collected data to a file for later use
save('robot_navigation_data.mat', 'dataInputs', 'dataOutputs');

disp('Data has been successfully saved.');

