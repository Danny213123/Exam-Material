#![allow(non_snake_case,non_camel_case_types,dead_code)]

/*
    Add your functions for lab 7 below. Fuction skeletons with dummy return values 
    are provided, edit them as needed. You may also add additional helper functions. 
    
    Test your code by running 'cargo test' from the lab7 directory.
*/

fn count_peaks(items: &[i32]) -> u32
{
    let mut peaks = 0;

    let mut l = 0;
    let mut m = 1;
    let mut r = 2;

    if items[1] < items[0] {
        peaks += 1;
    }

    if items[items.len() - 1] > items[items.len() - 2] {
        peaks += 1;
    }

    while r < items.len() {
        if items[m] > items[l] && items[m] > items[r] {
            peaks += 1;
        }

        l += 1;
        m += 1;
        r += 1;
    }
    peaks
}
    
fn remove_runs(items: &[i32]) -> Vec<i64> {
    let mut vec_i64: Vec<i64> = vec![];
    if items.is_empty() {
        return vec_i64;
    }
    vec_i64.push(items[0] as i64);
    for element in items.iter() {
        if vec_i64.last() == Some(&(element.clone() as i64)) {
            // do nothing
        } else {
            vec_i64.push(element.clone() as i64);
        }
    }
    vec_i64
}

fn is_prime(num: u32) -> bool {
    if num <= 1 {
        return false;
    }
    for i in 2..=(num as f32).sqrt() as u32 {
        if num % i == 0 {
            return false;
        }
    }
    true
}

fn count_and_remove_primes(items: &mut [u32]) -> u32 {
    let mut count = 0;

    for i in 0..items.len() {
        if is_prime(items[i]) {
            items[i] = 0;
            count += 1;
        }
    }
    count
}

fn safe_squares_rooks(n: u8, rooks: &[(u8, u8)]) -> u32 {
    // Create an n x n matrix filled with 0s
    let mut board = vec![vec![0; n as usize]; n as usize];

    // Plot the rooks to the board
    for (i, j) in rooks.iter() {
        let i = *i as usize;
        let j = *j as usize;
        // Make every row and col that has a rook all 1s
        for k in 0..n {
            board[i][k as usize] = 1;
            board[k as usize][j] = 1;
        }
    }

    // Count all of the zeroes on the board
    let mut count = 0;
    for i in 0..n {
        for j in 0..n {
            if board[i as usize][j as usize] == 0 {
                count += 1;
            }
        }
    }

    count
}

#[cfg(test)]
#[path = "tests.rs"]
mod tests;
