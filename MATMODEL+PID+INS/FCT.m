%% �������� ����������� ��� ������� ������ ������������
function[J]=FCT(BAL,Xzad,KEY)
global  PARAM 
    % ��������� ������ ����� � ���������
    g   = 9.81;  % ��������� ���� �������
    pho = 1.225; % ��������� ������� 
        
    % ����������� �� ����
    x=1;    y=2;    z=3;
    
    %% ��������� �����������
    %CT  = 1.0e-9;   % ����������� ��������� ���� ����������
    %D   = 11;       % ������� ����������
    %CQ  =           % ����������� ������� ����������
    
    kT  = PARAM.kT;   % ����������� ���� 
    kM  = PARAM.kM;   % ����������� �������
    kD  = PARAM.kD;   % ����������� ������������� 
  
    %% �����-����������� ���������
    % �����
    m   = PARAM.m;
    % ������� �������
    Jxx = PARAM.Jxx;    
    Jyy = PARAM.Jyy;    
    Jzz = PARAM.Jzz;
    % �����
    Lq  = PARAM.Lq;
    
    %% ������� ���������
    % �������� � ���
    Vxb = Xzad(1);     
    Vyb = Xzad(2);
    Vzb = Xzad(3);
    % ������� �������� � ���
    Wxb = Xzad(4);
    Wyb = Xzad(5);
    Wzb = Xzad(6);
    % ���� ����������
    GAM = Xzad(7);     % ����
    PSI = Xzad(8);     % ����
    if (KEY==0)         % ������
        TET = Xzad(9); % ����� �������/�����/�������   
    else
        TET = BAL(5);  % ����� �������
    end       
    % ������ �������� � C��
    Vb  = [Vxb;Vyb;Vzb];
    % ������� �������� �� ��� � ���
    Cbg = C_bg(TET,PSI,GAM); 
    
    %% C������ ����������
    uH   = BAL(1);          % ���� ������� � ���                       
    uTET = BAL(2);    % ������ � ���
    uGAM = BAL(3);
    uPSI = BAL(4);
    
    %% ���� � �������   
    % ���� ����             
    
    FTb  = [0;uH;0];   % ������ �������������� � ���
    % ���� �������������    
    FDb  = -kD*Vb.^2;          % (� ���)
    % ���� �������          
    FGg  = m*[0;-g;0];         % (� ���)
    FGb  = Cbg'*FGg;           % (� ���)
    

    %% ��������� ���� � ��������� ������ (� ���)
    FS   = FTb+FDb+FGb;
    MX   = uGAM+(Jyy-Jzz)*Wyb*Wzb;
    MY   = uPSI+(Jzz-Jxx)*Wxb*Wzb;
    MZ   = uTET+(Jxx-Jyy)*Wxb*Wyb;
    
    %% �������� �����������
    FJ   = [FS(x),FS(y),FS(z),MX,MY,MZ];
    J    = FJ*FJ';    
end