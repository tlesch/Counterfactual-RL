function [] = runSimul( parameterFile, outcomeFile, outputFile, nrIt,...
    sRun,trialsq, choiceRule)
%generate nrIt sample for all subject (rows) in paramterFile

%read in the outcome, choice and start values input files for all subjects

parameter = csvread(parameterFile);% alpha, temp, beta, gamma, epsilon
outcome = csvread(outcomeFile);
subjects = size(parameter,1);
options = size(outcome,2)/subjects;
nrParam = size(parameter,2);

trialArr = {'all','sta','dyn'};
%trialsq = 1;

if trialsq == 1
    tStart = 1;
    tEnd = 220;
elseif trialsq == 2
    tStart = 41;
    tEnd = 120;
elseif trialsq == 3
    tStart = 121;
    tEnd = 220;
end

%run for all subject: simulData(param, outcome, nrIt,choiceRule)
%for s = 1 : 1
for s = 1 : subjects
    data(:,:,:) = simulData(parameter(s,:), outcome(tStart:tEnd,((s-1)*options)+1:(s*options)),...
        nrIt,choiceRule);
	if sRun ~= 0
        filename = [ outputFile,'M', num2str(nrParam-1),num2str(choiceRule),'_',...
            num2str(s),'_',trialArr{trialsq},'_',num2str(sRun),'.csv' ];
    else 
        filename = [ outputFile,'M', num2str(nrParam-1),num2str(choiceRule),'_',...
            num2str(s),'_',trialArr{trialsq},'.csv' ];
    end
csvwrite(filename,data);
end