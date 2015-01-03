function Q = model23(param, outcome, choice, qValue)

alpha = param(1); 
delta = param(3);
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
    	Q(o) = alpha *outcome(o) + (1 - alpha) * qValue(o);
  	else
    	Q(o) = alpha *delta*outcome(o) + (1 - alpha*delta) * qValue(o);
  	end	
  end
end