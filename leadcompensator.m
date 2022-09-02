%Lead compensator
ess=input('enter steady state error')
kv=1/ess
n=
d=conc([],[])
g=tf(n,d)
s=tf([],1)
sys=minreal(sys)
k=dcgain(kv/sys)
N=[k]
D=d
G=tf(N,D)
rpm=[45]
s=6
figure(1)
bode(N,D)
margin(N,D)
[mag,phase,w]=bode(N,D)
[gm,pm,wcg,wcp]=margin(mag,phase,w)
pm
rpmd=rpm-pm+s
rpmr=(rpmd*pi)/180
a=(1-sin(rpmr))/(1+sin(rpmr))
a1=-20*log10(1/sqrt(a))
w=100
for(i=0:0.1:w)
    [mag,phase]=bode(N,D,i)
    m1=20*log10(mag)
    if(m1<=a1)
        freq=i
        break
    end
end
t=[1/(freq*sqrt(a))]
nc=[t 1]
dc=[(a*t) 1]
[n0,d0]=series(N,D,nc,dc)
g0=tf(n0,d0)
figure(2)
bode(n0,d0)
figure(3)
subplot(2,1,1)
step(n0,d0)
[n1,d1]=cloop(n0,d0,-1)
subplot(2,1,2)
step(n1,d1)
