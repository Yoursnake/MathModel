clc,clear
in = 0;						% ��ʼʱ��
out = 1065;					% ����ʱ��
t = 0;						% ��ǰʱ��
sNum = 22;					% ��������
carNum = 0;					% �ܳ���
recordNum = 0;				% ��¼��
stage = 1;					% ��ʾ�ڼ��׶�
stair = [30 90 210 690 810 1067];	% �ĸ��׶εĽ���ʱ��
interval = [7.0 4.5 3.0 4.5 3.0 6.5];	% �������
dis = [70 70 75 75 75 70];		% ����ʱ��
T = [];					% ��̬��¼ 1��:����ʱ�� 2��:����ʱ�� 3��:��˫ 4��:��� 5��:���� 6��:������ 7��:������
T2 = [];				% ��̬��¼

hasInit = false;
change = false;	% �Ƿ��л���

while (true) 
	if stage >= 7	% ��ֹ������stageֻ�� 6 ���׶�
		break;
    end

% 	used = false;
% 	% ������������õ��೵����ʽ
% 	if change
% 		change = false;
% 		for i = 1:size(T,1)
% 			used = true;
% 			if current_record(1) >= T(i,2) & T(i,5) < carLimit(1) & T(i,3) == 1 & T(i,5) <= 3
% 				T(i,:) = [t calcStop1(t) T(i,3) T(i,4) T(i,5)+1 T(i,6) T(i,7)+1];
% 				recordNum = recordNum + 1;
% 				T2(recordNum,:) = T(i,:);
%                 break;
% 			end
% 		end
% 	end
% 	% ����ڻ�����ʹ���˵������������˴�ѭ�������ûʹ����һ�����̽���
% 	if used
% 		continue;
% 	end

