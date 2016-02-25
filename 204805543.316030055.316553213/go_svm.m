function go_svm (directory) 
    set_env
	load('svm_model');
	run_classifier( directory, svm_model, @vector_basic, @svm_test);
end
