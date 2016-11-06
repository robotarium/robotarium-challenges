function [ distance_squared ] = distance_to_segment_sq(point, line)
%DISTANCE_TO_SEGMENT Returns the squared distance from a point to a line segment

    % Let's say that line goes [v ; w]
    
    line_length = (line(1:2) - line(3:4));
    line_length = line_length'*line_length;
    
    s = @(x) line(1:2) + x*(line(3:4) - line(1:2));
    
    if(line_length == 0)
       distance_squared = point - line(1:2);
       distance_squared = dot(distance_squared, distance_squared);
       return
    end
    
    % Otherwise, line is not of length 0
    t = dot(point - line(1:2), line(3:4) - line(1:2))/line_length;
    t = min(max(t, 0), 1);
    
    distance_squared = s(t) - point;
    distance_squared = dot(distance_squared, distance_squared);
end

