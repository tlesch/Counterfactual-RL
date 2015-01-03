function choice = genChoices(probs)

%generate a vector with a choice for each trial
options=size(probs,2);
trials=size(probs,1);
choice=zeros(trials, options);
randNr = rand(1,trials);

%if trials > 1
for i = 1 : trials
    if randNr(i)<probs(i,1)
        choice(i,1)=1;
    elseif (randNr(i)>probs(i,1) && randNr(i)<sum(probs(1:2)))
        choice(i,2)=1;
    elseif (randNr(i)>sum(probs(1:2)) && randNr(i)<sum(probs(1:3)))
        choice(i,3)=1;
    elseif (randNr(i)>sum(probs(1:3)) && randNr(i)<sum(probs(1:4)))
        choice(i,4)=1;
    end    
end

%else 
%    sum1 = probs(1);
%    sum2 = sum1 + probs(2);
%    sum3 = sum2 + probs(3);
%    sum4 = sum3 + probs(4);
%    if randNr(1)<sum1;
%        choice(1)=1;
%    elseif randNr(1)>sum1 && randNr(1)<sum2
%        choice(2)=1;
%    elseif randNr(1)>sum2 && randNr(1)<sum3
%        choice(3)=1;
%    elseif randNr(1)>sum3 && randNr(1)<sum4
%        choice(4)=1;
%    end    
%end
%disp(decision(:,1));
%disp(size(decision,1));
%disp(size(decision,2));
%csvwrite('decision2.csv',decision);