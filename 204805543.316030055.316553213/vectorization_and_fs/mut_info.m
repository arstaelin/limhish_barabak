function [ words, mi ] = mut_info( vectors, labels, dict )
%NUT_INFO Summary of this function goes here
%   Detailed explanation goes here

maxx = 0;
s = size(vectors, 1);

mi = zeros(size(dict, 1), 1);

for i = 1:s
    vectors{i} = unique(vectors{i});
    if (size(vectors{i},2) > maxx)
    maxx = size(vectors{i},2);
    end
end

revs = zeros(s, maxx) - 1;

for i = 1:s
    revs(i, 1:size(vectors{i}, 2)) = vectors{i};
end

i = 1;
for w = dict
    t = revs( labels == -1, :) == w;
    n10 = sum ( t(:) );
    t = revs( labels == 1, :) == w;
    n11 = sum ( t(:) );
    n00 = sum(labels == -1) - n10;
    n01 = sum(labels == 1) - n11;
    n1b = n10 + n11;
    n0b = n00 + n01;
    nb1 = n01 + n11;
    nb0 = n00 + n10;
    n = n1b + n0b;
    if (n1b*nb1 ~= 0)
        p1 = n11 * log2(n*n11/(n1b*nb1));
    else
        p1 = 0;
    end
    if (n0b*nb1 ~= 0)
        p2 =  n01 * log2(n*n01/(n0b*nb1));
    else
        p2 = 0;
    end
    if (n1b*nb0 ~= 0)
        p3 = n10 * log2(n*n10/(n1b*nb0));
    else
        p3 = 0;
    end
    if (nb0*n0b ~= 0)
        p4 = n00 * log2(n*n00/(nb0*n0b));
    else
        p4 = 0;
    end
    mi(i) = (p1+p2+p3+p4)/n;
    i = i + 1;
    if (mod(i, 100) == 0)
        disp(i);
    end
end

words = dict;

end

