
% Goal position 

start = [-0.4 ; 0 ; 0];
goal = [0.4 ; 0];

% Number of obstacles 
num_obstacles = 3; 
obstacles = cell(1, num_obstacles);

% Obstacles type = ngon 
num_faces = 5;

x_position_shift = rand();
y_position_shift = rand()/2;

% Generate obstacles 
obstacles{1} = regular_ngon(num_faces, 'Xposition', -2.1 + x_position_shift);
obstacles{2} = regular_ngon(num_faces, 'XPosition', 2+x_position_shift, 'Rotation', 1, 'YPosition', 2 - y_position_shift);
obstacles{3} = regular_ngon(num_faces, 'XPosition', 2-x_position_shift, 'Rotation', 1, 'YPosition', -2 + y_position_shift);

