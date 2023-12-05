use std::collections::VecDeque;

#[derive(Debug)]
pub struct Node(pub f64);

#[derive(Debug)]
pub struct Stack(pub VecDeque<Node>);

impl Stack {
    pub fn new() -> Stack {
        Stack(VecDeque::new())
    }

    pub fn push(&mut self, node: Node) {
        self.push(node);
    }

    pub fn pop(&mut self) -> Option<Node> {
        self.pop()
    }

    pub fn len(&self) -> usize {
        self.len()
    }

    pub fn is_empty(&self) -> bool {
        self.is_empty()
    }
}

use std::convert::From;

impl From<f64> for Node {
    fn from(item: f64) -> Self {
        Node(item)
    }
}
