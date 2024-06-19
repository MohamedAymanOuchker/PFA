function robot = updateRobot(robot, moveCommand, envWidth, envHeight)
    % Update the robot's orientation
    newOrientation = wrapTo360(robot.orientation + moveCommand.turnAngle);

    % Calculate the potential new position
    potentialX = robot.position(1) + moveCommand.speed * cosd(newOrientation);
    potentialY = robot.position(2) + moveCommand.speed * sind(newOrientation);

    % Check and adjust for boundary conditions
    if potentialX <= 0 || potentialX >= envWidth || potentialY <= 0 || potentialY >= envHeight
        % If the move would exceed boundaries, adjust orientation to turn away from the edge
        % Here, we make the robot turn 180 degrees from its current path
        newOrientation = wrapTo360(newOrientation + 180);
        potentialX = robot.position(1) + moveCommand.speed * cosd(newOrientation);
        potentialY = robot.position(2) + moveCommand.speed * sind(newOrientation);

        % Ensure the robot stays within boundaries after turning
        potentialX = max(min(potentialX, envWidth), 0);
        potentialY = max(min(potentialY, envHeight), 0);
    end

    % Update robot's position and orientation
    robot.position = [potentialX, potentialY];
    robot.orientation = newOrientation;
end

% Utility function to ensure orientation is within [0, 360)
function angle = wrapTo360(angle)
    angle = mod(angle, 360);
end
