use super::stack::Stack;
use super::word::{builtin_words, Word};
use anyhow::{anyhow, Result};
use std::collections::HashMap;

pub struct Dictionary(pub HashMap<String, Word>);

impl Dictionary {
    pub fn new() -> Self {
        let mut dict: HashMap<String, Word> = HashMap::new();

        dict.insert("+".to_string(), builtin_words::add);
        dict.insert("-".to_string(), builtin_words::sub);
        dict.insert("*".to_string(), builtin_words::mul);
        dict.insert("/".to_string(), builtin_words::div);
        dict.insert(".s".to_string(), builtin_words::print_stack);
        dict.insert(".".to_string(), builtin_words::pop_and_print);

        Self(dict)
    }

    pub fn get(&self, key: &str) -> Option<&Word> {
        self.0.get(key)
    }
}

pub struct Evaluator {
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
    pub fn eval(&mut self, tokens: Vec<&str>) -> Result<()> {
        for token in tokens {
            if let Some(word) = self.dict.get(&token) {
                word(&mut self.stack)?;
            } else if let Ok(num) = token.parse::<f64>() {
                self.stack.push(num.into());
            } else {
                return Err(anyhow!("\'{}\' is not a valid token", token));
            }
        }

        Ok(())
    }
}
