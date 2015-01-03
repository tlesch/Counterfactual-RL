function [] = runSimul_be( parameterFile, outcomeFile, outputFile, nrIt,...
    sRun, trialsq)
%generate nrIt sample for all subject (rows) in paramterFile

%read in the outcome, choice and start values input files for all subjects

parameter = csvread(parameterFile);% alpha, temp, beta, gamma, epsilon
outcome = csvread(outcomeFile);
subjects = size(parameter,1);
options = size(outcome,2)/subjects;
nrParam = size(parameter,2);
choiceRule = 1;

trialArr = {'all','sta','dyn'};
%trialsq = 1;

if trialsq == 1
    tStart = 1;
    tEnd = 240;
elseif trialsq == 2
    tStart = 181;
    tEnd = 240;
elseif trialsq == 3
    tStart = 61;
    tEnd = 180;
end

%run for all subject: simulData(param, outcome, nrIt,choiceRule)
for s = 1 : subjects
    data(:,:,:) = simulData(parameter(s,:), outcome(tStart:tEnd,((s-1)*options)+1:(s*options)),...
        nrIt,choiceRule);
	if sRun ~= 0
        filename = [ outputFile,'M', num2str(nrParam-1),'_'...
            num2str(s),'_',trialArr{trialsq},'_',num2str(sRun), '.csv' ];
    else 
        filename = [ outputFile,'M', num2str(nrParam-1),'_'...
            num2str(s),'_',trialArr{trialsq},'.csv' ];
    end
csvwrite(filename,data);
end