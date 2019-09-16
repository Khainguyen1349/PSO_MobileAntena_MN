%% Initializing data
% Temporary data and simulation folders
mkdir hfss
mkdir data
tmpPrjFile    = [pwd, '\hfss\tmpMobile.aedt'];
tmpDataFile   = [pwd, '\data\tmpData.s2p'];
logFile = strcat(pwd, '\data\pso.log');
logLocationFile = strcat(pwd, '\data\pso_location.log');
logVelocityFile = strcat(pwd, '\data\pso_velocity.log');
logPbestFile = strcat(pwd, '\data\pso_pbest.log');
logGbestFile = strcat(pwd, '\data\pso_gbest.log');
logPfitnessFile = strcat(pwd, '\data\pso_pfitness.log');

log = fopen(logFile,'w');
log_location = fopen(logLocationFile,'w');
log_velocity = fopen(logVelocityFile,'w');
log_pbest = fopen(logPbestFile,'w');
log_gbest = fopen(logGbestFile,'w');
log_pfitness = fopen(logPfitnessFile,'w');

%Generate Matchfile for Optenni Lab
genMatch;
addpath(genpath(strcat(pwd,'\optenni')));
savepath;

%Add HFSS interface lib
addpath(genpath(strcat(pwd,'\hfss-api-master')));
savepath;

%% Parameters to change here
% General parameters of PSO are defined here:
w = 1; 
c1 = 1.49; %personal
c2 = 1.49; %global
max_iter = 100;% maximun number of iteration?
ConvergenceThreshold = 0.2;

% Set up frequency [Start Center Stop Steps]
freq = [6e8 9e8 3e9 121];

num_parameter = 3;
parameter1 = [0; 1]; %position 1 ratio
parameter2 = [0; 1]; %position 2 ratio
parameter3 = [0; 1]; %gap position

%% First step: Define the Solution Space
% a number of agents are assigned the task of looking for the best position in the
% Solution Space, the number of dimention of the space is the number of
% parameters
agent_quantity = 10;
space_dimention = num_parameter;

