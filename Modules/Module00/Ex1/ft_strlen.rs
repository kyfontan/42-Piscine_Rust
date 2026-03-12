fn ft_strlen(s: &str) -> u32{
    let mut i: u32 = 0;
    for _char in s.chars() {
        i += 1;
    }
    return i;
}

fn main() {
    let s: &str = "Hello, world!";
    let i: u32 = ft_strlen(s);
    println!("{}", i);
}