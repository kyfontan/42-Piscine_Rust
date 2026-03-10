pub fn gate(bit: bool) -> bool {
    return bit;
}

pub fn not(bit: bool) -> bool {
    return !bit;
}

pub fn or(bit1: bool, bit2: bool) -> bool {
    if bit1 == true || bit2 == true {
        return true;
    }
    return false;
}

pub fn and(bit1: bool, bit2: bool) -> bool {
    if bit1 == true && bit2 == true {
        return true;
    }
    return false;
}

pub fn xor(bit1: bool, bit2: bool) -> bool {
    if and(bit1, bit2) == true {
        return false;
    }
    return or(bit1, bit2);
}

pub fn nand(bit1: bool, bit2: bool) -> bool {
    return not(and(bit1, bit2))
}

pub fn nor(bit1: bool, bit2: bool) -> bool {
    return not(or(bit1, bit2));
}

pub fn xnor(bit1: bool, bit2: bool) -> bool {
    return not(xor(bit1, bit2));
}