% Define boundary
[agent_bound, velocity_bound] = agent_bound_maker(parameter1, parameter2, parameter3);
fprintf(log,'Agent boundary: \n');
fprintf(log,[repmat('%f\t',1,size(agent_bound,2)) '\n'],agent_bound');

fprintf(log,'Velocity boundary: \n');
fprintf(log,[repmat('%f\t',1,size(velocity_bound,2)) '\n'],velocity_bound');

agent_pbest = zeros(agent_quantity, space_dimention);
agent_fitness = zeros(agent_quantity, 1);
pbest = zeros(agent_quantity, 1);

%% Second step: Generate Swam locations and velocities
rng(3);
rand_location = rand(agent_quantity,space_dimention);
agent_range_matrix = repmat(agent_bound(2,:) - agent_bound(1,:),agent_quantity,1);
agent_location = rand_location.*agent_range_matrix + ones(agent_quantity,1)*agent_bound(1,:);

rng(4);
rand_velocity = rand(agent_quantity,space_dimention);
velocity_range_matrix = repmat(velocity_bound(2,:) - velocity_bound(1,:),agent_quantity,1);
agent_velocity = rand_velocity.*velocity_range_matrix + ones(agent_quantity,1)*velocity_bound(1,:);

fprintf(log_location,'Initial locations:\n');
fprintf(log_location,[repmat('%f\t',1,size(agent_location,2)) '\n'],agent_location');
fprintf(log_velocity,'Initial velocities:\n');
fprintf(log_velocity,[repmat('%f\t',1,size(agent_location,2)) '\n'],agent_velocity');

%% Forth step: Evaluate each particale's fitness, comparing to gbest, pbest
fprintf(log_pfitness,'Initial:\n');
for i = 1:agent_quantity
    agent_fitness(i,1) = fitness_function(freq, agent_location(i,:),tmpPrjFile, tmpDataFile);
    if agent_fitness(i,1) > pbest(i,1)
        pbest(i,1) = agent_fitness(i,1);
        agent_pbest(i,:) = agent_location(i,:);
    end
end

fprintf(log_pfitness,[repmat('%f\t',1,size(agent_fitness',2)) '\n'],agent_fitness);
fprintf(log_pbest,'Initial personal bests:\n');
fprintf(log_pbest,[repmat('%f\t',1,size(agent_pbest,2)) '\n'],agent_pbest');
[gbest, gbest_position] = max(pbest);
fprintf(log_gbest,'Global best: %f ', gbest);
fprintf(log_gbest,'_ position: %f \n', gbest_position);

% Update particles' velocities
matrix_C1 = c1*rand(agent_quantity, space_dimention).*(agent_pbest - agent_location);
matrix_C2 = c2*rand(agent_quantity, space_dimention).*(ones(agent_quantity,1)*agent_pbest(gbest_position,:) - agent_location);
agent_velocity = w*agent_velocity +  matrix_C1 + matrix_C2;

% Check if the velocities are outside the boundary
for i = 1:agent_quantity
    for j = 1:space_dimention
        if agent_velocity(i,j) < velocity_bound(1,j)
            agent_velocity(i,j) = 2*velocity_bound(1,j) - agent_velocity(i,j);
        elseif agent_velocity(i,j) > velocity_bound(2,j)
            agent_velocity(i,j) = 2*velocity_bound(2,j) - agent_velocity(i,j);
        end
    end
end

fprintf(log_velocity,'Next velocities:\n');
fprintf(log_velocity,[repmat('%f\t',1,size(agent_velocity,2)) '\n'],agent_velocity');

% Move the particles:
agent_location = agent_location + agent_velocity;
% Check if the locations are outside the boundary
for i = 1:agent_quantity
    for j = 1:space_dimention
        if agent_location(i,j) < agent_bound(1,j)
            agent_location(i,j) = 2*agent_bound(1,j) - agent_location(i,j);
        elseif agent_location(i,j) > agent_bound(2,j)
            agent_location(i,j) = 2*agent_bound(2,j) - agent_location(i,j);
        end
    end
end
fprintf(log_location,'Next location:\n');
fprintf(log_location,[repmat('%f\t',1,size(agent_location,2)) '\n'],agent_location');

%% Fifth step: loop is here
converge_flag = 0;
k = 0;
for loop = 1:max_iter
    fprintf(log,'Iteration %f \n', loop);
    fprintf(log_location,'Iteration %f \n', loop);
    fprintf(log_velocity,'Iteration %f \n', loop);
    fprintf(log_gbest,'Iteration %f \n', loop);
    fprintf(log_pbest,'Iteration %f \n', loop);
    fprintf(log_pfitness,'Iteration %f \n', loop);
    fprintf('Iteration %f \n', loop);
    k = k + 1;
    w = 0.4 +(1 - gbest(loop))*0.5;
    if (gbest(loop) > 0.95)||(sum(sum(agent_velocity.^2)) < ConvergenceThreshold)
        converge_flag = 1;
        fprintf('Converged! Haha!!!');
        fprintf(log,'Converged! Haha!!!');
        break;
    end
    
    %Step 4a
    %Evaluate each particale's fitness, comparing to gbest, pbest
    for i = 1:agent_quantity
        agent_fitness(i,1) = fitness_function(freq, agent_location(i,:),tmpPrjFile, tmpDataFile);
        if agent_fitness(i,1) > pbest(i,1)
            pbest(i,1) = agent_fitness(i,1);
            agent_pbest(i,:) = agent_location(i,:);
        end
    end
    
    fprintf(log_pfitness,[repmat('%f\t',1,size(agent_fitness',2)) '\n'],agent_fitness);
    fprintf(log_pbest,[repmat('%f\t',1,size(agent_location,2)) '\n'],agent_pbest');
    [gbest_temp, gbest_position] = max(pbest);
    gbest = [gbest gbest_temp];
    fprintf(log_gbest,'%f ', gbest(loop));
    fprintf(log_gbest,'_ position: %f \n', gbest_position);
    
    %Step 4b
    matrix_C1 = c1*rand(agent_quantity, space_dimention).*(agent_pbest - agent_location);
    matrix_C2 = c2*rand(agent_quantity, space_dimention).*(ones(agent_quantity,1)*agent_pbest(gbest_position,:) - agent_location);
    agent_velocity = w*agent_velocity +  matrix_C1 + matrix_C2;
    
    % Check if the velocities are outside the boundary
    for i = 1:agent_quantity
        for j = 1:space_dimention
            if agent_velocity(i,j) < velocity_bound(1,j)
                agent_velocity(i,j) = 2*velocity_bound(1,j) - agent_velocity(i,j);
            elseif agent_velocity(i,j) > velocity_bound(2,j)
                agent_velocity(i,j) = 2*velocity_bound(2,j) - agent_velocity(i,j);
            end
        end
    end
    
    fprintf(log_velocity,[repmat('%f\t',1,size(agent_velocity,2)) '\n'],agent_velocity');
    
    
    %Step 4c
    % Move the particles:
    agent_location = agent_location + agent_velocity;
    % Check if the locations are outside the boundary
    for i = 1:agent_quantity
        for j = 1:space_dimention
            if agent_location(i,j) < agent_bound(1,j)
                agent_location(i,j) = 2*agent_bound(1,j) - agent_location(i,j);
            elseif agent_location(i,j) > agent_bound(2,j)
                agent_location(i,j) = 2*agent_bound(2,j) - agent_location(i,j);
            end
        end
    end
    fprintf(log_location,[repmat('%f\t',1,size(agent_location,2)) '\n'],agent_location');
    
    iteration = 1:k+1;
    figure(1001);
    plot(iteration, gbest)
end

%% Finalize
fprintf(log,'Best result: \n');
fprintf(log,[repmat('%f\t',1,size(agent_pbest(gbest_position,:),2)) '\n'],agent_pbest(gbest_position,:)');
fitness_function(freq, agent_pbest(gbest_position,:),tmpPrjFile, tmpDataFile);


fclose(log);
fclose(log_location);
fclose(log_velocity);
fclose(log_pbest);
fclose(log_gbest);
fclose(log_pfitness);

PSO_Analysis
