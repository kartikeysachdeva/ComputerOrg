/* Program that converts a binary number to decimal */
           .text               // executable code follows
           .global _start
_start:
            
			MOV    R4, #N
            MOV    R5, #Digits  // R5 points to the decimal digits storage location
			MOV    R6, #10
			MOV    R7, #1
			MOV    R8, #0
            LDR    R4, [R4]     // R4 holds N
            MOV    R0, R4       // parameter for DIVIDE goes in R0

MAINLOOP:   MOV    R1, R6       // Divide By ten
            BL     DIVIDE       //call DIVIDE function 
            STRB   R0, [R5]     //store R0 in R5  
			ADD    R5, R7		//increment R5 by 1 so it points to the next adress
            MOV    R0, R1       //set R0 to R1
            CMP    R0, R8       //compare R0 to 0 since the last number is 090.... 
            BGT    MAINLOOP         
            MOV    R0, #Digits  //Feed R0 in digits since thats your new number 
            LDR    R0, [R0]     //get the value R0

END:        B      END         


/* Subroutine to perform the integer division R0 / 10.
 * Returns: quotient in R1, and remainder in R0 */

DIVIDE:     MOV    R2, #0       //used as a counter (quotient)

CONT:       CMP    R0, R1       //compare 10 to R0 (dividend) because thats what you're dividing it with 
            BLT    DIV_END      //looks at the result from compare so if RO<10 RO=remainder
            SUB    R0, R1       // subtract 10 from dividend everytime 
            ADD    R2, R7       // add 1 to the counter  
            B      CONT         

DIV_END:    MOV    R1, R2       // quotient in R1 (remainder in R0)
            MOV    PC, LR     

N:          .word  653       // the decimal number to be converted

Digits:     .space 4          // storage space for the decimal digits

            .end