% 	% ����е�����������߷�ʱ�䣬�Ȱѵ������ŵ�
% 	if hasInit == false & t >= stair(2)-dis(2) & t <= stair(3)-dis(3)
% % 		if sNum <= 20
% 			for i = 1:sNum
% 				hasInit = true;
% 				carNum = carNum + 1;
% 				T(carNum,:) = [t calcStop1(t) 1 carNum 1 1 0];
% 				recordNum = recordNum + 1;
% 				T2(recordNum,:) = T(carNum,:);
% 				t = t + interval(stage);
% 				if (t >= stair(stage))
% 					stage = stage + 1; % ��� t ���ڵ�ǰ�׶ε��ٽ�ֵ����׶� + 1
% 				end
% 			end
% % 		end
% 	end

	current_record = [t calcStop2(t)];
	hasAdd = false;
	% ���ʱ�䷢������������߷壬�������е��������õ�������
	if (t >= stair(4)-dis(4) & t < stair(5) || t >= stair(2) & t < stair(3)) 
		for i = 1:size(T,1)	
			if current_record(1) >= T(i,2) & T(i,5) < carLimit(1) & T(i,3) == 1
				hasAdd = true;
				if isMorning(t)	% ��������磬�ͼ�����İ��
					T(i,:) = [t calcStop1(t) T(i,3) T(i,4) T(i,5)+1 T(i,6)+1 T(i,7)];
					recordNum = recordNum + 1;	
					T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
				else 	% ��������磬�ͼ�����İ��
					T(i,:) = [t calcStop1(t) T(i,3) T(i,4) T(i,5)+1 T(i,6) T(i,7)+1];
					recordNum = recordNum + 1;
					T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
				end
				break;
			end
		end
	end

	% ����Ѿ���ӹ���¼�����������ѭ��
	if hasAdd == true
		t = t + interval(stage);
		if (t >= stair(stage))
			stage = stage + 1; % ��� t ���ڵ�ǰ�׶ε��ٽ�ֵ����׶� + 1
		end
		continue;
	end

	isNeedCar = true;	% �ȼ�����Ҫ�ӳ�
	% hasAdd = false;		% ��ʾ�Ƿ��Ѿ���Ӽ�¼
	maxCha = -1;
	minCha = 100;
	temp = 0;
	for i = 1:size(T,1)
		if current_record(1) >= T(i,2) & T(i,5) < carLimit(T(i,3))
			isNeedCar = false;
			% ������С��ֵ������¼��������С��ֵ�ļ�¼��
			% Cha = carLimit(T(i,3)) - T(i,5);
			% if maxCha <= Cha
			% 	maxCha = Cha;
			% 	temp = i;
			% end
			Cha = t - T(i,2);
			if maxCha <= Cha
				maxCha = Cha;
				temp = i;
			end
		end
	end

	% % isNeedCar = true;	% �ȼ�����Ҫ�ӳ�
	% for i = 1:size(T,1)	% �������еĶ�̬��¼
	% % �����ǰʱ�����ڶ�̬��¼���ҵ����ڽ���ʱ�̵ļ�¼���Ұ��δ������
	% % �����г��������ã������������¼������������¼��ӵ���̬��¼��
 %        if current_record(1) >= T(i,2) & T(i,5) < carLimit(T(i,3)) & T(i,3) == 2
	% 		% ����Ѿ���ӹ����򿴵�ǰ���ݵ��������ľ���ֵ�Ƿ����ӵļ�¼��С
	% 		% ���С����¼�¼
	% 		isNeedCar = false;
	% 		if isChange(T(i,6)+1)	% ����Ǽ�����λ��࣬�����ʱ�� +20
	% 			change = true;
	% 			T(i,:) = [t calcStop2(t)+20 T(i,3) T(i,4) T(i,5)+1 T(i,6)+1 T(i,7)];
	% 			recordNum = recordNum + 1;	
	% 			T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
	% 		elseif isChange(T(i,6))	% ����Ѿ�����
	% 			T(i,:) = [current_record T(i,3) T(i,4) T(i,5)+1 T(i,6) T(i,7)+1];
	% 			recordNum = recordNum + 1;
	% 			T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
 %            else    % ���������
 %                T(i,:) = [current_record T(i,3) T(i,4) T(i,5)+1 T(i,6)+1 T(i,7)];
	% 			recordNum = recordNum + 1;
	% 			T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
	% 		end
	% 		break;
	% 	end
	% 	if current_record(1) >= T(i,2) & T(i,5) < 3 & T(i,3) == 1
	% 		% ����Ѿ���ӹ����򿴵�ǰ���ݵ��������ľ���ֵ�Ƿ����ӵļ�¼��С
	% 		% ���С����¼�¼
	% 		isNeedCar = false;
	% 		T(i,:) = [t calcStop1(t) T(i,3) T(i,4) T(i,5)+1 T(i,6) T(i,7)+1];
	% 		recordNum = recordNum + 1;
	% 		T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
	% 		break;
	% 	end
		
	% end

	% ���û�г��������ã������һ����̬��¼������������¼���۵���̬��¼��
	if isNeedCar 
        if (t >= stair(4) & t < stair(5) || t >= stair(2)+10 & t < stair(3)) && length(find(T(:,3)==1)) <= sNum
        	carNum = carNum + 1;
        	T(carNum,:) = [t calcStop1(t) 1 carNum 1 1 0];
      		recordNum = recordNum + 1;	
			T2(recordNum,:) = T(carNum,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
        else
			carNum = carNum + 1;
			T(carNum,:) = [t calcStop2(t) 2 carNum 1 1 0];
			recordNum = recordNum + 1;	
			T2(recordNum,:) = T(carNum,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
		end
		% if isMorning(t)
		% 	T(carNum,:) = [t calcStop2(t) 2 carNum 1 1 0];
		% 	recordNum = recordNum + 1;	
		% 	T2(recordNum,:) = T(carNum,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
		% else
		% 	T(carNum,:) = [t calcStop2(t) 2 carNum 1 0 1];
		% 	recordNum = recordNum + 1;	
		% 	T2(recordNum,:) = T(carNum,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
		% end
	else
		for i = 1:size(T,1)	% �������еĶ�̬��¼
	% �����ǰʱ�����ڶ�̬��¼���ҵ����ڽ���ʱ�̵ļ�¼���Ұ��δ������
	% �����г��������ã������������¼������������¼��ӵ���̬��¼��
        	if current_record(1) >= T(i,2) & T(i,5) < carLimit(T(i,3)) & temp == i
				% ����Ѿ���ӹ����򿴵�ǰ���ݵ��������ľ���ֵ�Ƿ����ӵļ�¼��С
				% ���С����¼�¼
				isNeedCar = false;
				if isChange(T(i,6)+1)	% ����Ǽ�����λ��࣬�����ʱ�� +20
					change = true;
					T(i,:) = [t calcStop2(t)+20 T(i,3) T(i,4) T(i,5)+1 T(i,6)+1 T(i,7)];
					recordNum = recordNum + 1;	
					T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
				elseif isChange(T(i,6))	% ����Ѿ�����
					T(i,:) = [current_record T(i,3) T(i,4) T(i,5)+1 T(i,6) T(i,7)+1];
					recordNum = recordNum + 1;
					T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
        	    else    % ���������
        	        T(i,:) = [current_record T(i,3) T(i,4) T(i,5)+1 T(i,6)+1 T(i,7)];
					recordNum = recordNum + 1;
					T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
				end
				break;
			end
			if current_record(1) >= T(i,2) & T(i,5) < 3 & T(i,3) == 1
				% ����Ѿ���ӹ����򿴵�ǰ���ݵ��������ľ���ֵ�Ƿ����ӵļ�¼��С
				% ���С����¼�¼
				isNeedCar = false;
				T(i,:) = [t calcStop1(t) T(i,3) T(i,4) T(i,5)+1 T(i,6) T(i,7)+1];
				recordNum = recordNum + 1;
				T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
				break;
			end
		end
	end

	% else
	% 	for i = 1:size(T,1)	% �������еĶ�̬��¼
	% 	% �����ǰʱ�����ڶ�̬��¼���ҵ����ڽ���ʱ�̵ļ�¼���Ұ��δ������
	% 	% �����г��������ã������������¼������������¼��ӵ���̬��¼��
	% 		if current_record(1) >= T(i,2) & T(i,5) < carLimit(T(i,3)) & i == temp & T(i,3) == 2
	% 			% ����Ѿ���ӹ����򿴵�ǰ���ݵ��������ľ���ֵ�Ƿ����ӵļ�¼��С
	% 			% ���С����¼�¼
				
	% 			if isMorning(t)	% ��������磬�ͼ�����İ��
	% 				T(i,:) = [current_record T(i,3) T(i,4) T(i,5)+1 T(i,6)+1 T(i,7)];
	% 				recordNum = recordNum + 1;	
	% 				T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
	% 			else 	% ��������磬�ͼ�����İ��
	% 				T(i,:) = [current_record T(i,3) T(i,4) T(i,5)+1 T(i,6) T(i,7)+1];
	% 				recordNum = recordNum + 1;
	% 				T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
	% 			end
	% 			break;
	% 		end
	% 	end
		

	% fprintf('1\n');
	t = t + interval(stage);	% ÿ�μ�һ��ʱ����
	if (t >= stair(stage))
		stage = stage + 1; % ��� t ���ڵ�ǰ�׶ε��ٽ�ֵ����׶� + 1
	end
end

carNum