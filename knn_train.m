function [model] = knn_train(data, lables)
  di = 1;
  max = 0;
  for i=1:size(data, 1)
    if size(data{i, 1}, di) > max
      max = size(data{i, 1}, di);
    end
  end
  max = max + 3;
  model = -ones(size(data, 1), max);
  model(:,1) = lables;
  for i=1:size(data, 1)
    model(i, 2) = size(data{i, 1}, di);
    model(i, 3:size(data{i, 1}, di)+2) = data{i, 1}; %maybe transposed, or taking only the row or colomn
  end
end
