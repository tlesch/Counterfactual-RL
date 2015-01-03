function Q = model3(param, outcome, choice, qValue)

%calculate q value for each options using the 4 parameter model
alpha = param(1); 
gamma = param(3);
beta = param(4);
options=size(outcome,2);
Q=zeros(1, options);

% Call learning learning rule
for o = 1 : options
    if choice(o) == 1 && outcome(o) == 1
        Q(o) = alpha * outcome(o) + (1 - alpha) * qValue(o);
    elseif choice(o) == 0 && outcome(o) == 1
        Q(o) = alpha * gamma * outcome(o) + (1 - alpha * gamma) * qValue(o);
    elseif choice(o) == 1 && outcome(o) == 0
        Q(o) = alpha * beta * outcome(o) + (1 - alpha * beta) * qValue(o);
    elseif choice(o) == 0 && outcome(o) == 0
        Q(o) = alpha * gamma * beta * outcome(o) + (1 - alpha * gamma* beta) * qValue(o);
    end
end