Counterfactual-RL
=================

Rescorla-Wagner adapted for counterfactuals

The following code implements the Maximum Likelihood Estimation (MLE) for an adapted q-Learning Reinforcement Learning models as well as a simulations and model recovery procedure in matlab.


1. MLE (See folder Optimisation)

The current code models a four-alternative-choice situations and update an agents belief about the value of each alternative according to following formula. The choice is modelled following a softmax rule with temperature τ :


Learning Rule: 
	For alternative i: Qi(t+1)=α*γ*β*δ*Oi(t)+(1-α*γ*β*δ)*Qi(t) (Full Model)

	• Trial t ε {1,2,…,220}, stimulus i ε {1,2,3,4}
	• Outcome stimulus i on trial t: Oi(t) ε {0,1}
	• Expected value Qi for option i on trial t: Qi(t)
	• α always between 0 and 1, 
	• γ = 1 if i=j (i.e. selected), free otherwise, 
	• β=1 if Oi(t)=1, free otherwise, and 
	• δ=1 if i=j or if i≠j and Oj(t)=0 (i.e. selected or did not win), free otherwise.

Choice Rule: 
	P_i(t+1)= (exp⁡(Q_i(t)*τ))/(∑(k=1 to 4) exp⁡(Q_k(t)*τ)) 
	0<τ<21.4876 (Computational constraint)

Explanation Files:
	• IndOpt.m : implementation of optimisation for one subject
	• mod1.m : Model 1: only learning rate α (q-learning Modell)
	• mod2.m :  Model 2a: learning rate α and γ
	• mod3.m : Model 3a: learning rate α, γ and β
	• mod4.m : Model 4: learning rate α, γ, β and δ (Full Model)
	• mod22.m : Model 2b: learning rate α and β
	• mod23.m : Model 2b: learning rate α and δ
	• mod32.m : Model 3b: learning rate α, γ and δ
	• mod33.m : Model bc: learning rate α, β and δ
	• run_everything_simul.m : run optimisation for all models based on simulated behavioural data
	• run_everything.m :  run optimisation for all models using real data
	• runAllSubjects_Simul.m : run optimisation for all subjects based on simulated behavioural data
	• runAllSubjects.m : run optimisation for all subject in subject file
	• softmax.m : Softmax Choice Rule with temperature τ

Necessary inputs (to indicate on run_everything.m)
	• choiceFile: file with agent’s choices: 1 = chosen, 0 = no chosen
	• outcomeFile: file with alternatives’s outcomes: 1 = win, 0 = no win
	• startFile: start values for MLE using fmincon
	• subFile: list with subject IDs
	• outputFile: location and filename of output file
	• choiceRule: 1 for Models 1 and 4; 1, 2 or 3 for Models 2 and 3
