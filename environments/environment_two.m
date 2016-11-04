
% Goal position 

start = [-0.4 ; 0 ; 0];
goal = [0.4 ; 0];

% Number of obstacles 
num_obstacles = 3; 
obstacles = cell(1, num_obstacles);

% Obstacles type = ngon 
num_faces = 5;

% Generate obstacles 
obstacles{1} = regular_ngon(num_faces, 'Xposition', -2);
obstacles{2} = regular_ngon(num_faces, 'XPosition', 2, 'Rotation', 1, 'YPosition', 1.5);
obstacles{3} = regular_ngon(num_faces, 'XPosition', 2, 'Rotation', 1, 'YPosition', -1.5);

