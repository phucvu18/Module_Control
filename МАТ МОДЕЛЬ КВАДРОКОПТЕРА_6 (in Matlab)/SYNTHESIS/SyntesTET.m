clear all;

%% ????????? ?????? ???????
kTET=1;       
kWz=1;
T_CHI=0.1;

%% ?????? ???????????? ????????? ?? ???? ???????
A=[ 0,0,0,-9.66351075782580,0,0;
    0,0,0,0,0,0;0,0,0,0,0,0;
    0,0,1,0,0,0;
    1,0,0,0,0,0;
    0,1,0,0,0,0];
B=[ 0,0,0,0;
    0.0159961720389716,0.0159961720575542,0.0159961720389049,0.0159961728806341;
    2.45674997185561,0,-2.45674997184547,0;
    0,0,0,0;0,0,0,0;0,0,0,0];
C=[0 0 1 0 0 0];
D=0;
sys=ss(A,B,C,D);

%% ???????????? ??????? ?? ???? ???????
G_Wz=tf(sys);

%% ???????????? ??????? ?? ??????? ???????? ???????
s = tf('s');
G_TET=G_Wz*(1/s);

%% ???????????? ??????? ????????????
tCHI=50.E-3;
%G_servo=tf(1,[tCHI 1]);
G_servo=1;

%% ???????????? ??????? ??
%G_bf=tf(1,[T_CHI 1]);

G_bf=1;

%% ???????????? ??????? ???????
% ??????? ??????+Wz
G1=series(G_servo,G_Wz);
% ?????????? ?????? (???????????)
G_Iraz=G1*G_bf;        
% ?????????? ?????? (?????????)
G_Izam=feedback(kWz*G_Iraz,1);
% ??????? ?????? (???????????)
G_sys_raz=1/kWz*G_Izam*(1/s);
% ??????? ?????? (?????????)
G_sys_zam=feedback(kTET*G_sys_raz,1);
% ??? ?????????
G_noautopilot=series(G_servo,G_TET);

%figure;
%margin(G_Iraz);
%rlocus(G_sys_raz);