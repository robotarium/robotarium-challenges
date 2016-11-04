
% Goal position 

start = [-0.4 ; 0 ; 0];
goal = [0.4 ; 0];

% Number of obstacles 
num_obstacles = 1; 
obstacles = cell(num_obstacles, 1);

% Obstacles type = ngon 
num_faces = 5;

% Generate obstacles 
obstacles{1} = regular_ngon(num_faces);

