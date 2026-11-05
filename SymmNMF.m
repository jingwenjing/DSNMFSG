function [V1,noiter] = SymmNMF(LW,V1,options)
%Symmetric NMF
% 2025.03.04

eps=options.eps;
Maxiter=options.Maxiter;

for k=1:Maxiter
    %% 更新V1
    obj=V1;
    V1FZ=LW*V1; 
    V1FZ(V1FZ<0)=0;
    V1FMVTV=V1'*V1;   
    V1FM=V1*V1FMVTV;
    V1=V1.*(V1FZ./max(V1FM,1e-15));
    
    V1=NormalizeFea(V1);
   %% 停止准则
      obj0=V1;
      re=norm(obj0-obj)/norm(obj);
      if re<eps
         break
      end 
end
 noiter=k;

end

