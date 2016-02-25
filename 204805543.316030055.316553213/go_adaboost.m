function go_adaboost (directory) 
	addpath('adaboost', 'help_funcs');
	load('model_adaboost.mat', 'model');
	run_classifier( directory, model, @map_freq, @adaboost_test);
end