Counterfactual-RL
=================

Rescorla-Wagner adapted for counterfactuals

The following code implements the Maximum Likelihood Estimation (MLE) for an adapted q-Learning Reinforcement Learning model as well as a simulations and model recovery procedure in matlab.


Code for formatting etc. can be found here: 
http://nbviewer.ipython.org/github/tlesch/Counterfactual-RL/blob/master/Calculations.ipynb


1. MLE (See folder “Optimisation”)

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
	• run_everything.m :  run optimisation for all models using real data
	• runAllSubjects.m : run optimisation for all subject in subject file
	• IndOpt.m : implementation of optimisation for one subject

	• mod1.m : Model 1: only learning rate α (q-learning Modell)
	• mod2.m :  Model 2a: learning rate α and γ
	• mod3.m : Model 3a: learning rate α, γ and β
	• mod4.m : Model 4: learning rate α, γ, β and δ (Full Model)
	• mod22.m : Model 2b: learning rate α and β
	• mod23.m : Model 2b: learning rate α and δ
	• mod32.m : Model 3b: learning rate α, γ and δ
	• mod33.m : Model bc: learning rate α, β and δ
	• softmax.m : Softmax Choice Rule with temperature τ


Necessary inputs (to indicate on run_everything.m)
	• choiceFile: file with agent’s choices: 1 = chosen, 0 = no chosen
	• outcomeFile: file with alternatives’s outcomes: 1 = win, 0 = no win
	• startFile: start values for MLE using fmincon
	• subFile: list with subject IDs
	• outputFile: location and filename of output file
	• choiceRule: 1 for Models 1 and 4; 1, 2 or 3 for Models 2 and 3

2. Simulation (See folder “Simulation”)

During the simulation, each subject’s parameters are used to generate multiple datasets of choices per subjects (simulated subjects):

	• simul_everything.m : run simulation for all models
	• runSimul.m : run simulation for all subjects
	• simulData.m : run simulation for one subject 
	• genChoices.m : generate choice using the parameter values	• softmax.m : as before

Necessary inputs (to indicate on simul_everything.m):

	• parameterFile: file with model parameter per individual subject
	• outcomeFile: file with alternatives’s outcomes (real): 1 = win, 0 = no win
	• outputFile: location and filename of output file
	• nrIt: number of simulation per individual real subject
	• choiceRule: 1 for Models 1 and 4; 1, 2 or 3 for Models 2 and 3

3. Parameter Recovery (See folder “Optimisation”)

To confirm the model’s validity the simulated choice data is used to recover the parameter values that were used to simulated the data. In order to do so, the MLE optimisation procedure (see 1.) is repeated for each subject and simulation (and model). The currently depicted code, models how well each of the eight models can recover data generate using the full model (M4).

	• run_everything_simul.m : run optimisation for all models based on simulated behavioural data
	• runAllSubjects_Simul.m : run optimisation for all subjects based on simulated behavioural data


Necessary inputs (to indicate on run_everything_simul.m)
	• choiceFile: file with simulated agent’s choices: 1 = chosen, 0 = no chosen
	• outcomeFile: file with alternatives’s outcomes: 1 = win, 0 = no win
	• startFile: start values for MLE using fmincon
	• outputFile: location and filename of output file
	• choiceRule: 1 for Models 1 and 4; 1, 2 or 3 for Models 2 and 3