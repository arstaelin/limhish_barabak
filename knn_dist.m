function [dists] = knn_dist(ZI, ZJ)
  dists = zeros(size(ZJ, 1), 1);
  for i:size(ZJ, 1)
    dists(i) = (size(intersect(ZI(1,3:end), ZJ(i,3:end),2) - 1) / (ZJ(i,2));
  end
end
