function [ f ] = create_poly_dist( line_segments )
%CREATE_DISTANCE_TO_POLYGON Summary of this function goes here
%   Detailed explanation goes here
    
    f = @distance_to_polygon;
    
    function [ distance_squared ] = distance_to_polygon(point)
        %DISTANCE_TO_POLYGON Summary of this function goes here
        %   Detailed explanation goes here
        
        distances = arrayfun(@(i) distance_to_segment_sq(point, line_segments(:, i)), 1:size(line_segments, 2));
        distance_squared = min(distances);
    end
end

