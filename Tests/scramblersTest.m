function tests=scramblersTest
    tests = functiontests(localfunctions);
end
function setupOnce(~)
    cd ./../
end

function teardownOnce(~)  
    cd Tests/
end
function payloadScramblerTest(tc)
    NCellId=17;
    for Lmax_=[4,8,10,20]
        for i=1:50
            ref=randi([0 1], 1,32);
            scrambled=descramblePayload(ref,NCellId,Lmax_);
            descrambled=descramblePayload(scrambled,NCellId,Lmax_);
            verifyEqual(tc,ref,descrambled);
        end
    end
end
function pbchScramblerTest(tc)
    NCellId=17;
    for Lmax_=[4,8,10,20]
        for ibarssb=0:min(Lmax_-1,7)
            for i=1:100
                ref=randi([0 1], 1,864);
                scrambled=descramblePbch(ref,NCellId,Lmax_,ibarssb);
                descrambled=descramblePbch(scrambled,NCellId,Lmax_,ibarssb);
                verifyEqual(tc,ref,descrambled);
            end
        end
    end
end