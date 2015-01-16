function [] = run_everything_simul()


%runAllSubjects_Simul( choiceFile, outcomeFile, ...
%   startFile, outputFile, choiceRule)

runAllSubjects_Simul('output/simul/Simul_M4',...
	'input/outcomes_1.csv',...
    'input/startValues_1.csv',...
	'output/simul/Simul_',1);

runAllSubjects_Simul('output/simul/Simul_M4',...
	'input/outcomes_1.csv',...
    'input/startValues_2.csv',...
	'output/simul/Simul_',1);

runAllSubjects_Simul('output/simul/Simul_M4',...
	'input/outcomes_1.csv',...
    'input/startValues_2.csv',...
	'output/simul/Simul_',2);

runAllSubjects_Simul('output/simul/Simul_M4',...
	'input/outcomes_1.csv',...
    'input/startValues_2.csv',...
	'output/simul/Simul_',3);

runAllSubjects_Simul('output/simul/Simul_M4',...
	'input/outcomes_1.csv',...
    'input/startValues_3.csv',...
	'output/simul/Simul_',1);

runAllSubjects_Simul('output/simul/Simul_M4',...
	'input/outcomes_1.csv',...
    'input/startValues_3.csv',...
	'output/simul/Simul_',2);

runAllSubjects_Simul('output/simul/Simul_M4',...
	'input/outcomes_1.csv',...
    'input/startValues_3.csv',...
	'output/simul/Simul_',3);

runAllSubjects_Simul('output/simul/Simul_M4',...
	'input/outcomes_1.csv',...
    'input/startValues_4.csv',...
	'output/simul/Simul_',1);