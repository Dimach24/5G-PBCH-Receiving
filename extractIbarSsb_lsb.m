function ibarSsb = extractIbarSsb_lsb(dmrs, NCellId)
    % finds the block index that corresponds to the reference signal

    corr_data=zeros(1,8);
    % correlating signals
    for i=0:7
        corr_data(i+1)=abs(xcorr(generatePbchDmRs(i,NCellId),dmrs,0,"normalized"));
    end
    % maximum likehood 
    [~,blockIndexLsb]=max(corr_data);
    ibarSsb=blockIndexLsb-1;
end

