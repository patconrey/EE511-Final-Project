function [y, t] = modulb( binary_sequence, dr, sr, line_code)
%
%  This function generates a sample line codes signals from an
%  input binary sequence.  The function syntax is as follows:
%
%   [y, t] = modulb( binary_sequence, dr, sr, line_code_name)
%   
% where inputs are:
%   binary_sequence => vector of 1's and 0's repressenting the output of 
%                      a binary source.
%   dr              => source data rate in bits per second
%   sr              => sampling rate of output line codes in samples per second 
%   line_code       => string idenifying the type of output code.  It can
%                      be chosen amoung the following supported options:
%                      unipolar_nrz, bipolar_nrz, 4level_nrz, bipolar_rz, 
%                      unipolar_rz, ami, manchester, miller, 
%                      unipolar_nyquist, bipolar_nyquist,
%   The output is vector Y, which is the waveform represnting the line code
%   and optional output T is the associated time axis.
%
% Initial function written by Sebastien Roy 1998 modified by Kevin Donohue
% 2007 (donohue@engr.uky.edu
%


%  Signal length for single bit
len= (sr/dr);
%y=zeros(1,factor);  %  Initalize output vectors

if strcmp(line_code,'unipolar_nrz')
    for i=0:max(size(binary_sequence))-1
        factor1 = round(len*i);
        factor2 = round(len*(i+1));
		if binary_sequence(i+1)==0
			y(factor1+1:factor2)= zeros(1,(factor2-factor1));
		else
			y(factor1+1:factor2)=ones(1,(factor2-factor1));
		end
	end
elseif strcmp(line_code,'bipolar_nrz')
	for i=0:max(size(binary_sequence))-1
        factor1 = round(len*i);
        factor2 = round(len*(i+1));
		if binary_sequence(i+1)==0
			y(factor1+1:factor2)=ones(1,(factor2-factor1))*(-1);
		else
			y(factor1+1:factor2)=ones(1,(factor2-factor1));
		end
	end
elseif strcmp(line_code,'4level_nrz')
	for i=0:max(size(binary_sequence))-1
        factor1 = round(len*i);
        factor2 = round(len*(i+1));
		y(factor1+1:factor2)=binary_sequence(i+1).*ones(1,factor2-factor1).*2-3;
	end
elseif strcmp(line_code,'bipolar_rz')
	for i=0:max(size(binary_sequence))-1
        factor1 = round(len*i);
        factor2 = round(len*(i+.5));
        factor3 = round(len*(i+1));
		if binary_sequence(i+1)==0
			y(factor1+1:factor2)=(-1)*ones(1,(factor2-factor1));
			y(factor2+1:factor3)=zeros(1,(factor3-factor2));
		else
			y(factor1+1:factor2)=ones(1,(factor2-factor1));
			y(factor2+1:factor3)=zeros(1,factor3-factor2);
		end
	end
elseif strcmp(line_code,'unipolar_rz')
	for i=0:max(size(binary_sequence))-1
        factor1 = round(len*i);
        factor2 = round(len*(i+.5));
        factor3 = round(len*(i+1));
		if binary_sequence(i+1)==0
			y(factor1+1:factor3)=zeros(1,factor3-factor1);
		else
			y(factor1+1:factor2)=ones(1,factor2-factor1);
			y(factor2+1:factor3)=zeros(1,factor3-factor2);
		end
	end
elseif strcmp(line_code,'ami')
	t=1;
	for i=0:max(size(binary_sequence))-1
        factor1 = round(len*i);
        factor2 = round(len*(i+1));
		if binary_sequence(i+1)==0
			y(factor1+1:factor2)=zeros(1,factor2-factor1);
		else
			y(factor1+1:factor2)=ones(1,factor2-factor1)*t;
			t=t*(-1);
		end
	end
elseif strcmp(line_code,'manchester')
	for i=0:max(size(binary_sequence))-1
        factor1 = round(len*i);
        factor2 = round(len*(i+.5));
        factor3 = round(len*(i+1));
		if binary_sequence(i+1)==1
			y(factor1+1:factor2)=ones(1,factor2-factor1);
			y(factor2+1:factor3)=-1*ones(1,factor3-factor2);
		else
			y(factor1+1:factor2)=-1*ones(1,factor2-factor1);
			y(factor2+1:factor3)=ones(1,factor3-factor2);
		end
	end
elseif strcmp(line_code,'miller')
	t=1; p=0;
	for i=0:max(size(binary_sequence))-1
        factor1 = round(len*i);
        factor2 = round(len*(i+.5));
        factor3 = round(len*(i+1));
		if binary_sequence(i+1)==0
			if p==0
				t=t*(-1);
			end
			p=0;
			y(factor1+1:factor3)=t*ones(1,factor3-factor1);
		else
			p=1;
			y(factor1+1:factor2)=t*ones(1,factor2-factor1);
			y(factor2+1:factor3)=t*(-1)*ones(1,factor3-factor2);
			t=t*(-1);
		end
	end
elseif strcmp(line_code,'bipolar_nyquist')
	for i=0:max(size(binary_sequence))-1
		if binary_sequence(i+1)==0
			y(round((i+0.5)*len))=-1;
		else
			y(round((i+0.5)*len))=1;
		end
    end
    kern = sinc(dr/(sr)*(round(-10*sr/dr):round(10*sr/dr)));
	temp=conv(y,kern);
	y=temp; % (1:end-length(kern)+1);
elseif strcmp(line_code,'unipolar_nyquist')
	for i=0:max(size(binary_sequence))-1
		if binary_sequence(i+1)==0
			y(round((i+0.5)*len))=0;
		else
			y(round((i+0.5)*len))=1;
		end
    end
    kern = sinc(dr/(sr)*(round(-10*sr/dr):round(10*sr/dr)));
	temp=conv(y,kern);
	y=temp; % ((factor-1):end);
else
	error('Unknown line code');
end
t = [0:length(y)-1]/sr;   %  Time axis
