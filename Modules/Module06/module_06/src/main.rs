pub mod logical;
pub mod calc;

pub struct Inputs {
    i0: bool,
    i1: bool,
    i2: bool,
    i3: bool
}

fn main() {
    let inputs = Inputs {
        i0: false,
        i1: true,
        i2: false,
        i3: true
    };

    let res = calc::multiplexer(inputs, true, true);
    println!("{}", res);
}
