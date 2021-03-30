/* Program that counts consecutive 1's */

          .text                   // executable code follows
          .global _start                  
_start:                             
          MOV     R3, #TEST_NUM   // point R3 to the memory adress
          LDR     R1, [R3]        // extract content from the memory adress 
          MOV     R0, #0          // Reset R0 to 0 
          MOV     R5, #0          // Reset R5 to 0 
          MOV     R6, #0          // Reset R6 to 0 
          MOV     R7, #0          // Reset R7 to 0 

RUNLOOP:  
          LDR      R1, [R3]      // get the next number
          CMP      R1, #0        // exit case
          BEQ      END           //if equal end
          BL       ONES          //else call ONES
		  
DONEONES:
          CMP      R5, R0        // Replace if R5 < R0
          MOVLT    R5, R0
          LDR      R1, [R3]      // Reload R1
          BL       ZEROS
		  
DONEZEROS:
          CMP      R6, R0        // Replace if R6 < R0
          MOVLT    R6, R0
          LDR      R1, [R3]      // Reload R1
          BL       ALTERNATE
		  
DONEALTERNATE:
          CMP      R7, R0        // Replace if R7 < R0
          MOVLT    R7, R0
          ADD      R3, #4        // Increment to Next Digit
          B RUNLOOP

ONES:     MOV     R0, #0          // R0 will hold the result

ONESLOOP: 
          CMP     R1, #0          // loop until the data contains no more 1's
          BEQ     DONEONES
          LSR     R2, R1, #1      // perform SHIFT, followed by AND
          AND     R1, R1, R2      
          ADD     R0, #1          // count the string length so far
          B       ONESLOOP            

ZEROS:    MOV     R0, #0
          MVN     R1, R1
		  
ZEROSLOOP:
          CMP     R1, #0          // loop until the data contains no more 1's
          BEQ     DONEZEROS
          LSR     R2, R1, #1      // perform SHIFT, followed by AND
          AND     R1, R1, R2      
          ADD     R0, #1          // count the string length so far
          B       ZEROSLOOP            

ALTERNATE:
          MOV     R0, #0
          EORS    R1, R1, #PATTERN //turns 1 and 0's in 1's so when you do alternate loop it basically counts those ones 

ALTERNATELOOP:
          CMP     R1, #0          // loop until the data contains no more 1's
          BEQ     DONEALTERNATE
          LSR     R2, R1, #1      // perform SHIFT, followed by AND
          AND     R1, R1, R2      
          ADD     R0, #1          // count the string length so far
          B       ALTERNATELOOP            

END:      B       END             

PATTERN:  .word    0x55555555

TEST_NUM: .word   0x103fe00f, 0xffff, 0xff, 0x2cf294f, 0x6591c
          .word   0x4a2707,0xc,0x50a8218,0x01,0x0

          .end                            
