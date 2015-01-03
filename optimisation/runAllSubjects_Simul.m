function [] = runAllSubjects_Simul( choiceFile, outcomeFile, ...
    startFile, outputFile, sRun, trialsq, choiceRule)

%function to run optimization for all subject at once

%read in the outcome, choice and start values input files for all subjects
options = 4;
outcome = csvread(outcomeFile);
subjects = size(outcome,2)/options;
startValues = csvread(startFile);  % alpha, temp, gamma, beta, delta, epsilon
nrParam = size(startValues,2);
starts = size(startValues,1);
dataAllSub=[];
exitFl=[];

trialArr = {'all','sta','dyn'};

if trialsq == 1
    tStart = 1;
    tEnd = 220;
elseif trialsq == 2
    tStart = 41;
    tEnd = 120;
elseif trialsq == 3
    tStart = 121;
    tEnd = 220;
%elseif trialsq == 4
%    tStart = 41;
%    tEnd = 220;
end


%for s = 1 : 3
for s = 1 : subjects
    if sRun ~=0
        choiceFileName=[choiceFile,'_',num2str(s),'_',trialArr{trialsq},'_',num2str(sRun),'.csv'];
    else
        choiceFileName=[choiceFile,'_',num2str(s),'_',trialArr{trialsq},'.csv'];
    end
    choice = csvread(choiceFileName);
    %nrIt = 5;
    nrIt=size(choice,2)/options;
    disp(nrIt);

    p1 = zeros(starts*nrIt,1);
    p2 = zeros(starts*nrIt,1);
    p3 = zeros(starts*nrIt,1);
    p4 = zeros(starts*nrIt,1);
    p5 = zeros(starts*nrIt,1);
    p6 = zeros(starts*nrIt,1);
    p7 = zeros(starts*nrIt,1);
    exitFls=zeros(starts*nrIt,1);

    dataOneSub=[];
    for i = 1 : nrIt
    %for i = 1 : 1    
        [data(:,:) lh(:,:) efl(:,:)] = IndOpt(choice(:,((i-1)*options)+1:(i*options)), ...
            outcome(tStart:tEnd,((s-1)*options)+1:(s*options)),startValues, choiceRule);
        if nrParam == 2
            p1((i-1)*starts+1:i*starts,1) = data(:,1);
            p2((i-1)*starts+1:i*starts,1) = data(:,2);
            p3((i-1)*starts+1:i*starts,1) = lh;
            exitFls((i-1)*starts+1:i*starts,1) = efl;
        elseif nrParam == 3
            p1((i-1)*starts+1:i*starts,1) = data(:,1);
            p2((i-1)*starts+1:i*starts,1) = data(:,2);
            p3((i-1)*starts+1:i*starts,1) = data(:,3);
            p4((i-1)*starts+1:i*starts,1) = lh;
            exitFls((i-1)*starts+1:i*starts,1) = efl;
        elseif nrParam == 4
            p1((i-1)*starts+1:i*starts,1) = data(:,1);
            p2((i-1)*starts+1:i*starts,1) = data(:,2);
            p3((i-1)*starts+1:i*starts,1) = data(:,3);
            p4((i-1)*starts+1:i*starts,1) = data(:,4);
            p5((i-1)*starts+1:i*starts,1) = lh;
            exitFls((i-1)*starts+1:i*starts,1) = efl;
        elseif nrParam == 5
            p1((i-1)*starts+1:i*starts,1) = data(:,1);
            p2((i-1)*starts+1:i*starts,1) = data(:,2);
            p3((i-1)*starts+1:i*starts,1) = data(:,3);
            p4((i-1)*starts+1:i*starts,1) = data(:,4);
            p5((i-1)*starts+1:i*starts,1) = data(:,5);
            p6((i-1)*starts+1:i*starts,1) = lh;
            exitFls((i-1)*starts+1:i*starts,1) = efl;
        elseif nrParam == 6
            p1((i-1)*starts+1:i*starts,1) = data(:,1);
            p2((i-1)*starts+1:i*starts,1) = data(:,2);
            p3((i-1)*starts+1:i*starts,1) = data(:,3);
            p4((i-1)*starts+1:i*starts,1) = data(:,4);
            p5((i-1)*starts+1:i*starts,1) = data(:,5);
            p6((i-1)*starts+1:i*starts,1) = data(:,6);
            p7((i-1)*starts+1:i*starts,1) = lh;
            exitFls((i-1)*starts+1:i*starts,1) = efl;
        end
    end

    if nrParam == 2
        dataOneSub = [p1;p2;p3];
    elseif nrParam == 3
        dataOneSub = [p1;p2;p3;p4];    
    elseif nrParam == 4
        dataOneSub = [p1;p2;p3;p4;p5];
    elseif nrParam == 5
        dataOneSub = [p1;p2;p3;p4;p5;p6];
    elseif nrParam == 6
        dataOneSub = [p1;p2;p3;p4;p5;p6;p7];
    end    


% % save file for each subject
%     if choiceRule == 1
%         filename = [outputFile,'_',num2str(nrParam),'P_',...
%             num2str(s),'_v',num2str(choiceRule),'.csv' ];
%     elseif choiceRule == 2
%         filename = [outputFile,'_',num2str(nrParam-1),'P_',...
%             num2str(s),'_v',num2str(choiceRule),'.csv' ];
%     end
%     csvwrite(filename,dataOneSub);
    dataAllSub  = [dataAllSub dataOneSub];
    exitFl  = [exitFl exitFls];
    text = ['Subject',num2str(s)];
    disp(text);
end

if sRun ~=0
    filename = [ outputFile,'M',num2str(nrParam-1),num2str(choiceRule),'_',...
    trialArr{trialsq},'_',num2str(sRun),'.csv' ];
    filename1 = [ outputFile,'M',num2str(nrParam-1),num2str(choiceRule),'_',...
    trialArr{trialsq},'_',num2str(sRun),'_exit','.csv' ];
else
    filename = [ outputFile,'M',num2str(nrParam-1),num2str(choiceRule),'_',...
    trialArr{trialsq},'.csv' ];
    filename1 = [ outputFile,'M',num2str(nrParam-1),num2str(choiceRule),'_',...
    trialArr{trialsq},'_exit','.csv' ];
end
csvwrite(filename1,exitFl);
csvwrite(filename,dataAllSub);