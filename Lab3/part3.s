/* Program that finds the largest number in a list of integers	*/
            
            .text                   // executable code follows
            .global _start                  
_start:                             
            MOV     R4, #RESULT     // R4 points to result location
            LDR     R0, [R4, #4]    // R0 holds the number of elements in the list
            MOV     R1, #NUMBERS    // R1 points to the start of the list
            BL      LARGE           // copies the address of the next instructions 
            STR     R0, [R4]        // R0 holds the subroutine return value


END:        B       END             //moves the PC to an address specified by label


/* Subroutine to find the largest integer in a list
 * Parameters: R0 has the number of elements in the list
 *             R1 has the address of the start of the list
 * Returns: R0 returns the largest item in the list */

LARGE:   SUBS     R0, #1        // decrement the loop counter
         BEQ      DONE          // if result is equal to 0, branch
         ADD      R1, #4        // point to second data item 
         LDR      R3, [R1]      // get the next number
         CMP      R2, R3        //
         BGE      LARGE         // branch on greater than or equal
         MOV      R2, R3        // update the largest number
         B        LARGE


DONE:    MOV      R0, R2        // store largest number into result location
         MOV      PC, LR
         
RESULT:     .word   0           

N:          .word   7           // number of entries in the list

NUMBERS:    .word   4, 5, 3, 6  // the data
            .word   1, 8, 2                 
                         
            .end                            
