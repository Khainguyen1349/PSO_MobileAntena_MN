
function [agent_bound, velocity_bound]= agent_bound_maker(parameter1, parameter2, parameter3)
%% How to assign boundary?
agent_bound(:,1) = parameter1;
agent_bound(:,2) = parameter2;
agent_bound(:,3) = parameter3;

%% How to assign velocity boundary?
range_parameter1 = [(parameter1(1)-parameter1(2)); (parameter1(2)-parameter1(1))];
range_parameter2 = [(parameter2(1)-parameter2(2)); (parameter2(2)-parameter2(1))];
range_parameter3 = [(parameter3(1)-parameter3(2)); (parameter3(2)-parameter3(1))];

velocity_bound(:,1) = range_parameter1;
velocity_bound(:,2) = range_parameter2;
velocity_bound(:,3) = range_parameter3;
end