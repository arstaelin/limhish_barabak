# This project is the Machine Learning project of:
# Alexander Ar-Staelin 204805543
# Nir Magrafta ???
# Orr Dermer 316553213

Attached are scripts for our machine learning algorithms. The algorithm we
chose to use in the final submission is svm trained on the bag of words
vector representation of the texts, using only words that appear in at
least 0.01 of all texts trained on. In addition, we optimized the svm
paramaters using the attached script 'svm-select'(**). Alternatives include
svm with more involved feature selection, adaboost and naive bayes
classifiers.

The accuracy for all algorithms was determined through 5-fold cross
validation using the supplied data. All svm algorithms used the gaussian
kernel.

go.m - [accuracy 88.6%] Description: Trained svm with optimized paramaters
            on the data. Uses a bag of words vectorization, and then
            filters all words that don't appear in at least 0.01 of texts.
            Parameter optimization was done using svm-select (**).

go_svm.m - [accuracy 85.4%] Description: Trained svm, without the parameter
            optimization. Same bag of words vectorization, with words that
            appear in at least 0.01 of texts.

go_adaboost.m - [accuracy 84%]	Description: Vectorization of text reviews
            was with histogram.	An adaboost algorithm with 700 iterations,
            where each weak classifier is "whether a given word appears in
            the text". (we attempted to also count sentences with negation
            words as negative valued words - that is, reducing from the
			histogram instead of increasing - but it actually reduced
            accuracy).

go_mi_svm.m - [accuracy 88%] Description: Vectorization of text reviews was
            with Bag of words. An svm algorithem was used, with optimized
            parameters as per (**). Features were selected by 2000 words
            with the most mutual information concerning the label vector.

go_mi_pca_svm.m - [accuracy 87%] Description: Vectorization of text reviews
            was again Bag of words. An svm algorithm with optimized
            parameters was again used. This time, using PCA to select the
            first 500 principal components, out of 1500 words with the most
            mutual information, concerning the label vector.

go_naive_bayes,m - [accuracy 83%] Description: Uses MatLab's built in naive
            bayes classifiers. Uses a bag of words, of all words that
            appear in at least 0.01 of all texts.


(**) svm-select is based on this paper:
http://sparc.nfu.edu.tw/~ijeti/download/V2-no2-113-125.pdf
and is based on the staelin method. It was written by Carl Staelin,
to be used to optimize the parameters of the libsvm classifier. Because of
the length of time required to optimize the parameters, we hard-coded the
resulting parameters into the algorithm for the training of the classifier.

