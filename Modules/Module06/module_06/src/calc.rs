use crate::Inputs;
use crate::logical;

pub fn half_adder(bit1: bool, bit2: bool) {
    let sum: bool = logical::xor(bit1, bit2);
    let carry: bool = logical::and(bit1, bit2);

    println!("Result: {} {}", carry, sum);
}

pub fn full_adder(a: bool, b: bool, c: bool) {
    let tmp: bool = logical::xor(a,b);
    let tmp2: bool = logical::and(a, b);
    let tmp3: bool = logical::xor(a, b);

   let sum: bool = logical::xor(tmp, c);
   let carry: bool = logical::or(tmp2, logical::and(tmp3, c));

    println!("Result: {} {}", carry, sum)
}

fn tand(bit1: bool, bit2: bool, bit3: bool) -> bool {
    if bit1 && bit2 && bit3 {
        return true;
    }
    false
}

fn qor(bit1: bool, bit2: bool, bit3: bool, bit4: bool) -> bool {
    if bit1  || bit2  || bit3  || bit4  {
        return true;
    }
    false
}

pub fn multiplexer(inputs: Inputs, s0: bool, s1: bool) -> bool {
    let ns0: bool = logical::not(s0);
    let ns1: bool = logical::not(s1);

    let and1: bool = tand(inputs.i0, ns0, ns1);
    let and2: bool = tand(inputs.i1, ns0, s1);
    let and3: bool = tand(inputs.i2, s0, ns1);
    let and4: bool = tand(inputs.i3, s0, s1);

    qor(and1, and2, and3, and4)
}