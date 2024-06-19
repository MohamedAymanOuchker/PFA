% function moveCommand = makeDecision(frontDist, rightDist, leftDist)
%     % Initialize movement command structure
%     moveCommand.speed = 1; % Standard speed
%     moveCommand.turnAngle = 0; % No turn by default
% 
%     % Define safe distance threshold
%     safeDistance = 10;
% 
%     % Decision logic to avoid collisions
%     if frontDist < safeDistance
%         % If obstacle is too close in front, decide which way to turn
%         if rightDist > leftDist
%             moveCommand.turnAngle = -45; % Turn right
%         else
%             moveCommand.turnAngle = 45; % Turn left
%         end
%     elseif rightDist < safeDistance
%         % If obstacle is too close on the right, turn left
%         moveCommand.turnAngle = 45;
%     elseif leftDist < safeDistance
%         % If obstacle is too close on the left, turn right
%         moveCommand.turnAngle = -45;
%     end
% end

function moveCommand = makeDecision(fis, frontDist, rightDist, leftDist, orientation)
    % Prepare the input data for FIS
    fisInput = [frontDist, rightDist, leftDist, orientation];
    
    % Use the FIS to predict the turn angle
    turnAngle = evalfis(fis, fisInput);
    
    % Set the move command with a fixed speed and the predicted turn angle
    moveCommand.speed = 1; % Fixed speed
    moveCommand.turnAngle = turnAngle;
end
