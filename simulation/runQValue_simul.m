function [] = runQValue_simul(parameterFile, outcomeFile, choiceFile,...
     filenameQ,filenameP,trialsq, sRun,choiceRule)
%generate nrIt sample for all subject (rows) in paramterFile

%read in the outcome, choice and start values input files for all subjects

parameter = csvread(parameterFile);% alpha, temp, beta, gamma, epsilon
outcome = csvread(outcomeFile);
subjects = size(parameter,1);
options = size(outcome,2)/subjects;
nrParam = size(parameter,2);
trials = size(outcome,1);

trialArr = {'all','sta','dyn'};

dataAllSubQT = zeros(trials,30*options,subjects);
dataAllSubPT = zeros(trials,30*options,subjects);

%run for all subject: genQValue(param, outcome, choiceRule)
for s = 1 : subjects
	if sRun ~=0
        choiceFileName=[choiceFile,'_',num2str(s),'_',trialArr{trialsq},...
        	'_',num2str(sRun),'.csv'];
    else
        choiceFileName=[choiceFile,'_',num2str(s),'_',trialArr{trialsq},'.csv'];
    end
    choice = csvread(choiceFileName);
    nrIt=size(choice,2)/options;
    %disp(s);
    %disp(nrIt);

	for run = 1 : nrIt
	    [dataOneSubQ(:,:) dataOneSubP(:,:) ] = genQValue_n(parameter(s,:),...
	    	outcome(:,((s-1)*options)+1:(s*options)),...
	        choice(:,((run-1)*options)+1:(run*options)),choiceRule);
	    dataAllSubQT(:,((run-1)*options)+1:(run*options),s)=dataOneSubQ;
	    dataAllSubPT(:,((run-1)*options)+1:(run*options),s)=dataOneSubP;
	end
end

for run = 1 : nrIt
	dataAllSubQ = [];
	dataAllSubP = [];
	for s = 1 : subjects
		dataAllSubQ = [dataAllSubQ dataAllSubQT(:,((run-1)*options)+1:(run*options),s)];
		dataAllSubP = [dataAllSubP dataAllSubPT(:,((run-1)*options)+1:(run*options),s)];
	end
	filenameQQ = [ filenameQ,'_',num2str(run),'.csv' ];
	filenamePP = [ filenameP,'_',num2str(run),'.csv' ];

	csvwrite(filenameQQ,dataAllSubQ);
	csvwrite(filenamePP,dataAllSubP);
end

disp(choiceFile);