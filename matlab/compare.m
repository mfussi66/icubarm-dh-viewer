forkrightv1_0 = readtable("fork_right_v1.0.csv");
masterrightv1_0 = readtable("master_right_v1.0.csv");
v1_0difference = forkrightv1_0.Variables - masterrightv1_0.Variables


forkrightv2_5 = readtable("fork_right_v2.5.csv");
masterrightv2_5 = readtable("master_right_v2.5.csv");

% For v2.5 the two tables are supposed to differ since thats the aim of the
% fork
% Remove last 2 columns representing min max limits
v2_5difference = forkrightv2_5{:, 1:end-2} - masterrightv2_5{:, 1:end-2}
% Difference between v2.5 urdf and forked code

RightTable = readtable('icubarm_right_urdf_dhparams.csv');
v2_5urdfvsfork = forkrightv2_5{:, 1:end-2} - RightTable{:, 1:end-2}
%% Instantiate Left Right CAD Arms
% Compare CAD arms poses


LeftTable = readtable('icubarm_left_urdf_dhparams.csv');
LeftTable.Properties.VariableNames = {'a', 'd', 'alpha', 'offset', 'min', 'max'};
LeftArm = Revolute('d', LeftTable.d(1), 'a', LeftTable.a(1), 'alpha', deg2rad(LeftTable.alpha(1)), 'offset', deg2rad(LeftTable.offset(1)));
for i=2:height(LeftTable)
   LeftArm = LeftArm + Revolute('d', LeftTable.d(i), 'a', LeftTable.a(i), 'alpha', deg2rad(LeftTable.alpha(i)), 'offset', deg2rad(LeftTable.offset(i)));
end
LeftArm.name = 'Left';

homtable = readtable('icubarm_left_urdf_h0_hn.txt');
h = zeros(4,4);
k = 2;
for i=1:4
    for j=1:4
        h(i, j) = homtable{1, k};
        k = k+1;
    end
end
LeftArm.base = h;
                
k = 2;
for i=1:4
    for j=1:4
        h(i, j) = homtable{2, k};
        k = k+1;
    end
end
LeftArm.tool = h;


RightTable = readtable('icubarm_right_urdf_dhparams.csv');
RightTable.Properties.VariableNames = {'a', 'd', 'alpha', 'offset', 'min', 'max'};
RightArm = Revolute('d', RightTable.d(1), 'a', RightTable.a(1), 'alpha', deg2rad(RightTable.alpha(1)), 'offset', deg2rad(RightTable.offset(1)));
for i=2:height(RightTable)
   RightArm = RightArm + Revolute('d', RightTable.d(i), 'a', RightTable.a(i), 'alpha', deg2rad(RightTable.alpha(i)), 'offset', deg2rad(RightTable.offset(i)));
end
RightArm.name = 'Right';


homtable = readtable('icubarm_right_urdf_h0_hn.txt');
h = zeros(4,4);
k = 2;
for i=1:4
    for j=1:4
        h(i, j) = homtable{1, k};
        k = k+1;
    end
end
RightArm.base = h;
                
k = 2;
for i=1:4
    for j=1:4
        h(i, j) = homtable{2, k};
        k = k+1;
    end
end
RightArm.tool = h;


qdes1 = [0 0 0 0 0 0 60.5 0 0 0];
qdes2 = [0 0 0 0 0 0 90.5 0 0 0];
qdes3 = [0 0 0 0 135 0 90.5 0 0 0];
qdes4 = [0 0 0 0 135 0 90.5 -90 -30.6 20.4];
qdes5 = [25 0 -9.6, 9.45 160.80 79.56 19.005 0 0 0.6];
qdes6 = [25 10 -9.6, 9.45 160.80 79.56 19.005 0 0 0.6];
qdes7 = [25 -15 -9.6, 9.45 160.80 79.56 19.005 0 0 5];
qdes8 = [-25 30 -9.6, 9.45 160.80 79.56 19.005 0 10 5];

Q = deg2rad(qdes1);
RightArm.display
RH = RightArm.fkine(Q)

LeftArm.display
LH = LeftArm.fkine(Q)
LeftRightDiff = LH - RH
%% 
%% Compare Left Right forked arms to check displacement

LeftTable = readtable('fork_left_v2.5.csv');
LeftTable.Properties.VariableNames = {'a', 'd', 'alpha', 'offset', 'min', 'max'};
LeftArm = Revolute('d', LeftTable.d(1), 'a', LeftTable.a(1), 'alpha', deg2rad(LeftTable.alpha(1)), 'offset', deg2rad(LeftTable.offset(1)));
for i=2:height(LeftTable)
   LeftArm = LeftArm + Revolute('d', LeftTable.d(i), 'a', LeftTable.a(i), 'alpha', deg2rad(LeftTable.alpha(i)), 'offset', deg2rad(LeftTable.offset(i)));
