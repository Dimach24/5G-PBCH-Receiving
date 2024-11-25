function [pbch,dmrs]=parseSsb(rg,symbols_offset,subcarriers_offset,NCellId)
            % extracts pbch bitstream and dmrs complex 
            % amplitudes from the resource grid
            nu=mod(NCellId,4);

            % indexes of PBCH DM-Rs
            dmrs13index=(0:4:236)+nu; 
            dmrs2index=[(0:4:44)+nu, (192:4:236)+nu];
            % indexes of PBCH DM-RS
            pbch13index = setdiff(0:239,dmrs13index);
            pbch2index  = setdiff([0:47 192:239],dmrs2index);
            
            rg=rg(subcarriers_offset+1:subcarriers_offset+240 ...
                ,symbols_offset+2:symbols_offset+4);
            % 144 elements of dm-rs
            dmrs=[rg(dmrs13index+1,1); rg(dmrs2index+1,2); rg(dmrs13index+1,3)];
            % 540 elements of pbch
            pbch=[rg(pbch13index+1,1); rg(pbch2index+1,2); rg(pbch13index+1,3)];
            
            % converting into bitstream
            pbch=qpskDemodulation(pbch);
        end