function go_naive_bayes (directory) 
    set_env
	load('nb_model');
	run_classifier( directory, nb_model, @vector_basic, @nb_test);
end
