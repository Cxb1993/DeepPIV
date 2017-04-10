clc; clear; close all;

umax = 3.8;
width = 3.14;
radius = width*0.5;
mu = 1.08E-3/100;
x=0:0.02:radius;

dpdr = -4*mu*umax/radius^2;
u=-0.25/mu*dpdr*(radius^2-x.^2);

xtot=[-sort(x,'descend'),x];
utot=[sort(u,'ascend'),u];

figure(1)
plot(x,u,'r*')
hold on
plot(xtot,utot,'bo')
hold off
grid on

dx=abs(xtot(1)-xtot(2));
uave=sum(dx*utot)/width