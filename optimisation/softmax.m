function probs = softmax(Q, temp)
%softmax  probability evaluation based on action values
%
%   P = softmax(actionValues, b)
%   returns the array of probabilities P given action values and
%       exploration parameter b.
%       the value of exploration parameter should be bigger than 0 and smaller
%       than 1.
%

% the number of trials and options
options=size(Q,2);
trials=size(Q,1);
expP = exp(Q*temp);
sumP = sum(expP,2);
probs=zeros(trials,options);

for i = 1 : trials
    for j = 1 : options
        probs(i,j) = expP(i,j) / sumP(i);
    end
end
