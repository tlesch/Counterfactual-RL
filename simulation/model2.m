function Q = model2(param, outcome, choice, qValue)

alpha = param(1); 
gamma = param(3);
options=size(outcome,2);
Q=zeros(1, options);

% Call learning learning rule
for o = 1 : options
  if choice(o) == 1
    Q(o) = alpha * outcome(o) + (1 - alpha) * qValue(o);
  elseif choice(o) == 0 
    Q(o) = alpha * gamma*outcome(o) + (1 - alpha*gamma) * qValue(o);
  end
end