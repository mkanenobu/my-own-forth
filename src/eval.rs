use super::stack::Stack;
use std::collections::HashMap;

type Operation = fn(&mut Stack) -> Result<(), String>;

struct Dictionary(pub HashMap<String, Operation>);

impl Dictionary {
    pub fn new() -> Self {
        let mut dict: HashMap<String, Operation> = HashMap::new();

        dict.insert("+".to_string(), Evaluator::add);
        dict.insert("-".to_string(), Evaluator::sub);
        dict.insert("*".to_string(), Evaluator::mul);
        dict.insert("/".to_string(), Evaluator::div);
        dict.insert(".s".to_string(), Evaluator::print_stack);
        dict.insert(".".to_string(), Evaluator::pop_and_print);

        Self(dict)
    }
}

struct Evaluator {
    pub stack: Stack,
    pub dict: Dictionary,
}

impl Evaluator {
    pub fn new() -> Evaluator {
        Evaluator {
            stack: Stack::new(),
            dict: Dictionary::new(),
        }
    }
}

impl Evaluator {
    pub fn eval(tokens: Vec<String>) {
        let mut evaluator = Evaluator::new();

        for token in tokens {
            if let Ok(num) = token.parse::<f64>() {
                evaluator.stack.push(num.into());
            } else if let Some(op) = evaluator.dict.0.get(&token) {
                if let Err(err) = op(&mut evaluator.stack) {
                    println!("{}", err);
                }
            } else {
                eprintln!("\'{}\' is not a valid token", token);
            }
        }
    }
}

impl Evaluator {
    pub fn add(stack: &mut Stack) -> Result<(), String> {
        let a = stack.pop().unwrap();
        let b = stack.pop().unwrap();
        stack.push((a.0 + b.0).into());
        Ok(())
    }

    pub fn sub(stack: &mut Stack) -> Result<(), String> {
        let a = stack.pop().unwrap();
        let b = stack.pop().unwrap();
        stack.push((a.0 - b.0).into());
        Ok(())
    }

    pub fn mul(stack: &mut Stack) -> Result<(), String> {
        let a = stack.pop().unwrap();
        let b = stack.pop().unwrap();
        stack.push((a.0 * b.0).into());
        Ok(())
    }

    pub fn div(stack: &mut Stack) -> Result<(), String> {
        let a = stack.pop().unwrap();
        let b = stack.pop().unwrap();
        stack.push((a.0 / b.0).into());
        Ok(())
    }

    pub fn print_stack(stack: &mut Stack) -> Result<(), String> {
        println!("{:?}", stack);
        Ok(())
    }

    pub fn pop_and_print(stack: &mut Stack) -> Result<(), String> {
        println!("{:?}", stack.pop());
        Ok(())
    }
}
