function nodeLabel = convert2node(UorV, x, y, ncols, nrows)  
% Convert U_label and V_label to node indices (in the A matrix)
%   input: 
%         UorV:  'u' if u node, 'v' if v node
%         x:     horizontal value
%         y:     vertical value
%         ncols: width of graph
%         nrows: height of graph
%   output: corresponding node label
%   For example a 2*3 graph can be converted into
%     u -->    1  2  3
%     u -->    4  5  6
%     v -->    7  8  9
%     v -->    10 11 12
%
    nodeLabel = (y - 1) * ncols + x;
    if UorV == 'v'
        nodeLabel = nodeLabel + ncols * nrows;
    end
end
