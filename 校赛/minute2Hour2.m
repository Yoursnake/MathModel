function [ hour ] = minute2Hour2( minute )
%UNTITLED15 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    m = mod(minute,60);
    s = (m - floor(m)) * 60 / 10000;
    m = floor(m);
    temp = floor((m+30)/60);
    m = mod(m+30,60);
    m = m / 100;
    h = floor(minute / 60) + 4;
    h = temp + h;
    hour = h + m + s;

end

