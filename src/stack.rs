#[derive(Debug)]
pub struct Node(pub f64);

impl std::fmt::Display for Node {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "{}", self.0.to_string())
    }
}

#[derive(Debug)]
pub struct Stack(pub Vec<Node>);

impl Stack {
    pub fn new() -> Stack {
        Stack(Vec::new())
    }

    pub fn push(&mut self, node: Node) {
        self.0.push(node);
    }

    pub fn pop(&mut self) -> Option<Node> {
        self.0.pop()
    }

    pub fn len(&self) -> usize {
        self.0.len()
    }

    pub fn is_empty(&self) -> bool {
        self.0.is_empty()
    }
}

use std::convert::From;

impl From<f64> for Node {
    fn from(item: f64) -> Self {
        Node(item)
    }
}

impl std::fmt::Display for Stack {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        let mut stack_str = String::new();

        stack_str.push_str("[");
        for (index, node) in self.0.iter().enumerate() {
            stack_str.push_str(&format!("{}", node));
            if index != self.0.len() - 1 {
                stack_str.push_str(", ");
            }
        }
        stack_str.push_str("]");

        write!(f, "{}", stack_str)
    }
}
