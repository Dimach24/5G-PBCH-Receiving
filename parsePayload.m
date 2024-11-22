function pldStruct = parsePayload(bits, Lmax_)
    % parses payload of PBCH
    % returns structure with fields:
    % *SFN
    % *kSSB
    % *mib (which is structure)
    % *blockIndex, etc. 
    arguments
        bits (1,32) {mustBeMember(bits,[0,1])}
        Lmax_ (1,1) {mustBeInteger}             % SSB per half-frame
    end

    % data extraction 
    pldStruct.choiceBit=bits(1);
    % MIB extraction
    pldStruct.mib=ParseMib(bits(2:24));
    
    pldStruct.SfnLsb=sum(2.^(3:-1:0).*bits(25:28));
    pldStruct.SFN=pldStruct.mib.SfnMsb+pldStruct.SfnLsb;
    pldStruct.halfFrame=bits(29);
    if Lmax_==10
        pldStruct.kSsbMsb=2^4*bits(30);
        pldStruct.reserved=[bits(31)];
        pldStruct.blockIndexMsb=2^3*bits(32);
    elseif Lmax_==20
        pldStruct.kSsbMsb=2^4*bits(30);
        pldStruct.blockIndexMsb=2^4*bits(31)+2^3*bits(32);
    elseif Lmax_==64
        pldStruct.kSsbMsb=0;
        pldStruct.blockIndexMsb=2^5*bits(30)+2^4*bits(31)+2^3*bits(32);
    else
        pldStruct.kSsbMsb=2^4*bits(30);
        pldStruct.reserved=bits(31:32);
        pldStruct.blockIndexMsb=0;
    end
    pldStruct.kSsb=pldStruct.kSsbMsb+pldStruct.mib.kSsbLsb;
end
function mib=ParseMib(bits)
    % parses MIB data from a bitstream
    arguments
        bits (1,23) {mustBeMember(bits,[0,1])}
    end
    
    % 'statis' vars
    persistent ScsType DmrsTypeAPositions;
    % 'static' vars initialization
    if isempty(ScsType) || isempty(DmrsTypeAPositions)
        DmrsTypeAPositions=["pos2","pos3"];
        ScsType=["15or60","30or120"];
    end
    
    % exctracting info from bits
    mib.SfnMsb=sum(2.^(9:-1:4).*bits(1:6));
    mib.ScsType=ScsType(bits(7)+1);
    mib.kSsbLsb=sum(2.^(3:-1:0).*bits(8:11));
    mib.DMRStypeAPos=DmrsTypeAPositions(bits(12)+1);
    sib1cfg.controlResourceSetZero=sum(2.^(3:-1:0).*bits(13:16));
    sib1cfg.searchSpaceZero=sum(2.^(3:-1:0).*bits(17:20));
    mib.sib1cfg=sib1cfg;
    mib.cellBarred=bits(21)==0; %zero -- True
    mib.intraFreqReselection=bits(22)==0; %zero -- True
    mib.reserved=bits(23);
end
