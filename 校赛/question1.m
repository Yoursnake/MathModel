clc,clear
interval = 3;
start = [0:interval:120-interval];	% ����ʱ��
ending = start + 80;	% ����ʱ���Ӧ�Ľ���ʱ��
temp = 0:interval:120-80-1;
s = ones(1,size(0:interval:120-80-1,2));	% ����������
d = ones(1,size(temp(end)+1:interval:120-interval,2),1) + 1;	% ˫��������
car = [s,d]';	% ��Ϊ����Ҫ���������Σ����Է����γ����ǵ���
T = [start',ending',car];
for i = 1:size(T,1)
	for j = 1:size(T,1)
		if j > size(T,1) || i > size(T,1)
			break;
		end
		if T(i,1) == T(j,2)
			T(i,:) = [];
		end
	end
end
T
carNum = size(T,1);
sNum = size(find(T(:,3) == 1),1);
dNum = carNum - sNum;
fprintf('������Ҫ�� %d ��\n%d �����೵��%d ��˫�೵\n', carNum,sNum,dNum);