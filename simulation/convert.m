hex = '1d92dd';
dec = hex2dec(hex);
bin = dec2bin(dec);
bin = sprintf('%0*s', 21, bin);
disp(['binary value: ', bin]);
int_bits = bin(2);
fractional_bits = bin(3:end);
int_part = bin2dec(int_bits);

if (bin(1) == 1)
    int_part = int_part * -1;
end
fractional_part = bin2dec(fractional_bits);
fractional_part = fractional_part / 2^19;
result = int_part + fractional_part;
fprintf("decimal value: %.20f\n", result);




