function tests=ibarSsbTest
    tests = functiontests(localfunctions);
end
function setupOnce(~)
    cd ./../
end
function teardownOnce(~)  
    cd Tests/
end
function fullPerfectTest(tc)
    for NCellId=0:1007
        for ibarSsb_ref=0:7
            dmrs=nrPBCHDMRS(NCellId,ibarSsb_ref);
            verifyEqual(tc,extractIbarSsb_lsb(dmrs,NCellId),ibarSsb_ref);
        end
    end
end
function shiftTest(tc)
    NCellId=17;
    ibarSsb_ref=3;
    dmrs=nrPBCHDMRS(NCellId,ibarSsb_ref)*exp(1j*pi/8);
    verifyEqual(tc,extractIbarSsb_lsb(dmrs,NCellId),ibarSsb_ref);
    dmrs=nrPBCHDMRS(NCellId,ibarSsb_ref)*exp(1j*1.5);
    verifyEqual(tc,extractIbarSsb_lsb(dmrs,NCellId),ibarSsb_ref);
    dmrs=nrPBCHDMRS(NCellId,ibarSsb_ref)*exp(1j*3);
    verifyEqual(tc,extractIbarSsb_lsb(dmrs,NCellId),ibarSsb_ref);
    for iter =1:100
        dmrs=nrPBCHDMRS(NCellId,ibarSsb_ref)*exp(1j*rand()*2*pi);
        verifyEqual(tc,extractIbarSsb_lsb(dmrs,NCellId),ibarSsb_ref);
    end
end