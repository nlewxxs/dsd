hex = '07e9ca';
dec = hex2dec(hex);
bin = dec2bin(dec);
bin = sprintf('%0*s', 21, bin);
neg = (bin(1) == '1');
disp(['binary value: ', bin]);
if (neg)
	c1 = not(bin-'0');
	d=1;
	bin = double(c1);
	dec = bin2dec(num2str(bin));
	dec = dec + 1;
	dec = dec * -1;
else 
	dec = bin2dec(bin); 
end

dec = dec / 2^19;
fprintf("decimal value: %.20f\n", dec);

