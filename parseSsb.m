function [pbch,dmrs]=parseSsb(rg,symbols_offset,subcarriers_offset,NCellId)
            % extracts pbch bitstream and dmrs complex 
            % amplitudes from the resource grid
            
            nu=mod(NCellId,4);

            % subcarrier index initialization 
            d_solid_i=(0:4:236)+nu;
            p_solid_i=0:1:239;
            p_solid_i(d_solid_i+1)=[];

            d_splitted_i=[(0:4:44)+nu, (192:4:236)+nu];
            p_splitted_i=[0:47,192:239];
            p_splitted_i((0:4:92)+nu+1)=[];

            % extraction from the resource grid 
            dmrs=[...
                rg(subcarriers_offset+d_solid_i+1,symbols_offset+1).',...
                rg(subcarriers_offset+d_splitted_i+1,symbols_offset+2).',...
                rg(subcarriers_offset+d_solid_i+1,symbols_offset+3).'...
                ];
            pbch=[...
                rg(subcarriers_offset+p_solid_i+1,symbols_offset+1).',...
                rg(subcarriers_offset+p_splitted_i+1,symbols_offset+2).',...
                rg(subcarriers_offset+p_solid_i+1,symbols_offset+3).'...
                ];
            % converting into bitstream
            pbch=qpskDemodulation(pbch);
        end