end
LeftArm.name = 'Left';

homtable = readtable('icubarm_left_urdf_h0_hn.txt');
h = zeros(4,4);
k = 2;
for i=1:4
    for j=1:4
        h(i, j) = homtable{1, k};
        k = k+1;
    end
end
LeftArm.base = h;
                
k = 2;
for i=1:4
    for j=1:4
        h(i, j) = homtable{2, k};
        k = k+1;
    end
end
LeftArm.tool = h;


RightTable = readtable('fork_right_v2.5.csv');
RightTable.Properties.VariableNames = {'a', 'd', 'alpha', 'offset', 'min', 'max'};
RightArm = Revolute('d', RightTable.d(1), 'a', RightTable.a(1), 'alpha', deg2rad(RightTable.alpha(1)), 'offset', deg2rad(RightTable.offset(1)));
for i=2:height(RightTable)
   RightArm = RightArm + Revolute('d', RightTable.d(i), 'a', RightTable.a(i), 'alpha', deg2rad(RightTable.alpha(i)), 'offset', deg2rad(RightTable.offset(i)));
end
RightArm.name = 'Right';


homtable = readtable('icubarm_right_urdf_h0_hn.txt');
h = zeros(4,4);
k = 2;
for i=1:4
    for j=1:4
        h(i, j) = homtable{1, k};
        k = k+1;
    end
end
RightArm.base = h;
                
k = 2;
for i=1:4
    for j=1:4
        h(i, j) = homtable{2, k};
        k = k+1;
    end
end
RightArm.tool = h;

LH = LeftArm.fkine(Q)
RH = RightArm.fkine(Q)
LeftRightDiff = LH - RH;
LeftRightDiff(:, 4)
%% Plot Arms

hold on
LeftArm.plot(Q, 'jointcolor', 'b', 'linkcolor', 'r', 'jointdiam', 0.5, ...
    'nojoints', 'workspace', [-1 1 -1 1 -1 1], ...
    'noname', 'noshadow');
    zlim([-1, 1]);

hold on
RightArm.plot(Q, 'jointcolor', 'r', 'linkcolor', 'b', 'jointdiam', 0.5,...
    'nojoints', 'workspace', [-1 1 -1 1 -1 1], ...
    'noname', 'noshadow', 'nobase');
    zlim([-0.5, 0.6]);
%% Import Right Arm from forked iKin
% Used to compare it with the CAD right arm

RightTableCode = readtable('fork_right_v2.5.csv');
RightTableCode.Properties.VariableNames = {'a', 'd', 'alpha', 'offset', 'min', 'max'};
RightArmCode = Revolute('d', RightTableCode.d(1), 'a', RightTableCode.a(1), 'alpha', deg2rad(RightTableCode.alpha(1)), 'offset', deg2rad(RightTableCode.offset(1)));
for i=2:height(RightTableCode)
   RightArmCode = RightArmCode + Revolute('d', RightTableCode.d(i), 'a', RightTableCode.a(i), 'alpha', deg2rad(RightTableCode.alpha(i)), 'offset', deg2rad(RightTableCode.offset(i)));
end
RightArmCode.name = 'Code';


homtable = readtable('resources/icubarm_right_urdf_h0_hn.txt');
h = zeros(4,4);
k = 2;
for i=1:4
    for j=1:4
        h(i, j) = homtable{1, k};
        k = k+1;
    end
end
RightArmCode.base = h;
                
k = 2;
for i=1:4
    for j=1:4
        h(i, j) = homtable{2, k};
        k = k+1;
    end
end
RightArmCode.tool = h;
%% Plot Arms

hold on
RightArmCode.plot(Q, 'jointcolor', 'b', 'linkcolor', 'r', 'jointdiam', 0.5, ...
    'nojoints', 'workspace', [-1 1 -1 1 -1 1], ...
    'noshadow');
    zlim([-1, 1]);
alpha(0.5)
hold on
RightArm.plot(Q, 'jointcolor', 'r', 'linkcolor', 'b', 'jointdiam', 0.5,...
    'nojoints', 'workspace', [-1 1 -1 1 -1 1], ...
    'noshadow', 'nobase');
    zlim([-0.5, 0.6]);
alpha(0.1)