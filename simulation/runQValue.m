function [] = runQValue(parameterFile, outcomeFile, choiceFile,...
    choiceRule, outputFile, outputSummaryFile)
%generate nrIt sample for all subject (rows) in paramterFile

%read in the outcome, choice and start values input files for all subjects


parameter = csvread(parameterFile);% alpha, temp, beta, gamma, epsilon
outcome = csvread(outcomeFile);
choice = csvread(choiceFile);
subjects = size(parameter,1);
options = size(outcome,2)/subjects;
nrParam = size(parameter,2);
dataAllSub = [];

%run for all subject: genQValue(param, outcome, choiceRule)
for s = 1 : subjects
    dataOneSub(:,:) = genQValue(parameter(s,:), outcome(:,((s-1)*options)+1:(s*options)),...
        choice(:,((s-1)*options)+1:(s*options)),choiceRule);
	if choiceRule == 1
        filename = [outputFile,num2str(nrParam),'P_',...
            num2str(s),'_v',num2str(choiceRule), '.csv' ];
    elseif choiceRule == 2 
        filename = [outputFile,num2str(nrParam-1),'P_',...
            num2str(s),'_v',num2str(choiceRule),'.csv' ];
    end
    csvwrite(filename,dataOneSub);
    dataAllSub=[dataAllSub dataOneSub];
end

if choiceRule == 1
    filename = [ outputSummaryFile,num2str(nrParam),'P_',...
        num2str(s),'_v',num2str(choiceRule), '.csv' ];
elseif choiceRule == 2 
    filename = [ outputSummaryFile,num2str(nrParam-1),'P_',...
        num2str(s),'_v',num2str(choiceRule),'.csv' ];
end
csvwrite(filename,dataAllSub);