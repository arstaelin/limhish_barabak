function [classes] = knn_class_param(model, data, k)
  data = knn_train(data, zeros(size(data, 1), 1));
  distances = pdist2(data, model, @knn_dist);
  [~, ind] = sort(distances, 2);
  ind = ind(:,1:k);
  classes = reshape(model(ind,2), size(ind, 1), k);
  classes = mode(classes, 2);
end
