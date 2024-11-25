function IbarSsb = extractIbarSsb_lsb(dmrs, NCellId)
    % finds the block index that corresponds to the reference signal

    corr_data=zeros(1,8);
    % correlating signals
    for i=1:8
        corr_data(i)=abs(xcorr(generatePbchDmRs(i,NCellId),dmrs,0,"normalized"));
    end
    % maximum likehood 
    [~,blockIndexLsb]=max(corr_data);
    IbarSsb=blockIndexLsb-1;
end

