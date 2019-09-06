% PSO analysis
% Made by Khai NGUYEN 08/06/2018
clear all
close all
clc
%% Read the results from data files and visualize for conclusions
logFile = strcat(pwd, '\data\pso.log');
logLocationFile = strcat(pwd, '\data\pso_location.log');
logVelocityFile = strcat(pwd, '\data\pso_velocity.log');
logPbestFile = strcat(pwd, '\data\pso_pbest.log');
logGbestFile = strcat(pwd, '\data\pso_gbest.log');
logPfitnessFile = strcat(pwd, '\data\pso_pfitness.log');
% logEfficienciesFile = strcat(pwd, '\data\pso_efficiencies.csv');
touchstoneFile = strcat(pwd, '\data\tmpData.s2p');

log = fopen(logFile,'r');
log_location = fopen(logLocationFile,'r');
log_velocity = fopen(logVelocityFile,'r');
log_pbest = fopen(logPbestFile,'r');
log_gbest = fopen(logGbestFile,'r');
log_pfitness = fopen(logPfitnessFile,'r');
% log_Eff = fopen(logEfficienciesFile,'r');

%% Firstly check the boundaries in pso.log
psolog_line = 1;
flag_last_logline = 0;
while ~feof(log)
    line = fgets(log); %# read line by line
    %if isstring(line)
        sp_line = strsplit(line);
    %end
    if psolog_line == 2
        lowbound_locations_cell = sp_line;
    elseif psolog_line == 3
        highbound_locations_cell = sp_line;
    elseif psolog_line == 5
        lowbound_velocities_cell = sp_line;
    elseif psolog_line == 6
        highbound_velocities_cell = sp_line;
%     elseif flag_last_logline == 1
%         final_gbest_location_cell = sp_line;
    end
    if strcmp(cell2mat(sp_line(1)),'Best')
        flag_last_logline = 1;
    end
    psolog_line = psolog_line + 1;
end
num_feature = length(lowbound_locations_cell)-1;
bound_locations = zeros(2,num_feature);
bound_velocities = zeros(2,num_feature);
final_gbest_location = zeros(1,num_feature);
for i = 1:length(lowbound_locations_cell)-1
    bound_locations(1,i) = str2double(cell2mat(lowbound_locations_cell(i)));
    bound_locations(2,i) = str2double(cell2mat(highbound_locations_cell(i)));
    bound_velocities(1,i) = str2double(cell2mat(lowbound_velocities_cell(i)));
    bound_velocities(2,i) = str2double(cell2mat(highbound_velocities_cell(i)));
%     final_gbest_location(i) = str2double(cell2mat(final_gbest_location_cell(i)));
end

%% Secondly check convergence progress in pso_gbest.log
gbest_array = [];
while ~feof(log_gbest)
    line = fgets(log_gbest); %# read line by line
    sp_line = strsplit(line);
    [num, status] = str2num(cell2mat(sp_line(1)));
    if status ~= 0
        gbest_array = [gbest_array num];
    end
end
num_iteration = length(gbest_array);

%% Thirdly, check pso_pfitness.log to see how many agents are assigned and what are their best values in each iterations
pfitness_line = 1;
num_agent = 1;
while ~feof(log_pfitness)
    line = fgets(log_pfitness); %# read line by line
    if mod(pfitness_line,2) == 0
        sp_line = strsplit(line);
        if pfitness_line == 2
            num_agent = length(sp_line) - 1;
            pfitness_mat = zeros(num_iteration, num_agent);
        end
        for i = 1:num_agent
            pfitness_mat(pfitness_line/2,i) = str2double(cell2mat(sp_line(i)));
        end
    end
    pfitness_line = pfitness_line + 1;
end

%% Fourthly, check pso_location.log to see how each agent running around
locations = zeros(num_iteration+2, num_agent,num_feature);
location_line = 1;
iteration = 0;
agent = 1;
while ~feof(log_location)
    line = fgets(log_location); %# read line by line
    if mod(location_line,num_agent + 1) == 1
        iteration = iteration + 1;
    else
        sp_line = strsplit(line);
        for i = 1:length(sp_line) - 1
            locations(iteration,agent,i) = str2double(cell2mat(sp_line(i)));
        end
        if agent ~= num_agent
            agent = agent + 1;
        else
            agent = 1;
        end
    end
    location_line = location_line + 1;
