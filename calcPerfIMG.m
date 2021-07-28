function [mIoU,mDice,F2score,Precision,Recall,OverallAcc] = calcPerfIMG(GT,seg)

mIoU=0;mDice=0;F2score=0;Precision=0;Recall=0;OverallAcc=0;
for i=1:length(GT)%for all the images
    
    J = seg{i};%mask obtained by DeepLabv3+
    AJ = GT{i};%true mask
    
    tp=sum(sum(AJ==1 & J>0));
    tn=sum(sum(AJ==0 & J==0));
    fp=sum(sum(AJ==0 & J>0));
    fn=sum(sum(AJ==1 & J==0));
    
    mIoU=mIoU+(tp/(tp+fp+fn));
    mDice=mDice+((2*tp)/(2*tp+fp+fn));
    rec= tp/(tp+fn);
    if (tp==0)
        pre=0;
    else
        pre=tp/(tp+fp);
        F2score=F2score+(5*pre*rec/(4*pre+rec));
    end
    
    Precision=Precision+pre;
    Recall=Recall+rec;
    OverallAcc=OverallAcc+((tp+tn)/(tp+tn+fp+fn));
end

numImages=length(GT);
mIoU=mIoU/numImages;
mDice=mDice/numImages;
F2score=F2score/numImages;
Precision=Precision/numImages;
Recall=Recall/numImages;
OverallAcc=OverallAcc/numImages;

end