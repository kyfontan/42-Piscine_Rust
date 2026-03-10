pub mod logical;

fn main() {
    let bit1: bool = false;
    let bit2: bool = true;

    let tst = logical::nor(bit1, bit2);
    println!("{}", tst);
}


/*
a = true
b = false

and a et b:
if a == true && b == true {
    return true;
}
return false;


not a:
return !a

not(and(a, b)) > true

*/