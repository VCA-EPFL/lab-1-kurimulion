import Vector::*;

typedef Bit#(16) Word;

function Vector#(16, Word) naiveShfl(Vector#(16, Word) in, Bit#(4) shftAmnt);
    Vector#(16, Word) resultVector = in; 
    for (Integer i = 0; i < 16; i = i + 1) begin
        Bit#(4) idx = fromInteger(i);
        resultVector[i] = in[shftAmnt+idx];
    end
    return resultVector;
endfunction


function Vector#(16, Word) barrelLeft(Vector#(16, Word) in, Bit#(4) shftAmnt);
    Vector#(16, Word) int1, int2, int3, out;

    int1 = shftAmnt[3] == 1 ? naiveShfl(in, 8) : in;
    int2 = shftAmnt[2] == 1 ? naiveShfl(int1, 4) : int1;
    int3 = shftAmnt[1] == 1 ? naiveShfl(int2, 2) : int2;
    out = shftAmnt[0] == 1 ? naiveShfl(int3, 1) : int3;

    return out;
endfunction
