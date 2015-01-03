function Q = model33(param, outcome, choice, qValue)

%calculate q value for each options using the 4 parameter model
alpha = param(1); 
beta = param(3);
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
    if choice(o) == 1 && outcome(o) == 1
        Q(o) = alpha * outcome(o) + (1 - alpha) * qValue(o);
    elseif choice(o) == 0 && outcome(o) == 0
        Q(o) = alpha * beta * outcome(o) + (1 - alpha * beta) * qValue(o);
    elseif choice(o) == 0
    	if choiceWon== 0
    		if outcome(o) == 1
    			Q(o) = alpha * outcome(o) + (1 - alpha) * qValue(o);
    		else
    			Q(o) = alpha * beta * outcome(o) + (1 - alpha * beta) * qValue(o);
    		end
    	else
    		if outcome(o) == 1
    			Q(o) = alpha * delta * outcome(o) + (1 - alpha * delta) * qValue(o);
    		else
    			Q(o) = alpha * beta * delta * outcome(o) + (1 - alpha * beta * delta) * qValue(o);
    		end
    	end
    end
end