clc; clear all; close all;
%%
data=load('example.mat');
Lmax_=data.config.Lmax_;
ref_pbch=load('example_pbch.mat','pbch').pbch;
NCellId=data.NCellId;
%%
figure
ssb=data.rg(data.subcarrierOffset:data.subcarrierOffset+240,data.symbolOffset+3:data.symbolOffset+6);
imagesc(abs(ssb));set(gca,'Ydir','reverse')
%%
[pbch,dmrs]=parseSsb(data.rg,data.symbolOffset+2,data.subcarrierOffset,NCellId);
if all(pbch==ref_pbch)
    fprintf(1,'parseSsb:\tpbch is correct\n')
else
    fprintf(2,'parseSsb:\tpbch ERROR\n')
end
ibarSsb=extractIbarSsb_lsb(dmrs,NCellId);
if ibarSsb==0
    fprintf(1,'ibarSsb:\tblock index is correct\n')
else
    fprintf(2,'ibarSsb:\tblock index ERROR, expected `%d` got `%d` \n',0,ibarSsb)
end
% descrambled
pbch=descramblePbch(pbch,NCellId,Lmax_,ibarSsb);
% rate matched
pbch=rateRecovery(pbch);
% decoded and deinterleaved
pbch=polarDecoding(pbch);
% crc detached
[pbch,validation_success]=verifyParity(pbch,"crc24c");
if validation_success
    fprintf(1,'CRC:\t\tCRC is ok\n')
else
    fprintf(2,'CRC:\t\tCRC is NOT OK\n')
end
pld=parsePayload(pbch,Lmax_);
disp("Interpretted data:")
disp(pld)
disp(pld.mib);