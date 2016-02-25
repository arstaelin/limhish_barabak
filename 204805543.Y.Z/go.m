function go (directory) 
    set_env
	load('svm_with_params_model');
	run_classifier( directory, svm_with_params_model, @vector_basic, @svm_test);
end