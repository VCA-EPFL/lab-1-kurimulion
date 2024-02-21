import Vector::*;

typedef struct {
 Bool valid;
 Bit#(31) data;
 Bit#(4) index;
} ResultArbiter deriving (Eq, FShow);

function Bool isReady (Bit#(1) ready);
	return ready == 1;
endfunction

function ResultArbiter arbitrate(Vector#(16, Bit#(1)) ready, Vector#(16, Bit#(31)) data);
	Maybe#(UInt#(4)) firstReady = findIndex(isReady, ready);

	case (firstReady) matches
		tagged Valid .index:
			return ResultArbiter{valid: True, data: data[index], index: pack(index)};
		tagged Invalid:
			return ResultArbiter{valid: False, data: 0, index: 0};
	endcase
endfunction

