function LH = mod4(startValues, choice, outcome)

alpha = startValues(1); 
temp = startValues(2);
gamma = startValues(3);
beta = startValues(4);
delta = startValues(5);

trials = size(outcome,1);
options=size(outcome,2);
Q=zeros(trials, options);

% Initialize Qs for the first trial as 0
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
            if outcome(t,o) == 1
                Q(t+1,o) = alpha * outcome(t,o) + (1 - alpha) * Q(t,o);
            else %choice(t,o) == 1 && outcome(t,o) == 0
                Q(t+1,o) = alpha * beta * outcome(t,o) + (1 - alpha * beta) * Q(t,o);
            end
        else %choice(t,o) == 0
            if choiceWon == 0
                if outcome(t,o)== 1
                    Q(t+1,o) = alpha * gamma * outcome(t,o) +...
                        (1 - alpha * gamma) * Q(t,o);
                else %outcome(t,o)== 0
                    Q(t+1,o) = alpha * gamma * beta * outcome(t,o) +...
                        (1 - alpha * gamma * beta) * Q(t,o);
                end
            else %choiceWon == 1
                if outcome(t,choiceWon) == 1
                    if outcome(t,o) == 1
                        Q(t+1,o) = alpha * gamma * delta * outcome(t,o) +...
                            (1 - alpha * gamma *  delta) * Q(t,o);
                    else
                        Q(t+1,o) = alpha * gamma * beta * delta * outcome(t,o) +...
                            (1 - alpha * gamma * beta * delta) * Q(t,o);
                    end
                else % outcome(t,choiceWon) == 0
                    if outcome(t,o) == 1
                        Q(t+1,o) = alpha * gamma * outcome(t,o) +...
                            (1 - alpha * gamma) * Q(t,o);
                    else
                        Q(t+1,o) = alpha * gamma * beta * outcome(t,o) +...
                            (1 - alpha * gamma * beta) * Q(t,o);
                    end
                end
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