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
    U   = [BAL(1) BAL(2) BAL(3) BAL(4)];
    %% ���� � �������   
    % ���� ����             
    THRST= kT*U.^2;            % ���� �������
    FTb  = [0;sum(THRST);0];   % ������ �������������� � ���
    % ���� �������������    
    FDb  = -kD*Vb.^2;          % (� ���)
    % ���� �������          
    FGg  = m*[0;-g;0];         % (� ���)
    FGb  = Cbg'*FGg;           % (� ���)
    % ������                   
    MM   = kM*U.^2;            % (� ���)

    %% ��������� ���� � ��������� ������ (� ���)
    FS   = FTb+FDb+FGb;
    MX   = Lq*(THRST(4)-THRST(2))+(Jyy-Jzz)*Wyb*Wzb;
    MY   = MM(1)+MM(3)-MM(2)-MM(4)+(Jzz-Jxx)*Wxb*Wzb;
    MZ   = Lq*(THRST(1)-THRST(3))+(Jxx-Jyy)*Wxb*Wyb;
    
    %% �������� �����������
    FJ   = [FS(x),FS(y),FS(z),MX,MY,MZ];
    J    = FJ*FJ';    
end