function tests=payloadTest
    tests = functiontests(localfunctions);
end
function setupOnce(~)
    cd ./../
end

function teardownOnce(~)  
    cd Tests/
end
function testL10(tc)
    pldVec=[
        0                   ... choice
        1 1 1 1 1 0         ... (2^6-2)<<4=SFN_MSB=992
        1                   ... SCSCommon = '30or120'
        1 1 1 0             ... 14 = kssb_lsb
        0                   ... dmrsTypeAPos = 'pos2'
        1 0 1 0 1 1 1 1     ... SIB1 = [10 15]
        1                   ... cellBarred = notBarred
        0                   ... intraFreqq... = allowed
        0                   ... spare
        1 1 1 0             ... 2^4-2     = SFN_LSB=14
        1                   ... Half-frame bir HRF
        1 0 1               ... kssb[4]=16 # ibarSsb[4]=8
        ];
    ref.choiceBit=0;
    ref.SFN=992+14;
    ref.SfnLsb=14;
    ref.halfFrame=1;
    ref.kSsbMsb=16;
    ref.reserved = 0;
    ref.blockIndexMsb=8;
    ref.kSsb=16+14;
    ref.mib.SfnMsb=992;
    ref.mib.ScsType="30or120";
    ref.mib.kSsbLsb=14;
    ref.mib.DMRStypeAPos="pos2";
    ref.mib.sib1cfg.controlResourceSetZero=10;
    ref.mib.sib1cfg.searchSpaceZero=15;
    ref.mib.cellBarred=false;
    ref.mib.intraFreqReselection=true;
    ref.mib.reserved=0;
    res=parsePayload(pldVec,10);
    verifyEqual(tc,res,ref);
end
function testL20(tc)
    pldVec=[
        0                   ... choice
        1 1 1 1 1 0         ... (2^6-2)<<4=SFN_MSB=992
        1                   ... SCSCommon = '30or120'
        1 1 1 0             ... 14 = kssb_lsb
        0                   ... dmrsTypeAPos = 'pos2'
        1 0 1 0 1 1 1 1     ... SIB1 = [10 15]
        1                   ... cellBarred = notBarred
        0                   ... intraFreqq... = allowed
        0                   ... spare
        1 1 1 0             ... 2^4-2     = SFN_LSB=14
        1                   ... Half-frame bir HRF
        1 0 1               ... kssb[4]=16 ibarSsb[5:4]=8
        ];
    ref.choiceBit=0;
    ref.SFN=992+14;
    ref.SfnLsb=14;
    ref.halfFrame=1;
    ref.kSsbMsb=16;
    ref.blockIndexMsb=8;
    ref.kSsb=16+14;
    ref.mib.SfnMsb=992;
    ref.mib.ScsType="30or120";
    ref.mib.kSsbLsb=14;
    ref.mib.DMRStypeAPos="pos2";
    ref.mib.sib1cfg.controlResourceSetZero=10;
    ref.mib.sib1cfg.searchSpaceZero=15;
    ref.mib.cellBarred=false;
    ref.mib.intraFreqReselection=true;
    ref.mib.reserved=0;
    res=parsePayload(pldVec,20);
    verifyEqual(tc,res,ref);
end
function testL64(tc)
    pldVec=[
        0                   ... choice
        1 1 1 1 1 0         ... (2^6-2)<<4=SFN_MSB=992
        1                   ... SCSCommon = '30or120'
        1 1 1 0             ... 14 = kssb_lsb
        0                   ... dmrsTypeAPos = 'pos2'
        1 0 1 0 1 1 1 1     ... SIB1 = [10 15]
        1                   ... cellBarred = notBarred
        0                   ... intraFreqq... = allowed
        0                   ... spare
        1 1 1 0             ... 2^4-2     = SFN_LSB=14
        1                   ... Half-frame bir HRF
        1 0 1               ... kssb[4]=16 ibarSsb[5:4]=8
        ];
    ref.choiceBit=0;
    ref.SFN=992+14;
    ref.SfnLsb=14;
    ref.halfFrame=1;
    ref.kSsbMsb=0;
    ref.blockIndexMsb=40;
    ref.kSsb=14;
    ref.mib.SfnMsb=992;
    ref.mib.ScsType="30or120";
    ref.mib.kSsbLsb=14;
    ref.mib.DMRStypeAPos="pos2";
    ref.mib.sib1cfg.controlResourceSetZero=10;
    ref.mib.sib1cfg.searchSpaceZero=15;
    ref.mib.cellBarred=false;
    ref.mib.intraFreqReselection=true;
    ref.mib.reserved=0;
    res=parsePayload(pldVec,64);
    verifyEqual(tc,res,ref);
end