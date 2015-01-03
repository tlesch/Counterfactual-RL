function Q = model32(param, outcome, choice, qValue)

%calculate q value for each options using the 4 parameter model
alpha = param(1); 
gamma = param(3);
delta = param(4);
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
    if choice(o) == 1
        Q(o) = alpha * outcome(o) + (1 - alpha) * qValue(o);
    else 
    	if choiceWon == 0
        	Q(o) = alpha * gamma * outcome(o) + (1 - alpha * gamma) * qValue(o);
    	else
	        Q(o) = alpha * gamma * delta * outcome(o) + (1 - alpha * gamma * delta) * qValue(o);
	    end
    end
end