% Assignment III

% Authors:
% Andres Velazquez Vela
% Sergio Viejo Casado
            
% G 45

clear; clc; close all;
Config(); % to load the latex configuration file
warning('off', 'all')

% Initial Conditions 
% [u1 , u'1 , u2 ,u'2]
u0 = [0.994, 0 , 0 , -2.001585106379082522405378622]; 

% Solving Interval
t = [0,17];

% mu and nmu 
mu = 0.0122774;
nmu = 1 -mu;

% D1 an D2 
D1 = @(u1, u2) ((u1 + mu)^2 + u2^2)^(3/2);
D2 = @(u1, u2) ((u1 - nmu)^2 + u2^2)^(3/2);


% |:::::::::::::::::::::::::::::::: PART 1 ::::::::::::::::::::::::::::::::|

% |.............................. Exercise 1 ..............................|

fprintf('Creating A, B, dX fuction handles.\n')

A = [0, 1, 0, 0; 1, 0, 0, 2; 0, 0, 0, 1; 0,-2, 1, 0];

B = @(u1,u2) [0, -nmu*(u1 + mu)/D1(u1,u2) - mu*(u1-nmu)/D2(u1,u2), 0, -nmu*u2/D1(u1,u2) - mu*u2/D2(u1,u2)];

dX = @(X) A*X(:) + B(X(1), X(3))';


% |.............................. Exercise 2 ..............................|

format long;
lambdas = eig(A); % Compute eigenvalues of A
dts = 1/abs(max(lambdas)); % Find eigenvalue with the largest absolute value and compte the time step

lambda = eig(A);
t_step = 1/abs(max(lambda));
scaled_lambdas = lambdas*dts; % Scale the eigenvalues

dts_Ex21 = dts;
scaled_lambdas_Ex21 = scaled_lambdas;

% Stability region
fprintf('Computing stability region.\n')
theta = linspace(0, 2*pi, 300);
complex = -1 + cos(theta) + 1i*sin(theta);

lambda_dt = lambda * 1;

%%%% Find Stability
fprintf('Finding Stability.\n')
[scaled_lambdas, dts] = Iterative_Lambda(75, 1e-10, scaled_lambdas, lambdas, dts);
dts_Ex22 = dts;
scaled_lambdas_Ex22 = scaled_lambdas;

%%%%

% |.............................. Exercise 3 ..............................|

fprintf('Solving Explicit Euler.\n')
toc1 = evalc('tic;[X_eu,t_eu] = ODEexplicitEuler(u0,t,dts,dX);toc;');

% |:::::::::::::::::::::::::::::::: PART 2 ::::::::::::::::::::::::::::::::|

% |.............................. Exercise 4 ..............................|

fprintf('Solving Range Kuta.\n')
toc2 = evalc('tic;[X_rk4,t_rk4] = ODErk4(u0,t,dts,dX);toc;');

% |.............................. Exercise 5 ..............................|

dts5 = dts;
%the function for 5 is ItdeltaT

% % |.............................. Exercise 6 ..............................|

Output(A, complex, theta, scaled_lambdas_Ex21, dts_Ex21, scaled_lambdas_Ex22,  dts_Ex22, t_eu, X_eu, t_rk4, X_rk4, dts5, u0, t,dX,toc1, toc2)
