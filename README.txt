We used a 5-way-cross-validation to test our algorithms.

go_adaboost.m	84%	Vectorization of text reviews: Histogram.
						An adaboost algorithm with 700 iterations, where the weak classifier is "whether a given word exists in the text".
						(An attempt has been made to count sentences with negation words as negative words - that is, reducing from the
						histogram instead of increasing - but it didn't go well).

go_mi_svm.m	88%	Vectorization of text reviews: Bag of words.
						An svm algotithem, with feature selection of 2000 words with the most mutual information.

go_mi_pca_svm.m	87%	Vectorization of text reviews: Bag of words.
						An svm algorithem, working on 500 principal components of 1500 words with the most mutual information.


Feature selection - Mutual Information: An information theoretic definition - the information (can be interpreted as the number of bits) of the info one r.v. gives on anoter r.v. . We use this to mesure the MI between the r.v.s of "does the review contain a word" to the r.v. "the text is a positive review". The words with the most mutual information are chosen to reduce noise of word which contain very little information.

Feature selection - Frequency: We mesure the frequency of a word in the texts, and use it in the classifier iff it appears often (1% or more, for example).
