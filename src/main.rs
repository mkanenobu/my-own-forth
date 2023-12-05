mod eval;
mod stack;
mod word;

fn main() {
    let mut forth = eval::Evaluator::new();

    loop {
        print!("> ");

        let mut input = String::new();
        std::io::stdin().read_line(&mut input).unwrap();

        let input: Vec<&str> = input.trim().split_ascii_whitespace().collect();

        forth.eval(input).unwrap();
    }
}
