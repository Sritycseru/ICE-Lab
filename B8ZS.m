clc;
clear all;
close all;
data = [1 0 0 0 0 0 0 0 0 1 0 0 0 1];
point = 100;
status = 1;%last non zero -> positive

%Encoded_Signal
%previous one : negative
% 0 -> 0
% 1 -> alternate of last non zero
cnt = 0;
encoded_signal = zeros(1,length(data)*point);
for i=1:length(data)
    if data(i) == 0
        cnt = cnt+1;
    end
    if cnt == 8
        encoded_signal((i-5)*point+1:(i-4)*point) = status;
        encoded_signal((i-4)*point+1:(i-3)*point) = -status;
        encoded_signal((i-2)*point+1:(i-1)*point) = -status;
        encoded_signal((i-1)*point+1:i*point) = status;
        cnt = 0;
    end
    if data(i) == 1
        cnt = 0;
        encoded_signal((i-1)*point+1:i*point) = -status;
        status = -status;
    end
end

%Decoded_Signal
%0 -> 0
%1/-1 -> 1
  
decoded_signal = zeros(1,length(data));
counter = 0;
lastbit = 1;

for i = 1:length(data)*point
  if (i/point)>counter
    counter = counter + 1;
    if encoded_signal(i)==lastbit
      result(counter:counter+4) = 0;
      counter = counter + 4;
    else
      if(encoded_signal(i)==0)
        decoded_signal(counter) = 0;
      else
        decoded_signal(counter) = 1;
        lastbit = -lastbit;
      end
    end
  end
end

encoded_signal(1) = 0;
encoded_signal(length(data)*point) = 0;
size = 0:1/point:length(data)-1/point;
subplot(2,1,1);
plot(size,encoded_signal,'Linewidth', 2);
title('Encoded Signal');
ylim([-3,3]);   
decoded_signal