function [] = runAllSubjects( choiceFile, outcomeFile, ...
    startFile,subFile, outputFile,choiceRule)

%function to run optimization for all subject at once
outcome = csvread(outcomeFile);
choice = csvread(choiceFile);
startValues = csvread(startFile); % alpha, temp, gamma, beta, delta, epsilon
subName = csvread(subFile);
subjects = size(subName,1);
options = size(outcome,2)/subjects;
nrParam = size(startValues,2);

%run for all subject


tStart = 1;
tEnd = size(outcome,1);

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


filename = [ outputFile,'M',num2str(nrParam-1),num2str(choiceRule),'.csv' ];
filename1 = [ outputFile,'M',num2str(nrParam-1),num2str(choiceRule),'_exit.csv' ];
csvwrite(filename1,exitFl);
csvwrite(filename,outData);
disp(nrParam-1);