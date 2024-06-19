function [frontDist, rightDist, leftDist] = simulateSensors(robot, obstacles)
    % Initialize distances to a large number, assuming no obstacle initially
    maxSensorRange = robot.sensorRange;
    frontDist = maxSensorRange;
    rightDist = maxSensorRange;
    leftDist = maxSensorRange;

    % Angle adjustments for each sensor relative to the robot's orientation
    frontAngle = robot.orientation; % Front sensor looks straight ahead
    rightAngle = robot.orientation - 90; % Right sensor looks to the right
    leftAngle = robot.orientation + 90; % Left sensor looks to the left

    % Check each obstacle to calculate distances for each sensor
    for i = 1:size(obstacles, 1)
        obsPos = obstacles(i, :);
        obstacleVector = obsPos - robot.position;
        obstacleDist = norm(obstacleVector);
        obstacleAngle = rad2deg(atan2(obstacleVector(2), obstacleVector(1)));

        % Calculate angles relative to the robot's front
        relativeAngleFront = wrapTo180(obstacleAngle - frontAngle);
        relativeAngleRight = wrapTo180(obstacleAngle - rightAngle);
        relativeAngleLeft = wrapTo180(obstacleAngle - leftAngle);

        % Update distances if within sensor range and field of view
        if abs(relativeAngleFront) <= robot.sensorAngle / 2 && obstacleDist < frontDist
            frontDist = obstacleDist;
        end
        if abs(relativeAngleRight) <= robot.sensorAngle / 2 && obstacleDist < rightDist
            rightDist = obstacleDist;
        end
        if abs(relativeAngleLeft) <= robot.sensorAngle / 2 && obstacleDist < leftDist
            leftDist = obstacleDist;
        end
    end

    % Ensure the sensor readings do not exceed the maximum range
    frontDist = min(frontDist, maxSensorRange);
    rightDist = min(rightDist, maxSensorRange);
    leftDist = min(leftDist, maxSensorRange);
end

% Utility function to wrap angle differences to [-180, 180]
function angle = wrapTo180(angle)
    angle = mod(angle + 180, 360) - 180;
end
