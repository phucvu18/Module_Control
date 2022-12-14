# ?? ?????? ?????-?????

function [xnew, xd] = RK4(fx, time, dt, xx, U)
%% 1st call
[xd]=fx(xx,U,time);
xa=xd*dt;
x=xx+0.5*xa;
t=time+0.5*dt;
%% 2nd call
[xd]=fx(x,U,t);
q=xd*dt;
x=xx+0.5*q;
xa=xa+2.0*q;
%% 3rd call
[xd]=fx(x,U,t);
q=xd*dt;
x=xx+q;
xa=xa+2*q;
time=time+dt;
%% 4th call
[xd]=fx(x,U,time);
xnew=xx+(xa+xd*dt)/6.0;
end

