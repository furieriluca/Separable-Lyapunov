
%%%     Code associated with the paper 
%%%     "On Separable Quadratic Lyapunov Functions for Convex Design of Distributed Controllers"
%%%
%%%     Authors: Luca Furieri, Yang Zheng, Antonis Papachristodoulou, Maryam
%%%     Kamgarpour
%%%
%%%     All rights reserved

%%%     To be cited as follows:
%{

@inproceedings{furieri2019separable,
  title={On separable quadratic Lyapunov functions for convex design of distributed controllers},
  author={Furieri, Luca and Zheng, Yang and Papachristodoulou, Antonis and Kamgarpour, Maryam},
  booktitle={2019 18th European Control Conference (ECC)},
  pages={42--49},
  year={2019},
  organization={IEEE}
}

%}


clear;close all

A=[2 1 5;0 -1 1;-1 1 0.5];
B2=[1 -1 0;0 0 -1;0 0 1];
B1=eye(3);

n= size(A,1);
m=size(B2,2);
  
S=[1 1 0;1 1 1;0 1 1];                                              % Desired sparsity pattern
T=[1 1 0;1 1 1;0 0 1];                                              %  Chosen T < S for sparsity invariance approach%
Rstruct=[1 1 0;1 1 0;0 0 1];                                    % Chosen R for sparsity invariance approach 

% Performance matrices
Q  =eye(n); R = eye(m);


%% Structured Optimal control P2: LMI
[Ko1,Jo1] = StrucH2LMI(A,B1,B2,Q,R,S);                                       %Block Diagonal approach


disp('NOTICE THAT THE ABOVE PROGRAM IS INFEASIBLE')
disp('EIGENVALUES OF A-B*K ARE:')

EIGENVALUES_CLOSED_LOOP=eig(A-B2*Ko1)
disp('PRESS ENTER TO CONTINUE')
pause

[Ko1new,Jo1new,X] = StrucH2LMI_new(A,B1,B2,Q,R,T,Rstruct);      %Sparsity Invariance approach

Kc = lqr(A,B2,Q,R);                                                                         %Optimal centralized


%% check stability and that P is a lyap function
disp('We recover the following distributed controller')
Ko1new

disp('yielding a cost of')
Jo1new

disp('which stabilizes the closed loop')
stability=eig(A-B2*Ko1new)

disp('and admits a separable lyapunov function')
P=inv(X)

disp('which satisfies the Gramian equation')
is_lyap=eig(P*(A-B2*Ko1new)+(A-B2*Ko1new)'*P+P*B1*B1'*P)

disp('The cost achieved by the optimal centralized controller is')

Jc = sqrt(trace(lyap((A - B2*Kc)',Q + Kc'*R*Kc)*(B1*B1')))






