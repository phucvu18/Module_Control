clear all;

%% ???????? ????????????? ?? ?????????
[a,b]=DATALOAD();
Vx0=150/3.6;

%% ????????? ?????? ??????
kH=1.0;
kVy=0.14;

%% ?????? ???????????? ????????? ?? ??????
A=[ a(2,2) a(2,6) a(2,7);
    a(6,3) a(6,4) a(6,7);
    0       1       0   ];
B=[b(2,3); b(6,3); 0];
C=[1 0 Vx0];
D=0;
sys=ss(A,B,C,D);

%% ???????????? ??????? ?? ???????????? ????????
G_Vy=tf(sys);

%% ???????????? ??????? ?? ??????
s = tf('s');
G_H=G_Vy*(1/s);

%% ???????????? ??????? ????????????
tPHIOSH=50.E-3;
G_servo=tf(1,[tPHIOSH 1]); 

%% ???????????? ??????? ???????
% ??????? ??????+Vy
G1=series(G_servo,G_Vy);
% ?????????? ?????? (???????????)
G_Iraz=G1;
% ?????????? ?????? (?????????)
G_Izam=feedback(kVy*G_Iraz,1);
% ??????? ?????? (???????????)
G_sys_raz=1/kVy*G_Izam*(1/s);
% ??????? ?????? (?????????)
G_sys_zam=feedback(kH*G_sys_raz,1);
% ??? ?????????
G_noautopilot=series(G_servo,G_H);


%margin(G_Iraz);
%rlocus(G_sys_raz);
