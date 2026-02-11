clear;clc
% COIL20 鏉╂瑤閲滈弫鐗堝祦闂嗗棛娈慩{2}閻ㄥ嫮澹掑浣规殶閺??19閿涘苯鐨禍宸嗛敍灞肩瘍娑撳秷鍏�?悽顭掔礉鏉╂瑤閲滈弫鐗堝祦闂嗗棗绱旀禍鍡楁儌
% WebKB 鏉╂瑤閲滈弫鐗堝祦闂嗗棗�?狽ormalize閸氬函绱漍{1}閻ㄥ嫮顑?34鐞涘本妲窷aN�??? 娑旂喍绗夐懗鐣屾暏閿涘矁绻栨稉顏呮殶閹诡噣娉�?鍐х啊閸??
% 閸忔湹绮敮鍝ユ暏閻ㄥ嫭鏆熼幑顕?娉︽稊鐔活洣閹靛彞绔存禍娑崇礉娑撳秷鍏橀崗澶庣獓鏉╂瑥鍤戞稉?

load('MSRC1106.mat')

folder_now = pwd;
path = [folder_now '\results2\MSRC'];


numView = length(X); % the number of views
%Normalize data
for i=1:numView
    data = X{i}';
    data = data./repmat(sqrt(sum(data.^2)),[size(data,1) 1]);
    X{i} = data';
    % remove mean
    mean = sum(X{i},1)/size(X{i},1);
    X{i} = X{i}-mean;
end

c = length(unique(Y)); % the number of classes





n_anchors = [2*c,3*c,4*c,5*c];
beta = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9];
r = [1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0];
ACC = zeros(length(beta),length(r),length(n_anchors));
NMI = zeros(length(beta),length(r),length(n_anchors));
ARI = zeros(length(beta),length(r),length(n_anchors));



for iter =1:10 % the number of cross validation 

fprintf('Performing --------------SMRC-----------%d.\n',iter);

    for i =1:length(n_anchors)

        Z = cell(1,numView);
        for v = 1:numView
            [label, Anchors] = litekmeans(X{v}, n_anchors(i),'MaxIter', 50, 'Replicates', 10);
            Z{v} = ConstructA_NP(X{v}', Anchors');
            % remove mean
            mean = sum(Z{v},1)/size(Z{v},1);
            Z{v} = Z{v}-mean;
        end

        for j =1:length(beta)
            for k =1:length(r)
                [~,predict,Tim,obj] = SMRC(X,Z,c,r(k),beta(j));
                result = ClusteringMeasure(Y, predict);
                ACC(j,k,i)= result(1);
                NMI(j,k,i)= result(2);
                ARI(j,k,i)= result(7);
            end
         end
     t=1;
    end
    save([path '\' 'SMRC_' num2str(iter) '_result.mat' ],'ACC','NMI','ARI','n_anchors','r','beta');
    clear ACC NMI ARI Z
end
