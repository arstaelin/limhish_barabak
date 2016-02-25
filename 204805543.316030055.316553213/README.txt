We used a 5-way-cross-validation to test our algorithms.

go_adaboost.m	84%	Vectorization of text reviews: Histogram.
						An adaboost algorithm with 700 iterations, where the weak classifier is "whether a given word exists in the text".
						(An attempt has been made to count sentences with negation words as negative words - that is, reducing from the
						histogram instead of increasing - but it didn't go well).

go_mi_svm.m	88%	Vectorization of text reviews: Bag of words.
						An svm algotithem, with feature selection of 2000 words with the most mutual information.

go_mi_pca_svm.m	87%	Vectorization of text reviews: Bag of words.
						An svm algorithem, working on 500 principal components of 1500 words with the most mutual information.
