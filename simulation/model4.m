function Q = model4(param, outcome, choice, qValue)

%calculate q value for each options using the 4 parameter model
alpha = param(1); 
gamma = param(3);
beta = param(4);
delta = param(5);
options=size(outcome,2);
Q=zeros(1, options);

% Call learning learning rule
for o = 1 : options
    if choice(o)==1
        choiceWon=o;
    else
        choiceWon=0;
    end
end
for o = 1 : options
    if choice(o) == 1 && outcome(o) == 1
        Q(o) = alpha * outcome(o) + ...
    		(1 - alpha) * qValue(o);
    elseif choice(o) == 1 && outcome(o) == 0
        Q(o) = alpha * beta * outcome(o) + ...
        	(1 - alpha * beta) * qValue(o);
    elseif choice(o) == 0
        if choiceWon == 0
            if outcome(o)== 1
                Q(o) = alpha * gamma * outcome(o) +...
                    (1 - alpha * gamma) * qValue(o);
            else
                Q(o) = alpha * gamma * beta * outcome(o) +...
                    (1 - alpha * gamma * beta) * qValue(o);
            end
        elseif outcome(choiceWon) == 1
            if outcome(o) == 1
                Q(o) = alpha * gamma * delta * outcome(o) +...
                    (1 - alpha * gamma *  delta) * qValue(o);
            else
                Q(o) = alpha * gamma * beta * delta * outcome(o) +...
                    (1 - alpha * gamma * beta * delta) * qValue(o);
            end
        elseif outcome(choiceWon) == 0
            if outcome(o) == 1
                Q(o) = alpha * gamma * outcome(o) +...
                    (1 - alpha * gamma) * qValue(o);
            else
                Q(o) = alpha * gamma * beta * outcome(o) +...
                    (1 - alpha * gamma * beta) * qValue(o);
            end
        end
    end
end