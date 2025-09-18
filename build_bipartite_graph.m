function Z = build_bipartite_graph(X, k, numanchors)
    n = size(X, 1);
    assert(numanchors < n);

    hn = log2(numanchors);
    [~, anchors] = hKM(X', 1:n, hn, 1);
    Z = ConstructA_NP(X', anchors, k);
end