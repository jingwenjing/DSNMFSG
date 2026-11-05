clear;
clc;
load('pixraw10P.mat')   %
fea=X;
fea=NormalizeFea(fea);
N=10;MK=10;nk= 10;
nk1=20;
opt=[]; 
opt.eps=1e-5;
opt.Maxiter=200;
opt1=[]; 
opt1.eps=1e-5;
opt1.Maxiter=200;
NKN=1;   
iter=10;  
X=fea';  gndnk=Y;
n=size(X);
options = [];
       options.NeighborMode = 'KNN';
       options.k = 4;
       options.WeightMode = 'Binary';
       LW0= constructW(X',options);   
rng('default')
NMIGNT=zeros(iter,NKN);  ACGNT=zeros(iter,NKN); 
for j4=1:iter 
    V1I=rand(n(2),nk1)*1; 
    V2I=rand(n(2),nk)*1;
    [V1,noiter0] = SymmNMF(LW0,V1I,opt);
    options1 = [];
       options1.NeighborMode = 'KNN'; 
       options1.k = 8;
       options1.WeightMode = 'Binary';
       LW1= constructW(V1,options1); 
    [V2,noiter1] = SymmNMF(LW1,V2I,opt1);
    for l1=1:size(V2,1)   
        [~,C1]=max(V2(l1,:)); 
        labelgnt(l1)=C1;  
    end
    labelgnt = bestMap(gndnk,labelgnt); 
    NMIhatgnt = MutualInfo(gndnk,labelgnt);
    ACgnt= length(find(gndnk == labelgnt))/length(gndnk);
    NMIGNT(j4,NKN)=NMIhatgnt;  
    ACGNT(j4,NKN)=ACgnt;   
end     
meanNMI_DSNMFSG=mean(mean( NMIGNT));meanAC_DSNMFSG=mean(mean(ACGNT)); 
stdNMI_DSNMFSG=std2( NMIGNT);   stdAC_DSNMFSG=std2(ACGNT);       


