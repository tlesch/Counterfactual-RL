function Q = genQValue(param, outcome, choice, choiceRule)

nrParam = size(param, 2);
trials = size(outcome,1);
options=size(outcome,2);
Q=zeros(trials, options);

temp = param(2);

% Call learning learning rule
if (nrParam == 2 && choiceRule == 1)
    for o = 1:options
        Q(1,o) = 0;  %initialize Qs for the first trial as 0
    end
    for j = 2 : trials 
        % calculate Q values based on parameters
        Q(j,:)=model2P(param, outcome(j-1,:));
    end
elseif (nrParam == 3 && choiceRule == 1)
    for o = 1:options
        Q(1,o) = 0;
    end
    for j = 2 : trials 
        Q(j,:)=model3P(param, outcome(j-1,:),choice(j-1,:),Q(j-1,:));
    end
elseif (nrParam == 4 && choiceRule == 1)
    for o = 1:options
        Q(1,o) = 0;
    end
    for j = 2 : trials 
        Q(j,:)=model4P(param, outcome(j-1,:),choice(j-1,:),Q(j-1,:));
    end
elseif (nrParam == 5 && choiceRule == 1)
    for o = 1:options
        Q(1,o) = 0;
    end
    for j = 2 : trials 
        Q(j,:)=model5P(param, outcome(j-1,:),choice(j-1,:),Q(j-1,:));
    end
elseif (nrParam == 3 && choiceRule == 2)
epsilon = param (3);
    for o = 1:options
        Q(1,o) = 0;
    end
    for j = 2 : trials 
        Q(j,:)=model2P(param, outcome(j-1,:));
    end
elseif (nrParam == 4 && choiceRule == 2)
epsilon = param (4);
    for o = 1:options
        Q(1,o) = 0;
    end
    for j = 2 : trials 
        Q(j,:)=model3P(param, outcome(j-1,:),choice(j-1,:),Q(j-1,:));
    end
elseif (nrParam == 5 && choiceRule == 2)
epsilon = param (5);
    for o = 1:options
        Q(1,o) = 0;
    end
    for j = 2 : trials 
        Q(j,:)=model4P(param, outcome(j-1,:),choice(j-1,:),Q(j-1,:));
    end
elseif (nrParam == 6 && choiceRule == 1)
epsilon = param (6);
    for o = 1:options
        Q(1,o) = 0;
    end
    for j = 2 : trials 
        Q(j,:)=model5P(param, outcome(j-1,:),choice(j-1,:),Q(j-1,:));
    end
end
