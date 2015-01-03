function Q = model22(param, outcome, choice, qValue)

alpha = param(1); 
beta = param(3);
options=size(outcome,2);
Q=zeros(1, options);

% Call learning learning rule
for o = 1 : options
  if outcome(o) == 1
    Q(o) = alpha * outcome(o) + (1 - alpha) * qValue(o);
  else 
    Q(o) = alpha * beta*outcome(o) + (1 - alpha*beta) * qValue(o);
  end
end