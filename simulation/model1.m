function Q = model1(param, outcome)

%calculate q value for each options using the 2 parameter model
alpha = param(1);
options=size(outcome,2);
Q=zeros(1, options);

% Call learning learning rule

for o = 1 : options
	Q(o) = alpha * outcome(o) + (1 - alpha) * Q(o); 
end