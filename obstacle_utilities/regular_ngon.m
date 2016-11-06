function [ line_segments, points ] = regular_ngon(varargin)
%GENERATE_POLYGON Returns a polygon.  You shouldn't have to use this
%function.

    % Parse inputs
    p = inputParser;
    addOptional(p, 'NumFaces', 4);
    addOptional(p, 'Scale', 0.07); 
    addOptional(p, 'XPosition', 0);
    addOptional(p, 'YPosition', 0); 
    addOptional(p, 'Rotation', 0);
    parse(p, varargin{:});    
    
    scale = p.Results.Scale;
    num_faces = p.Results.NumFaces;
    x_shift = p.Results.XPosition; 
    y_shift = p.Results.YPosition;
    theta = p.Results.Rotation;

    % Generate an n-gon with upper left @ [0 ; 0]
      
    points = zeros(2, num_faces+1);
    
    t = linspace(0,1,num_faces+1);
    points(1, :) = -cos(t.*2*pi);
    points(2, :) = -sin(t.*2*pi);        
    
    % Get rotation matrix 
    R = [cos(theta) -sin(theta) ; sin(theta) cos(theta)];
    
    % Rotate points around origin of obstacle
    for i = 1:size(points, 2)
       points(:, i) = R*points(:, i); 
    end
    
    % Shift points 
    points(1, :) = points(1, :) + x_shift;
    points(2, :) = points(2, :) + y_shift;
    
    % Scale points 
    points = points * scale;
    
    % Initialize line segments matrix
    line_segments = zeros(4, num_faces);
    prev_point = points(:, 1);        
    
    % Go through the faces, generating line segments.  We also do the
    % rotation of the polygon here.
    for i = circshift(1:num_faces, -1, 2)
       cur_segment = zeros(4, 1);
       cur_segment(1:2) = prev_point; 
       cur_segment(3:4) = points(:, i);
       line_segments(:, i) = cur_segment;
       prev_point = points(:, i);
    end    
end

