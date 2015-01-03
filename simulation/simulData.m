function runs = simulData(param, outcome, nrIt,choiceRule)

nrParam = size(param, 2);
trials = size(outcome,1);
options=size(outcome,2);
Q=zeros(trials, options);
probs=zeros(trials, options);

runs = zeros(trials,options,nrIt);
temp = param(2);

% Call learning learning rule
if (nrParam == 2 && choiceRule == 1)
    for i = 1 : nrIt
        for o = 1:options
            Q(1,o) = 0;  %initialize Qs for the first trial as 0
            probs(1,o)=1/options;
            runs(1,:,i)=genChoices(probs(1,:));
        end
        for j = 2 : trials 
            % calculate Q values based on parameters
            Q(j,:)=model1(param, outcome(j-1,:)); %,runs(j-1,:,i),Q(j-1,:)
            probs(j,:)=softmax(Q(j,:), temp);  %softmax to calculate probabilities
            runs(j,:,i)=genChoices(probs(j,:)); %generate choices
        end
    end
elseif (nrParam == 3 && choiceRule == 1)
    for i = 1: nrIt
        for o = 1:options
            Q(1,o) = 0;
            probs(1,o)=1/options;
            runs(1,:,i)=genChoices(probs(1,:));
        end
        for j = 2 : trials 
            Q(j,:)=model2(param, outcome(j-1,:),runs(j-1,:,i),Q(j-1,:));
            probs(j,:)=softmax(Q(j,:), temp);
            runs(j,:,i)=genChoices(probs(j,:));
        end
    end
elseif (nrParam == 4 && choiceRule == 1)
    for i = 1: nrIt
        for o = 1:options
            Q(1,o) = 0;
            probs(1,o)=1/options;
            runs(1,:,i)=genChoices(probs(1,:));
        end
        for j = 2 : trials 
            Q(j,:)=model3(param, outcome(j-1,:),runs(j-1,:,i),Q(j-1,:));
            probs(j,:)=softmax(Q(j,:), temp);
            runs(j,:,i)=genChoices(probs(j,:));
        end
    end
elseif (nrParam == 5 && choiceRule == 1)
    for i = 1: nrIt
        for o = 1:options
            Q(1,o) = 0;
            probs(1,o)=1/options;
            runs(1,:,i)=genChoices(probs(1,:));
        end
        for j = 2 : trials 
            Q(j,:)=model4(param, outcome(j-1,:),runs(j-1,:,i),Q(j-1,:));
            probs(j,:)=softmax(Q(j,:), temp);
            runs(j,:,i)=genChoices(probs(j,:));
        end
    end

elseif (nrParam == 3 && choiceRule == 2)
    for i = 1: nrIt
        for o = 1:options
            Q(1,o) = 0;
            probs(1,o)=1/options;
            runs(1,:,i)=genChoices(probs(1,:));
        end
        for j = 2 : trials 
            Q(j,:)=model22(param, outcome(j-1,:),runs(j-1,:,i),Q(j-1,:));
            probs(j,:)=softmax(Q(j,:), temp);
            runs(j,:,i)=genChoices(probs(j,:));
        end
    end
elseif (nrParam == 3 && choiceRule == 3)
    for i = 1: nrIt
        for o = 1:options
            Q(1,o) = 0;
            probs(1,o)=1/options;
            runs(1,:,i)=genChoices(probs(1,:));
        end
        for j = 2 : trials 
            Q(j,:)=model23(param, outcome(j-1,:),runs(j-1,:,i),Q(j-1,:));
            probs(j,:)=softmax(Q(j,:), temp);
            runs(j,:,i)=genChoices(probs(j,:));
        end
    end
elseif (nrParam == 4 && choiceRule == 2)
    for i = 1: nrIt
        for o = 1:options
            Q(1,o) = 0;
            probs(1,o)=1/options;
            runs(1,:,i)=genChoices(probs(1,:));
        end
        for j = 2 : trials 
            Q(j,:)=model32(param, outcome(j-1,:),runs(j-1,:,i),Q(j-1,:));
            probs(j,:)=softmax(Q(j,:), temp);
            runs(j,:,i)=genChoices(probs(j,:));
        end
    end
elseif (nrParam == 4 && choiceRule == 3)
    for i = 1: nrIt
        for o = 1:options
            Q(1,o) = 0;
            probs(1,o)=1/options;
            runs(1,:,i)=genChoices(probs(1,:));
        end
        for j = 2 : trials 
            Q(j,:)=model33(param, outcome(j-1,:),runs(j-1,:,i),Q(j-1,:));
            probs(j,:)=softmax(Q(j,:), temp);
            runs(j,:,i)=genChoices(probs(j,:));
        end
    end
end
