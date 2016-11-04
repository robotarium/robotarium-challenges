%% Aerospace Hackathon Skeleton
% by Paul Glotfelter 
% 3/24/2016

%% Set up Robotarium object 
% Before starting the algorithm, we need to initialize the Robotarium
% object so that we can communicate with the agents

% Get Robotarium object used to communicate with the robots/simulator
rb = RobotariumBuilder();

% Get the number of available agents from the Robotarium.  We don't need a
% specific value for this algorithm
N = 1;

% Set the number of agents and whether we would like to save data.  Then,
% build the Robotarium simulator object!
r = rb.set_number_of_agents(N).set_save_data(false).build();

% This is a totally arbitrary number
iterations = 10000;

%% Experiment constants 
% Next, we set up some experiment constants

% Initialize velocity vector for agents.  Each agent expects a 2 x 1
% velocity vector containing the linear and angular velocity, respectively.
dx = zeros(2, N);

handle = r.figure_handle;

figure(handle.Number)
hold on 
for obstacle = obstacles
    patch(obstacle{1}(1, :), obstacle{1}(2, :), [0.5 0.1 0.7]);
end
hold off

%% Retrieve tools for single-integrator -> unicycle mapping

% Let's retrieve some of the tools we'll need.  We would like a
% single-integrator position controller, a single-integrator barrier
% function, and a mapping from single-integrator to unicycle dynamics
position_int = create_si_position_controller('XVelocityGain', 1, 'YVelocityGain', 1);
si_barrier_certificate = create_si_barrier_certificate('SafetyRadius', 0.1);
%si_to_uni_dyn = create_si_to_uni_mapping2('LinearVelocityGain', 0.75, 'AngularVelocityLimit', pi);
[si_to_uni_dyn, uni_to_si_states] = create_si_to_uni_mapping('ProjectionDistance', 0.05);
%% Begin the experiment
% This section contains the actual implementation of the barrier
% certificate experiment.

%Iterate for the previously specified number of iterations
for t = 1:iterations

    % Retrieve the most recent poses from the Robotarium.  The time delay is
    % approximately 0.033 seconds
    x = r.get_poses();

    x_temp = x(1:2,:);
    
    %% Algorithm
  
    % Let's make sure we're close enough to the goals
    if norm(goal-x_temp,1)<0.05
         break
    end
            
    % Use a single-integrator position controller to drive the agents to
    % the circular formation
    dx = position_int(x(1:2, :), goal);
    
    %%% Put your code here to avoid the obstacles!  Or you can modify
    %%% everything here...
   
    % Transform the single-integrator dynamics to unicycle dynamics using a
    % diffeomorphism, which can be found in the utilities
    dx = si_to_uni_dyn(dx, x);    
    
    %% Set the velocities of the agents
    
    % Set velocities of agents 1,...,N
    r.set_velocities(1:N, dx);
    
    % Send the previously set velocities to the agents.  This function must be called!
    r.step();    
end

% Though we didn't save any data, we still should call r.call_at_scripts_end() after our
% experiment is over!
r.call_at_scripts_end();

