function go_adaboost (directory) 
	addpath('adaboost');
	load('model_adaboost.mat', 'model');
	run_classifier( directory, model, @map_freq, @adaboost_test);
end