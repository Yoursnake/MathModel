clc,clear
in = 0;						% ��ʼʱ��
out = 872;					% ����ʱ��
t = 0;						% ��ǰʱ��
sNum = 0;					% ��������
carNum = 0;					% �ܳ���
recordNum = 0;				% ��¼��
stage = 1;					% ��ʾ�ڼ��׶�
stair = [120 600 720 872];	% �ĸ��׶εĽ���ʱ��
interval = [4.0 9.0 4.0 4.5];	% �������
dis = [80 70 80 75];		% ����ʱ��
T = [];					% ��̬��¼ 1��:����ʱ�� 2��:����ʱ�� 3��:��˫ 4��:��� 5��:���� 6��:������ 7��:������
T2 = [];				% ��̬��¼

hasInit = false;
a = 1;
	
while (true) 
	if stage >= 5	% ��ֹ������stageֻ�� 4 ���׶�
		break;
    end
    
	% ����е������Ȱѵ������ŵ�
	if hasInit == false
		if t <= stair(1)
			if sNum <= 20
				for i = 1:sNum
					hasInit = true;
					carNum = carNum + 1;
					T(i,:) = [t calcOver(t) 1 i 1 1 0];
					recordNum = recordNum + 1;
					T2(recordNum,:) = T(i,:);
					t = t + interval(stage);
					if (t >= stair(stage))
						stage = stage + 1; % ��� t ���ڵ�ǰ�׶ε��ٽ�ֵ����׶� + 1
					end
				end
			end
		end
	end

	current_record = [t calcOver(t)];
	hasAdd = false;	% ��ʾ�Ƿ��õ�������˼�¼
	% ���ʱ�䷢������������߷壬��������õ�������
	if t >= stair(2)-dis(2) & t < stair(3) | t < stair(1)
		for i = 1:size(T,1)	
			if a <= sNum
				if current_record(1) >= T(i,2) & T(i,5) < carLimit(1) & T(i,3) == 2
					hasAdd = true;
					if isMorning(t)	% ��������磬�ͼ�����İ��
						T(i,:) = [current_record T(i,3) T(i,4) T(i,5)+1 T(i,6)+1 T(i,7)];
						recordNum = recordNum + 1;	
						T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
					else 	% ��������磬�ͼ�����İ��
						T(i,:) = [current_record T(i,3) T(i,4) T(i,5)+1 T(i,6) T(i,7)+1];
						recordNum = recordNum + 1;
						T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
					end
				end
				a = a + 1;
				break;
			end
			if current_record(1) >= T(i,2) & T(i,5) < carLimit(1) & T(i,3) == 1
				hasAdd = true;
				if isMorning(t)	% ��������磬�ͼ�����İ��
					T(i,:) = [current_record T(i,3) T(i,4) T(i,5)+1 T(i,6)+1 T(i,7)];
					recordNum = recordNum + 1;	
					T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
				else 	% ��������磬�ͼ�����İ��
					T(i,:) = [current_record T(i,3) T(i,4) T(i,5)+1 T(i,6) T(i,7)+1];
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
	minCha = 6;
	maxCha = -10;
	temp = 0;
	for i = 1:size(T,1)
		if current_record(1) >= T(i,2) & T(i,5) < carLimit(T(i,3)) & T(i,3) == 2
			isNeedCar = false;
			% ��������磬����С��ֵ������¼��������С��ֵ�ļ�¼��
			if isMorning(t)
				Cha = T(i,6)+1 - T(i,7);
				if minCha >= Cha
					minCha = Cha;
					temp = i;
				end
			% ��������磬������ֵ������¼����������ֵ�ļ�¼��
			else
				Cha = T(i,6) - T(i,7)-1;
				if maxCha <= Cha
					maxCha = Cha;
					temp = i;
				end
			end
			
			% % ��������磬ȷ���ȼ�������С�������
			% if ~isMorning(t)
			% 	if T(i,6) > T(i,7)
			% 		temp = i;
			% 	end
			% end
		end
	end
	
	% ���û�г��������ã������һ����̬��¼������������¼���۵���̬��¼��
	if isNeedCar 
         
		carNum = carNum + 1;
		if isMorning(t)
			T(carNum,:) = [t calcOver(t) 2 carNum 1 1 0];
			recordNum = recordNum + 1;	
			T2(recordNum,:) = T(carNum,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
		else
			T(carNum,:) = [t calcOver(t) 2 carNum 1 0 1];
			recordNum = recordNum + 1;	
			T2(recordNum,:) = T(carNum,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
		end
    else
		for i = 1:size(T,1)	% �������еĶ�̬��¼
			% �����ǰʱ�����ڶ�̬��¼���ҵ����ڽ���ʱ�̵ļ�¼���Ұ��δ������
			% �����г��������ã������������¼������������¼��ӵ���̬��¼��
			if current_record(1) >= T(i,2) & T(i,5) < carLimit(T(i,3)) & i == temp & T(i,3) == 2
				% ����Ѿ���ӹ����򿴵�ǰ���ݵ��������ľ���ֵ�Ƿ����ӵļ�¼��С
				% ���С����¼�¼
				
				if isMorning(t)	% ��������磬�ͼ�����İ��
					T(i,:) = [current_record T(i,3) T(i,4) T(i,5)+1 T(i,6)+1 T(i,7)];
					recordNum = recordNum + 1;	
					T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
				else 	% ��������磬�ͼ�����İ��
					T(i,:) = [current_record T(i,3) T(i,4) T(i,5)+1 T(i,6) T(i,7)+1];
					recordNum = recordNum + 1;
					T2(recordNum,:) = T(i,:);	% �������ɵĶ�̬��¼���뾲̬��¼��
				end
				break;
			end
		end
		
	end

	% fprintf('1\n');
	t = t + interval(stage);	% ÿ�μ�һ��ʱ����
	if (t >= stair(stage))
		stage = stage + 1; % ��� t ���ڵ�ǰ�׶ε��ٽ�ֵ����׶� + 1
	end
end

carNum
