function [ f ] = create_poly_dist_der( line_segments )
%DERIVATIVE_OF_DISTANCE_TO_POLYGON Summary of this function goes here
%   Detailed explanation goes here

    N = size(line_segments, 2);
    ds = cell(N);

    for i = 1:N
       ds{i} = create_line_seg_der(line_segments(:, i)); 
    end
    
    f = @derivative;

    function [dp, dists] = derivative(point)
        distances = zeros(1, N);
                
        for i_ = 1:N          
            distances(i_) = distance_to_segment_sq(point, line_segments(:, i_));
        end
        
%         idxs = find(distances <= 0.05);
        [~, idx] = min(distances);
        
        temp_dist = distances; 
        temp_dist(idx) = inf;     
        
        [~, idx2] = min(temp_dist);
        
        idxs = [idx, idx2];

        dists = distances(idxs);
        
        % Return a set-valued derivative
        dp = zeros(length(idxs), 2);
        for i_ = 1:length(idxs)
            dp(i_, :) = ds{idxs(i_)}(point);
        end
    end
end

