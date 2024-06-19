function moveCommand = makeDecisionWithAnfis(trainedFis, frontDist, rightDist, leftDist, orientation)
    % Prepare the input data for ANFIS
    anfisInput = [frontDist, rightDist, leftDist, orientation];
    
    % Use the trained ANFIS model to predict the turn angle
    predictedTurnAngle = evalfis(trainedFis, anfisInput);
    
    % Set the move command with a fixed speed and the predicted turn angle
    moveCommand.speed = 1; % Fixed speed
    moveCommand.turnAngle = predictedTurnAngle;
end
