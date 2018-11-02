clear;clc;
load('learningNKPC.mat');load('intermediateBLE.mat');

dx=10e-6;dy=10e-6;
k=1:length(intermediateBLE(:,1)); text(intermediateBLE(:,1)+dx,intermediateBLE(:,2)+dx,num2str(k'),'fontSize',15)
hold on
k=1:length(learningAgg(:,1)); text(learningAgg(:,1)-dy,learningAgg(:,2)-dy,num2str(k'),'fontSize',15)
hold on
scatter(intermediateBLE(:,1),intermediateBLE(:,2),100,'o','filled');
hold on
scatter(learningAgg(:,1),learningAgg(:,2),100,'*');
hold on
plot(intermediateBLE(:,1),intermediateBLE(:,2),'blue');
hold on
plot(learningAgg(:,1),learningAgg(:,2));
legend('intermediate BLE','iterated \bf{\beta}');
uicontrol('Style', 'slider')
% xlim([0.9 1]);
% ylim([0.7 1]);