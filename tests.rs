#[cfg(test)]
mod tests {
    // we adjust the path to:
    use super::super::{*};

    const T1: [u8; 52] = [1,1,1,1,13,13,13,13,11,11,11,11,12,12,12,12,10,10,10,10,9,9,9,9,7,7,7,7,8,8,8,8,6,6,6,6,5,5,5,5,4,4,4,4,3,3,3,3,2,2,2,2]; 
    const R1: [u8; 52] = [1,1,1,1,13,13,13,13,12,12,12,12,11,11,11,11,10,10,10,10,9,9,9,9,8,8,8,8,7,7,7,7,6,6,6,6,5,5,5,5,4,4,4,4,3,3,3,3,2,2,2,2];
    const T2: [u8; 52] = [1,13,1,13,1,13,1,13,12,11,12,11,12,11,12,11,10,9,10,9,10,9,10,9,8,7,8,7,8,7,8,7,6,5,6,5,6,5,6,5,4,3,4,3,4,3,4,3,2,2,2,2];
    const R2: [u8; 52] = [4,3,2,2,2,2,4,3,4,3,4,3,6,5,6,5,6,5,6,5,8,7,8,7,8,7,8,7,10,9,10,9,10,9,10,9,12,11,12,11,12,11,12,11,1,13,1,13,1,13,1,13];
    const T3: [u8; 52] = [13,1,13,1,13,1,13,1,11,12,11,12,11,12,11,12,9,10,9,10,9,10,9,10,7,8,7,8,7,8,7,8,5,6,5,6,5,6,5,6,3,4,3,4,3,4,3,4,2,2,2,2];
    const R3: [u8; 52] = [4,3,2,2,2,2,4,3,4,3,4,3,6,5,6,5,6,5,6,5,8,7,8,7,8,7,8,7,10,9,10,9,10,9,10,9,12,11,12,11,12,11,12,11,1,13,1,13,1,13,1,13];
    const T4: [u8; 52] = [10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9];
    const R4: [u8; 52] = [1,1,13,12,9,5,11,4,9,3,8,7,7,2,13,10,12,5,10,4,9,6,8,3,1,1,13,12,7,5,11,4,9,3,8,6,7,2,13,10,12,5,11,11,10,8,6,4,6,3,2,2];
    const T5: [u8; 52] = [1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13];
    const R5: [u8; 52] = [1,10,13,8,11,9,8,7,11,8,13,7,13,6,12,6,9,5,8,5,7,4,7,4,11,6,12,10,6,3,2,2,12,5,9,3,10,4,9,2,10,3,5,2,1,1,1,13,12,11,4,3];

    // "Reverse of test case 1 to test war handling"
    const T6: [u8; 52] = [2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,8,8,8,8,7,7,7,7,9,9,9,9,10,10,10,10,12,12,12,12,11,11,11,11,13,13,13,13,1,1,1,1];
    const R6: [u8; 52] = [1,1,1,1,13,13,13,13,12,12,12,12,11,11,11,11,10,10,10,10,9,9,9,9,8,8,8,8,7,7,7,7,6,6,6,6,5,5,5,5,4,4,4,4,3,3,3,3,2,2,2,2];

    // "Test game"
    const T7: [u8; 52] = [6,7,8,12,10,9,11,1,13,13,8,2,5,7,6,10,3,12,3,1,2,9,5,11,4,13,1,9,11,12,5,7,8,4,6,2,13,10,3,9,8,11,1,4,5,3,12,7,2,10,6,4];
    const R7: [u8; 52] = [1,13,12,7,11,6,6,6,4,3,8,3,13,13,11,5,2,2,12,5,5,2,13,11,10,9,9,9,8,4,10,3,8,2,1,12,1,7,7,6,11,10,1,7,10,4,12,9,8,5,4,3];

    // "A game with 52 cards and no wars"
    const T8: [u8; 52] = [1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13];
    const R8: [u8; 52] = [1,10,13,8,11,9,8,7,11,8,13,7,13,6,12,6,9,5,8,5,7,4,7,4,11,6,12,10,6,3,2,2,12,5,9,3,10,4,9,2,10,3,5,2,1,1,1,13,12,11,4,3];

    // "A game with 52 cards and no wars"
    const T9: [u8; 52] = [1,12,11,10,9,8,7,6,5,4,3,2,13,1,12,11,10,9,8,7,6,5,4,3,2,13,1,12,11,10,9,8,7,6,5,4,3,2,13,1,12,11,10,9,8,7,6,5,4,3,2,1];
    const R9: [u8; 52] = [12,12,12,3,4,2,13,7,8,2,13,11,12,4,1,6,6,6,5,2,5,3,9,3,4,2,10,7,7,5,6,5,13,9,9,4,1,11,11,10,8,7,11,8,1,9,10,3,1,10,1,8];

    // "Test game"
    const T10: [u8; 52] = [1,12,13,13,10,3,8,2,10,9,9,11,6,12,11,7,6,7,8,3,5,4,4,1,2,5,2,13,1,11,10,12,6,7,8,4,3,5,13,4,10,9,8,11,6,1,3,12,2,7,4,5];
    const R10: [u8; 52] = [13,4,7,2,6,3,10,9,9,7,2,2,7,6,5,4,1,12,12,11,1,12,1,6,5,4,11,4,4,2,13,11,1,11,8,6,10,8,8,5,13,12,10,9,5,3,13,10,8,7,3,3];


    #[test] fn shuf1() { assert_eq!(deal(&T1), R1); }
    #[test] fn shuf2() { assert_eq!(deal(&T2), R2); }
    #[test] fn shuf3() { assert_eq!(deal(&T3), R3); }
    #[test] fn shuf4() { assert_eq!(deal(&T4), R4); }
    #[test] fn shuf5() { assert_eq!(deal(&T5), R5); }
    #[test] fn shuf6() { assert_eq!(deal(&T6), R6); }
    #[test] fn shuf7() { assert_eq!(deal(&T7), R7); }
    #[test] fn shuf8() { assert_eq!(deal(&T8), R8); }
    #[test] fn shuf9() { assert_eq!(deal(&T9), R9); }
    #[test] fn shuf10() { assert_eq!(deal(&T10), R10); }

}

