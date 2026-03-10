pub fn gate(bit: bool) -> bool {
    bit
}

pub fn not(bit: bool) -> bool {
    !bit
}

pub fn or(bit1: bool, bit2: bool) -> bool {
    if bit1 || bit2 {
        return true;
    }
    false
}

pub fn and(bit1: bool, bit2: bool) -> bool {
    if bit1 && bit2 {
        return true;
    }
    false
}

pub fn xor(bit1: bool, bit2: bool) -> bool {
    if and(bit1, bit2) {
        return false;
    }
    or(bit1, bit2)
}

pub fn nand(bit1: bool, bit2: bool) -> bool {
    not(and(bit1, bit2))
}

pub fn nor(bit1: bool, bit2: bool) -> bool {
    not(or(bit1, bit2))
}

pub fn xnor(bit1: bool, bit2: bool) -> bool {
    not(xor(bit1, bit2))
}