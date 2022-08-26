%% �������� ������� ������ ������������ ������
function [BAL,J]=BALANCING(Xzad,KEY)    
    %% �������� ������� ��������
    f = @(BAL)FCT(BAL,Xzad,KEY);
    
    %% ��������� �������� ��������� ���������� ������������
    BAL0=[0.0,0.0,0.0,0.0,0.0];  
    options = optimset('fminunc');
    %options = optimset(options, 'TolFun',1e-10,'TolX',1e-10','TolCon',1e-10);
    %options = optimset(options,'Display','iter','PlotFcns',@optimplotfval);
    [BAL,J] = fminunc(f,BAL0,options);
end