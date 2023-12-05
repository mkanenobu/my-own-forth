use crate::stack::Stack;
use anyhow::Result;

pub type Word = fn(&mut Stack) -> Result<()>;

pub mod builtin_words {
    use crate::stack::Stack;
    use anyhow::{anyhow, Result};

    pub fn add(stack: &mut Stack) -> Result<()> {
        let a = stack.pop().ok_or(anyhow!("Stack underflow"))?;
        let b = stack.pop().ok_or(anyhow!("Stack underflow"))?;
        stack.push((a.0 + b.0).into());
        Ok(())
    }

    pub fn sub(stack: &mut Stack) -> Result<()> {
        let a = stack.pop().ok_or(anyhow!("Stack underflow"))?;
        let b = stack.pop().ok_or(anyhow!("Stack underflow"))?;
        stack.push((a.0 - b.0).into());
        Ok(())
    }

    pub fn mul(stack: &mut Stack) -> Result<()> {
        let a = stack.pop().ok_or(anyhow!("Stack underflow"))?;
        let b = stack.pop().ok_or(anyhow!("Stack underflow"))?;
        stack.push((a.0 * b.0).into());
        Ok(())
    }

    pub fn div(stack: &mut Stack) -> Result<()> {
        let a = stack.pop().ok_or(anyhow!("Stack underflow"))?;
        let b = stack.pop().ok_or(anyhow!("Stack underflow"))?;
        stack.push((a.0 / b.0).into());
        Ok(())
    }

    pub fn print_stack(stack: &mut Stack) -> Result<()> {
        println!("{}", stack);
        Ok(())
    }

    pub fn pop_and_print(stack: &mut Stack) -> Result<()> {
        let el = stack.pop().ok_or(anyhow!("Stack underflow"))?;
        println!("{}", el);
        Ok(())
    }
}
