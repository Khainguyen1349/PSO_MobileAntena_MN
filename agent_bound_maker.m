function [agent_bound, velocity_bound]= agent_bound_maker(parameter)
%% How to assign boundary?
agent_bound(:,1) = parameter.p1;
agent_bound(:,2) = parameter.p2;
agent_bound(:,3) = parameter.p3;

%% How to assign velocity boundary?
range_parameter1 = [(parameter.p1(1)-parameter.p1(2)); (parameter.p1(2)-parameter.p1(1))];
range_parameter2 = [(parameter.p2(1)-parameter.p2(2)); (parameter.p2(2)-parameter.p2(1))];
range_parameter3 = [(parameter.p3(1)-parameter.p3(2)); (parameter.p3(2)-parameter.p3(1))];

velocity_bound(:,1) = range_parameter1;
velocity_bound(:,2) = range_parameter2;
velocity_bound(:,3) = range_parameter3;
end
