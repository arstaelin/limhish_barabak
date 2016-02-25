function go_mi (directory) 
	set_env
	load('model_mi.mat', 'model_mi');
	run_classifier( directory, model_mi, @vector_basic, @svm_test);
end
