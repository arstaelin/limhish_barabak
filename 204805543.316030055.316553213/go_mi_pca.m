function go_mi_pca (directory) 
	load('model_mi_pca.mat', 'model_mi_pca');
	run_classifier( directory, model_mi_pca, @vector_basic, @svm_with_pca_test);
end
