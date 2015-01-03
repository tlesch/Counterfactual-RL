function [oneSubject LH exitFl] = IndOpt( choice, outcome, startValues, choiceRule)

runs = size(startValues,1);
param = size(startValues,2);
nrOptions = size(outcome,2);
%other algorithms: 'spq' or 'active-set'
options = optimset('Algorithm', 'interior-point','ObjectiveLimit',...
    -1.000000000e+300,'TolFun',1e-15, 'Display','off');

tmax = log(double(intmax)); %/nrOptions

%run optimization with 2 or 4 parameters and with different starting values
if (param == 2 && choiceRule == 1)
    A=[1 0;0 1;-1 0;0 -1];
    b=[1;tmax; 0; 0];
    for t = 1 : runs 
        [oneSubject(t,:) LH(t,:) exitFl(t,:)] = fmincon(@mod1,startValues(t,:),...
            A,b,[],[],[],[],[],options,choice,outcome);
    end
elseif (param == 3 && choiceRule == 1)
    A=[1 0 0;0 1 0; 0 0 1;-1 0 0;0 -1 0; 0 0 -1];
    b=[1;tmax;1; 0; 0;0];
    for t = 1 : runs 
        [oneSubject(t,:) LH(t,:) exitFl(t,:)] = fmincon(@mod2,startValues(t,:),...
            A,b,[],[],[],[],[],options,choice,outcome);
    end
elseif (param == 4 && choiceRule == 1)
    A=[1 0 0 0;0 1 0 0; 0 0 1 0;0 0 0 1;-1 0 0 0;0 -1 0 0; 0 0 -1 0; 0 0 0 -1];
    b=[1;tmax;1;1; 0; 0;0;0];
    for t = 1 : runs 
        [oneSubject(t,:) LH(t,:) exitFl(t,:)] = fmincon(@mod3,startValues(t,:),...
            A,b,[],[],[],[],[],options,choice,outcome);    
    end
elseif (param == 5 && choiceRule == 1)
    A=[1 0 0 0 0;0 1 0 0 0; 0 0 1 0 0;0 0 0 1 0; 0 0 0 0 1; ...
        -1 0 0 0 0;0 -1 0 0 0; 0 0 -1 0 0; 0 0 0 -1 0; 0 0 0 0 -1];
    b=[1;tmax;1;1;1;0;0;0;0;0];
    for t = 1 : runs 
        [oneSubject(t,:) LH(t,:) exitFl(t,:)] = fmincon(@mod4,startValues(t,:),...
            A,b,[],[],[],[],[],options,choice,outcome);    
    end    
elseif (param == 3 && choiceRule == 2)
    A=[1 0 0;0 1 0; 0 0 1;-1 0 0;0 -1 0; 0 0 -1];
    b=[1;tmax;1; 0; 0; 0];
    for t = 1 : runs 
        [oneSubject(t,:) LH(t,:) exitFl(t,:)] = fmincon(@mod22,startValues(t,:),...
            A,b,[],[],[],[],[],options,choice,outcome);
    end       
elseif (param == 3 && choiceRule == 3)
    A=[1 0 0;0 1 0; 0 0 1;-1 0 0;0 -1 0; 0 0 -1];
    b=[1;tmax;1; 0; 0; 0];
    for t = 1 : runs 
        [oneSubject(t,:) LH(t,:) exitFl(t,:)] = fmincon(@mod23,startValues(t,:),...
            A,b,[],[],[],[],[],options,choice,outcome);
    end
elseif (param == 4 && choiceRule == 2)
    A=[1 0 0 0;0 1 0 0; 0 0 1 0;0 0 0 1;-1 0 0 0;0 -1 0 0; 0 0 -1 0; 0 0 0 -1];
    b=[1;tmax;1;1; 0; 0; 0; 0];
    for t = 1 : runs 
        [oneSubject(t,:) LH(t,:) exitFl(t,:)] = fmincon(@mod32,startValues(t,:),...
            A,b,[],[],[],[],[],options,choice,outcome);    
    end
elseif (param == 4 && choiceRule == 3)
    A=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1; -1 0 0 0; 0 -1 0 0; 0 0 -1 0; 0 0 0 -1];
    b=[1;tmax;1;1; 0; 0; 0; 0];
    for t = 1 : runs 
        [oneSubject(t,:) LH(t,:) exitFl(t,:)] = fmincon(@mod33,startValues(t,:),...
            A,b,[],[],[],[],[],options,choice,outcome);    
    end 
else
    disp('Incorrect number of Parameter');
end