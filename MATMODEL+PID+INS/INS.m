%% �������� ������ ���
% XB0=[Q0,Q1,Q2,Q3,Vx,Vy,Vz,L,H,Z] - ������ ���������� ��������� ���
function [XPNK]=INS(AfBI_b,WBI_b)
global INSPAR XB0
persistent QB XNAV
    if isempty(QB)
        QB=XB0(1:4);    % QB = [Q0,Q1,Q2,Q3] - ������ �����������
        XNAV=XB0(5:10); % XNAV = [Vx,Vy,Vz,L,H,Z] - ������ ������ ������������� ����������
    end
    % ������� ���
    fINS=INSPAR.fINS;
    % ������ ������ ���
%    TAU=1.0/fINS;
    TAU=1.E-3;

%% ������� ������ ��������� ��
    % ����������� 
    Q0=QB(1);Q1=QB(2);Q2=QB(3);Q3=QB(4);
    % ������� ������ ����� ���������� �������� � ���
    TETB=asin(2*Q1*Q2+2*Q0*Q3);
    GAMB=atan(-(2*Q2*Q3-2*Q0*Q1)/(2*Q0^2+2*Q2^2-1));
    PSIB=atan(-(2*Q1*Q3-2*Q0*Q2)/(2*Q1^2+2*Q0^2-1));
    % ������� ��������
    Vx=XNAV(1);    Vy=XNAV(2);    Vz=XNAV(3);
    % ������� ��������
    Cbn=QUAT2MATR(QB);
%% ������ ����������
    % ������ �� ����������
    Wx=WBI_b(1);    Wy=WBI_b(2);    Wz=WBI_b(3);    
    % ���������� ������� ��������
	QW=[0;Wx;Wy;Wz];
    % ������� ��������������
    MQB=[   Q0 -Q1 -Q2 -Q3;
            Q1  Q0 -Q3  Q2;
            Q2  Q3  Q0 -Q1;
            Q3 -Q2  Q1  Q0];
    % ��������� ��������
    DQB=0.5*MQB*QW;      
    % �������������� �� ����� ������
    QB=QB+DQB*TAU;   
    
%% ������ ���������    
    % ������� ��������� �������������� �� ��� � ���
    AfBI_n=Cbn*AfBI_b;
    % ������ ��������������� ��������� ����� (� ���)
    g=[0;-9.81;0];
    % ��������� �� � ���
    ABE_n=AfBI_n+g;     
    % ���������� ������� ������������� ���������� XB
    DXNAV=[ABE_n(1);ABE_n(2);ABE_n(3);Vx;Vy;Vz];        
    % ������� ������ ���������
    XNAV=XNAV+DXNAV*TAU;
    
%% ����� �����������     
    XPNK=[Wx;Wy;Wz;GAMB;PSIB;TETB;XNAV];
end