end

%% Fifthly, check pso_location.log to see how each agent running around
velocities = zeros(num_iteration+2, num_agent,num_feature);
velocity_line = 1;
iteration = 0;
agent = 1;
while ~feof(log_velocity)
    line = fgets(log_velocity); %# read line by line
    if mod(velocity_line,num_agent + 1) == 1
        iteration = iteration + 1;
    else
        sp_line = strsplit(line);
        for i = 1:length(sp_line) - 1
            velocities(iteration,agent,i) = str2double(cell2mat(sp_line(i)));
        end
        if agent ~= num_agent
            agent = agent + 1;
        else
            agent = 1;
        end
    end
    velocity_line = velocity_line + 1;
end

%% Sixthly, check Touchstone file from HFSS to see the original antenna 
%reflection coefficients without Matching Circuit
origine_antenna = read(rfdata.data,touchstoneFile);
freq = origine_antenna.Freq;
S11_origine = origine_antenna.S_Parameters;
S11dB_origine = zeros(1,length(freq));
for i = 1:length(freq)
    S11dB_origine(i) = 20*log10(abs(S11_origine(1,1,i)));
end
%Z_origine = s2z(S11,50);

%% Seventhly, check Optenni result to see how S11 has been improved
outputIFA_Optenni = xml2struct('\optenni\outputMobile_ant.xml');
RCoefficient_str = strsplit(outputIFA_Optenni.optennicurves.curve{1,1}.Text);
RCoefficientdB = zeros(1,length(freq));
TotalEffdB = zeros(1,length(freq));
for i = 1:length(freq)
    RCoefficientdB(i) = str2double(RCoefficient_str(2*i+1));
end
% also the total efficiencies
TotalEff_str = strsplit(outputIFA_Optenni.optennicurves.curve{1,2}.Text);
for i = 1:length(freq)
    TotalEffdB(i) = str2double(TotalEff_str(2*i+1));
end

%% Visualize results
fprintf('There are %f agents assigned this optimization \n',num_agent);
fprintf('There are %f iterations run during this optimization\n',num_iteration);
fprintf('There are %f features of the antenna, which are analyzed \n',num_feature);
fprintf('Which have range: \n');
fprintf([repmat('%f\t',1,size(bound_locations,2)) '\n'],bound_locations');
fprintf('While agents velocities have range: \n');
fprintf([repmat('%f\t',1,size(bound_velocities,2)) '\n'],bound_velocities');

figure(1); % Convergence figure
plot(1:num_iteration,gbest_array);
xlabel('Iterations');
ylabel('Total efficiency');
title ('Convergence progress');

figure(2) % Locations and Velocity figures
for i = 1:num_feature
    subplot(2,num_feature,i)
    for j = 1:num_agent
        plot(1:num_iteration+2,locations(:,j,i));
        hold on
    end
    xlabel('Iterations');
    ylab = strcat('Feature',num2str(i),' range');
    ylabel(ylab);
    title ('Agents movements');
    hold off
    subplot(2,num_feature,num_feature + i)
    for j = 1:num_agent
        plot(1:num_iteration+2,velocities(:,j,i));
        hold on
    end
    xlabel('Iterations');
    ylab = strcat('Velocity of feature',num2str(i),' range');
    ylabel(ylab);
    title ('Agents velocities');
    hold off
end

figure(3) % Reflection coefficients and Total Efficiencies figures
subplot(1,2,1)
plot(freq,S11dB_origine);
hold on
plot(freq,RCoefficientdB);
xlabel('Frequency');
ylabel('Reflection Coefficient(dB)');
legend('Without MN','With MN');
title ('Optimal antenna with/without MN');
hold off
subplot(1,2,2)
plot(freq,TotalEffdB);
xlabel('Frequency');
ylabel('Total Efficiencies(dB)');
title ('Total Efficiency');

%% Close data files after finishing all
fclose(log);
fclose(log_location);
fclose(log_velocity);
fclose(log_pbest);
fclose(log_gbest);
fclose(log_pfitness);
% fclose(log_Eff);