function [ stop_time ] = calcStop1( t )
%UNTITLED13 �˴���ʾ�йش˺�����ժҪ
%   ���㵥�೵��ֹͣʱ��
    if (t >=0 & t<=20)
        stop_time = t + 80;
    elseif (t > 20 & t <= 90)
        stop_time = 15/14*t + 550/7;
    elseif (t > 90 & t <= 735)
    	stop_time = t + 85;
    elseif (t > 735 & t <= 810)
    	stop_time = 14/15 * t + 134;
    elseif (t > 810)
        stop_time = t + 80;
    end

end

