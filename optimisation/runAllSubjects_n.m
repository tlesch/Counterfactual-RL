function [] = runAllSubjects( choiceFile, outcomeFile, ...
    startFile,subFile, sRun, trialsq,outputFile,choiceRule)

%function to run optimization for all subject at once
outcome = csvread(outcomeFile);
choice = csvread(choiceFile);
startValues = csvread(startFile); % alpha, temp, gamma, beta, delta, epsilon
subName = csvread(subFile);
subjects = size(subName,1);
options = size(outcome,2)/subjects;
nrParam = size(startValues,2);

%run for all subject

%trialsq: 1: EP & S3, trials 1-220, 2: EP & S3, 1-120, 
% 3: EP & S3: 121-220, 4: EP & S3: 41-120


trialArr = {'all','sta','dyn','allS'};
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
elseif trialsq == 4
    tStart = 41;
    tEnd = 220;
end

%zeros(nrParam*size(startValues,1),subjects);
p1 = [];
p2 = [];
p3 = [];
p4 = [];
p5 = [];
p6 = [];
p7 = [];
exitFl=[];


for s = 1 : subjects
%for s = 1 : 2
    [data(:,:) lh(:,:) efl(:,:)] = IndOpt(choice(tStart:tEnd,((s-1)*options)+1:(s*options)),...
        outcome(tStart:tEnd,((s-1)*options)+1:(s*options)),startValues,choiceRule);

    disp(subName(s));

    if nrParam == 2
            p1 = [p1 data(:,1)];
            p2 = [p2 data(:,2)];
            p3 = [p3 lh];
            exitFl = [exitFl efl];
    elseif nrParam == 3
            p1 = [p1 data(:,1)];
            p2 = [p2 data(:,2)];
            p3 = [p3 data(:,3)];
            p4 = [p4 lh];
            exitFl = [exitFl efl];
    elseif nrParam == 4
            p1 = [p1 data(:,1)];
            p2 = [p2 data(:,2)];
            p3 = [p3 data(:,3)];
            p4 = [p4 data(:,4)];
            p5 = [p5 lh];
            exitFl = [exitFl efl];
    elseif nrParam == 5
            p1 = [p1 data(:,1)];
            p2 = [p2 data(:,2)];
            p3 = [p3 data(:,3)];
            p4 = [p4 data(:,4)];
            p5 = [p5 data(:,5)];
            p6 = [p6 lh];
            exitFl = [exitFl efl];
    elseif nrParam == 6
            p1 = [p1 data(:,1)];
            p2 = [p2 data(:,2)];
            p3 = [p3 data(:,3)];
            p4 = [p4 data(:,4)];
            p5 = [p5 data(:,5)];
            p6 = [p6 data(:,6)];
            p7 = [p7 lh];
            exitFl = [exitFl efl];
    end
end

if nrParam == 2
    outData = [p1;p2;p3];
elseif nrParam == 3
    outData = [p1;p2;p3;p4];    
elseif nrParam == 4
    outData = [p1;p2;p3;p4;p5];
elseif nrParam == 5
    outData = [p1;p2;p3;p4;p5;p6];
elseif nrParam == 6
    outData = [p1;p2;p3;p4;p5;p6;p7];
end


if sRun ~=0
    filename = [ outputFile,'M',num2str(nrParam-1),num2str(choiceRule),'_',...
    trialArr{trialsq},'_',num2str(sRun),'.csv' ];
    filename1 = [ outputFile,'M',num2str(nrParam-1),num2str(choiceRule),'_',...
    trialArr{trialsq},'_',num2str(sRun),'_exit.csv' ];
else
    filename = [ outputFile,'M',num2str(nrParam-1),num2str(choiceRule),'_',...
    trialArr{trialsq},'.csv' ];
    filename1 = [ outputFile,'M',num2str(nrParam-1),num2str(choiceRule),'_',...
    trialArr{trialsq},'_exit.csv' ];
end
csvwrite(filename1,exitFl);
csvwrite(filename,outData);
disp(nrParam-1);