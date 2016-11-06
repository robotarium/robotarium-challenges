clear all
close all

% constants 

distance_threshold_for_collision = 0.0254;
distance_threshold_for_goal = 0.08;

aero_local_path = pwd;

addpath(strcat(pwd, '/environments'))
addpath(strcat(pwd, '/obstacle_utilities'))

% Load obstacles
% run environment_one.m;
run environment_one.m

rb__ = RobotariumBuilder();
r__ = rb__.set_number_of_agents(1).set_save_data(false).build();

% Initialize robot to starting position

args = {'PositionError', 0.01, 'RotationError', 0.1};
init_checker = create_is_initialized(args{:});
automatic_parker = create_automatic_parking_controller(args{:});

x = r__.get_poses();
r__.step();
while(~init_checker(x, start))

    x = r__.get_poses();
    dxu = automatic_parker(x, start);  

    r__.set_velocities(1, dxu);
    r__.step();  
end

% Run & time user submission
tic
run main.m; 
elapsed = toc;

% Now we can load the robotarium data and test other stuff 

% Grab the robotarium data
data = what();
data = data.mat;
matches = regexp(data, 'robotarium_data{1}.*[.]{1}mat{1}');
matches = data(~cellfun(@isempty, matches));
file_path = matches{1};
load(file_path);

% robotarium_data is now a variable

% Reload obstacles
run environment_one.m

num_agents = size(robotarium_data, 1)/5;
num_data = size(robotarium_data, 2);

obstacle_violations = 0;

for i = 1:num_agents
    for j = 1:num_obstacles
        dist = create_poly_dist(obstacles{j});
        % Index into the right agent
        i_ = (i-1)*5 + 1;
        distances = ...
        arrayfun(@(x) dist(robotarium_data((i_:(i_+1)), x)), 1:num_data);
        obstacle_violations = obstacle_violations +  ... 
            numel(find(distances <= distance_threshold_for_collision^2));
    end
end

data = [];
data.elapsed = elapsed;
data.obstacle_violations = obstacle_violations;

if(norm(robotarium_data(1:2, end) - goal) <= distance_threshold_for_goal)
   data.made_it_to_goal = true; 
else
   data.made_it_to_goal = false; 
end

save(unique_filename('aero_challenge_one_data'), 'data')

display(sprintf('Elapsed time %0.1f s with %i violations', elapsed, obstacle_violations))








