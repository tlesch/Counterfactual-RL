function LH = mod32(startValues, choice, outcome)

alpha = startValues(1); 
temp = startValues(2);
gamma = startValues(3);
delta = startValues(4);

trials = size(outcome,1);
options=size(outcome,2);
Q=zeros(trials, options);

%initialize Qs for the first trial as 0
for o = 1:options
    Q(1,o) = 0;
end

% Call learning learning rule
for t = 1 : (trials-1)
    for o = 1 : options
        if choice(t,o) == 1
            choiceWon=o;
        else
            choiceWon=0;
        end
    end
    for o = 1 : options
        if choice(t,o) == 1
            Q(t+1,o) = alpha * outcome(t,o) + (1 - alpha) * Q(t,o);
        else
            if choiceWon == 0
                Q(t+1,o) = alpha * gamma * outcome(t,o) +...
                    (1 - alpha * gamma) * Q(t,o);
            else        
                Q(t+1,o) = alpha * gamma  * delta * outcome(t,o) +...
                    (1 - alpha * gamma *  delta) * Q(t,o);
            end
        end
    end
end

% Call softmax Softmax rule
P = softmax(Q, temp);

% To calculate likelihood:
Pf = 10 * choice .* P;
nonzeros = find(Pf ~= 0);
Pf = Pf(nonzeros);
LH = -1 * prod(Pf,1);