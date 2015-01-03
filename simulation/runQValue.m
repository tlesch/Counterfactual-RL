function [] = runQValue(parameterFile, outcomeFile, choiceFile,...
     filenameQ,filenameP,choiceRule)
%generate nrIt sample for all subject (rows) in paramterFile

%read in the outcome, choice and start values input files for all subjects

parameter = csvread(parameterFile);% alpha, temp, beta, gamma, epsilon
outcome = csvread(outcomeFile);
choice = csvread(choiceFile);
subjects = size(parameter,1);
options = size(outcome,2)/subjects;
nrParam = size(parameter,2);
dataAllSubQ = [];
dataAllSubP = [];

%run for all subject: genQValue(param, outcome, choiceRule)
for s = 1 : subjects
    [dataOneSubQ(:,:) dataOneSubP(:,:) ] = genQValue_n(parameter(s,:), outcome(:,((s-1)*options)+1:(s*options)),...
        choice(:,((s-1)*options)+1:(s*options)),choiceRule);
    dataAllSubQ=[dataAllSubQ dataOneSubQ];
    dataAllSubP=[dataAllSubP dataOneSubP];
end

csvwrite(filenameQ,dataAllSubQ);
csvwrite(filenameP,dataAllSubP);