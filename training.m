% Assuming dataInputs and dataOutputs are already loaded or created
data = [dataInputs, dataOutputs]; % Concatenate input and output data
% 
% Split data into training and testing sets
numData = size(data, 1);
numTrain = floor(0.8 * numData); % 80% for training
numTest = numData - numTrain; % 20% for testing
% 
trainData = data(1:numTrain, :);
testData = data(numTrain+1:end, :);
% 
% Define the number of membership functions per input
% numMFs = 3; % Example: 3 membership functions per input variable
% mfType = 'gaussmf'; % Gaussian membership function
% 
% % Generate a FIS with grid partitioning
% initialFis = genfis1(trainData, numMFs, mfType);
% 
% % Set ANFIS training options
% options = anfisOptions('InitialFIS', initialFis, 'EpochNumber', 100, 'ValidationData', testData);
% 
% % Train the ANFIS model
% [trainedFis,trainError,~,testFis,testError] = anfis(trainData, options);
% 
% % Plot training and test errors
% figure;
% plot(trainError, 'LineWidth', 2);
% hold on;
% plot(testError, 'LineWidth', 2);
% title('ANFIS Training and Test Errors');
% xlabel('Epochs');
% ylabel('Error');
% legend('Training Error', 'Testing Error');
% grid on;

% Predict outputs using the trained ANFIS model
predictedOutputs = evalfis(anfis, testData(:, 1:end-1));

% Compare predicted outputs with actual outputs
figure;
plot(testData(:, end), 'bo', 'MarkerFaceColor', 'b');
hold on;
plot(predictedOutputs, 'r*');
legend('Actual Outputs', 'Predicted Outputs');
title('Comparison of Actual and Predicted Outputs');
xlabel('Data Points');
ylabel('Output Values');
grid on;
