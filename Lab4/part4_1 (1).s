.text
.global _start

/* Program that counts consecutive 1's, 0's, and alternating 1's and 0's*/
//Chose to implement this using branches
//Because I found it more technically challenging
              
_start:
        MOV     R2, #TEST_NUM
        LDR        R4, [R2], #4     // Advance memory operation performed, so R4 holds 55555555

        MOV   R0, #0      // result goes into r0
        MOV        R5, #0            // 1s go in r5
        MOV        R6, #0            // 0s go in r6
        MOV        R7, #0            // alternates

NXT_WRD:
        
        LDR   R1, [R2]        // load r2 word into r1
        CMP        R1, #0              // compares to check and see if R1 equals 0
        BEQ        DISPLAY            // if it is equal to 0, print the results

        BL        ONES               // branch link ones - check how many 1s are there
        CMP        R5, R0       // compare r5 and r0
        MOVLT    R5, R0             // if r5 is less than r0, move r0 into r5
        MOV   R0, #0           // restore r0 to default

        LDR   R1, [R2]       // load r2 into r1
        MVN        R1, R1             // make r1 into !r1
        BL        ONES             // calling the ones but count zeroes instead
        CMP        R6, R0       // compare r6 and r0
        MOVLT    R6, R0             // if r6 happens to be less than r0, move r0 into r6
        MOV     R0, #0         // restore r0 to default

        LDR   R3, [R2]       // load r2 word into r3
        EOR        R1, R4, R3     // exclusive or r4 and r3 and put the result in r1
        BL        ONES               // branch link, count the ones
        CMP        R7, R0       // compare r7 and r0
        MOVLT    R7, R0             // if r7 is less an r0, we add r0 to r7

        LDR     R3, [R2]     // load the word r2 into r3
        MVN        R1, R3             // move !r3 into r1
        EOR        R1, R4, R1     // r4 xor r1 and move result into r1
        BL        ONES               // calling the ones but count zeroes instead
        CMP        R7, R0             // compare the 0s and 1s and check and see if we have more of the former
        MOVLT    R7, R0             // If R7 < R0, load R0 -> R7 // if r7 is less than r0, move r0 into r7
        MOV     R0, #0         // restore r0 to default

        ADD        R2, #4             // add 4 to r2
        B        NXT_WRD        // call the next word
//Reqires R1=word, Returns R0=count, Uses R3
ONES:   CMP     R1, #0          // loop until the data contains no more 1's
            MOVEQ   PC, LR
            LSR     R3, R1, #1      // shift r1 by 1 and store in r3
            AND     R1, R1, R3      // add the r1 and r3 and store the result in r1
            ADD     R0, #1          // this counts the length of the string
            B       ONES



/* Subroutine that converts a binary number to decimal */
DIVIDE:     MOV    R2, #0
CONT:       CMP    R0, #10
            BLT    DIV_END
            SUB    R0, #10
            ADD    R2, #1
            B      CONT
DIV_END:    MOV    R1, R2     // quotient in R1 (remainder in R0)
            MOV    PC, LR

/* Subroutine to convert the digits from 0 to 9 to be shown on a HEX display.
 *    Parameters: R0 = the decimal value of the digit to be displayed
 *    Returns: R0 = bit patterm to be written to the HEX display
 */

SEG7_CODE:  MOV     R1, #BIT_CODES
            ADD     R1, R0         // index into the BIT_CODES "array"
            LDRB    R0, [R1]       // load the bit pattern (to be returned)
            MOV     PC, LR

BIT_CODES:  .byte   0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110
            .byte   0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01100111
            .skip   2      // pad with 2 bytes to maintain word alignment

/* code for Part III (not shown) */

/* Display R5 on HEX1-0, R6 on HEX3-2 and R7 on HEX5-4 */
DISPLAY:    LDR     R8, =0xFF200020     // base address of HEX3-HEX0

            MOV     R0, R6              // display R6
            BL      DIVIDE              // ones digit will be in R0; tens
                                        // digit in R1
            MOV     R9, R1              // save the tens digit
            BL      SEG7_CODE
            MOV     R4, R0              // save bit code
            MOV     R0, R9              // retrieve the tens digit, get bit code
            BL      SEG7_CODE
            LSL     R0, #8              // Shift the bit code of the 10's up to make room for the 1's
            ORR     R4, R0              // Move the 1 bits into their spot

            LSL     R4, #16              // Shift the bit code of R6 up to make room for R6
            
            //R5 -> HEX1-0
            MOV     R0, R5              // display R5 on HEX1-0
            BL      DIVIDE              // ones digit will be in R0; tens
                                        // digit in R1
            MOV     R9, R1              // save the tens digit
            BL      SEG7_CODE
            ORR     R4, R0              // save bit code
            MOV     R0, R9              // retrieve the tens digit, get bit
                                        // code
            BL      SEG7_CODE
            LSL     R0, #8              // Shift the bit code of the 10's up to make room for the 1's
            ORR     R4, R0              // Move the 1 bits into their spot

            STR     R4, [R8]            // Move the bits into the HEX register

            //R7 -> HEX5-4
            LDR     R8, =0xFF200030     // base address of HEX5-HEX4

            MOV     R0, R7              // display R7 on HEX5-4
            BL      DIVIDE              // ones digit will be in R0; tens
                                        // digit in R1
            MOV     R9, R1              // save the tens digit
            BL      SEG7_CODE
            ORR     R4, R0              // save bit code
            MOV     R0, R9              // retrieve the tens digit, get bit
                                        // code
            BL      SEG7_CODE
            LSL     R0, #8              // Shift the bit code of the 10's up to make room for the 1's
            ORR     R4, R0              // Move the 1 bits into their spot

            STR     R4, [R8]            // display the number from R7

            B       END

END:        B       END       
								//NUM 1s	NUM 0s	Alternating
TEST_NUM:   .word	0x55555555  //2
			.word   0x103fe00f  //1
			.word   0x0000ffff	//9			8		
		    .word   0x000000ff	//1			3
			.word   0x02cf294f	//1			3
			.word   0x0006591c	//2			3
			.word   0x004a2707	//2			3
			.word   0x0000000c	//2			3
			.word   0x11123456	//2			3
			.word   0x050a8218	//32		0
			.word   0x00000001	//1			31
			.word   0xAAAAAAAA	//1			1		38
			.word   0			
		    
			.end               