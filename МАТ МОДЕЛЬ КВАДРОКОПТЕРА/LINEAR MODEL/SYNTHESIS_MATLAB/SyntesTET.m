clear all;

%% �������� ������������� �� ���������
[a,b]=DATALOAD();

%% ��������� ������ �������
kTET=1.2;       
kWz=0.48;
T_CHI=0.1;

%% ������ ������������ ��������� �� ���� �������
A=[ a(1,1) a(1,2) a(1,6) a(1,7);
    a(2,1) a(2,2) a(2,6) a(2,7);
    a(6,1) a(6,2) a(6,6) a(6,7);    
    0       0       1       0];
B=[b(1,1); b(2,1); b(6,1); 0];
C=[0 0 1 0];
D=0;
sys=ss(A,B,C,D);

%% ������������ ������� �� ���� �������
G_Wz=tf(sys);

%% ������������ ������� �� ������� �������� �������
s = tf('s');
G_TET=G_Wz*(1/s);

%% ������������ ������� ������������
tCHI=50.E-3;
G_servo=tf(1,[tCHI 1]);

%% ������������ ������� ��
G_bf=tf(1,[T_CHI 1]);

%% ������������ ������� �������
% ������� ������+Wz
G1=series(G_servo,G_Wz);
% ���������� ������ (�����������)
G_Iraz=G1*G_bf;        
% ���������� ������ (���������)
G_Izam=feedback(kWz*G_Iraz,1);
% ������� ������ (�����������)
G_sys_raz=1/kWz*G_Izam*(1/s);
% ������� ������ (���������)
G_sys_zam=feedback(kTET*G_sys_raz,1);
% ��� ���������
G_noautopilot=series(G_servo,G_TET);

%figure;
%margin(G_Iraz);
%rlocus(G_sys_raz);