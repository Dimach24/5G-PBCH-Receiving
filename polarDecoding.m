function out_seq = polarDecoding(bits)
    % polarDecoding Procedure of polar decoding and deinterleving [7.1.4, TS 38.212]
    % [TS 38.212 clause 7.1.4] -> [TS 38.212 clause 5.3.1.2]
    arguments
        bits (1,512) % PolarCode - input coded sequence of bits
    end

    N = 512;        % input sequence length
    K = 56;         % output sequence length
    
    % just algo from 5.3.1.2 of TS 38.212
    % Q_I_N definition table 5.3.1.2-1
    Q_0_Nmax = matfile("ReliabilityAndPolarCodingSeqIndexes.mat").ReliabilityAndPolarSeqIndexes.'; 
    j = 1;
    for i = 1:1024
        if Q_0_Nmax(i)<N
            Q_0_N(j) = Q_0_Nmax(i);
            j=j+1;
            if j > N
                break
            end
        end
    end
    Q_I_N = Q_0_N((end-K+1):end);
    
    % G_N matrix definition
    G_2 = ones(2, 2);
    G_2(1, 2) = 0;
    G_N = G_2;
    Power=log2(N);
    for i=1:Power-1
        G_N = kron(G_2, G_N);
    end
    
    u=mod(bits/G_N,2); % u definiton
    
    % main procedure
    out_seq = zeros(1,56); 
    k=0;
    for n = 0:(N-1)
        if ismember(n, Q_I_N)
            out_seq(k+1) = u(n+1);
            k = k + 1;
            if k > K
                break
            end
        end
    end 
    out_seq=deinterleave(out_seq);
end

function out_seq = deinterleave(bits)
    % deinterleave process of reverse interleaving 
    % after polar decoding [7.1.4, TS 38.212]
    
    arguments
        bits (1,:) % sequence of bits
    end

    % initializing
    K = length(bits);
    out_seq = zeros(1,length(bits));
    INTERLEAVING_PATTERN = [0 2 4 7 9 14 19 20 24 25 26 28 31 34 42 45 ...
    49 50 51 53 54 56 58 59 61 62 65 66 67 69 70 71 72 76 77 81 82 83  ...
    87 88 89 91 93 95 98 101 104 106 108 110 111 113 115 118 119 120   ...
    122 123 126 127 129 132 134 138 139 140 1 3 5 8 10 15 21 27 29 32  ...
    35 43 46 52 55 57 60 63 68 73 78 84 90 92 94 96 99 102 105 107 109 ...
    112 114 116 121 124 128 130 133 135 141 6 11 16 22 30 33 36 44 47  ...
    64 74 79 85 97 100 103 117 125 131 136 142 12 17 23 37 48 75 80 86 ...
    137 143 13 18 38 144 39 145 40 146 41 147 148 149 150 151 152 153  ...
    154 155 156 157 158 159 160 161 162 163]; %TS 38.212 table 5.3.1.1-1
    k = 0;
    for m = 0:163
        if INTERLEAVING_PATTERN(1+m) >= 164 - K
            INTERLEAVING_PATTERN(1+k) = INTERLEAVING_PATTERN(1+m) - (164 - K);
            k = k+1;
        end
    end
    
    % main procedure
    for i = 1:K 
    out_seq(INTERLEAVING_PATTERN(i)+1) = bits(i);
    end
end

