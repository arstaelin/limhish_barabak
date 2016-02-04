function [classes] = knn_class_param(moedl, data, k):
  classes = zeros(sizeof(data, 1), 1);
  for i = 1:sizeof(data, 1)
    classes[i] = knn_class_param_single(model, data(i), k);
  end
end
