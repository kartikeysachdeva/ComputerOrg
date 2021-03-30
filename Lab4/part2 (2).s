/* Program that counts consecutive 1's */

          .text                   // executable code follows
          .global _start                  
_start:                             
          MOV     R3, #TEST_NUM   // load the data word ...
          LDR     R1, [R3]        // into R1
          MOV     R0, #0          // Reset R0
          MOV     R5, #0          // Reset R5, stores the longest string of 1

RUNLOOP:  
          LDR      R1, [R3]      // get the next number
          CMP      R1, #0        //this is the counter 
          BEQ      END           //end if equal to 0 
          BL       ONES			 //call ONES (1)
		  
		  
NEXTRUN:  ADD      R3, #4        //increase count to next word (4 bits - 32 bytes) (4)
          CMP      R5, R0        // is the new result longer? compare it to our longest one yet which is the initial one (R5)
          MOVLT    R5, R0        // Conditional move-> if result R5<R0 put it here otherwise don't 
          B        RUNLOOP       //call RUNLOOP

ONES:     MOV     R0, #0          // R0 will hold the result (2)

ONESLOOP: 
          CMP     R1, #0          // loop until the data contains no more 1's (3)
          BEQ     NEXTRUN
          LSR     R2, R1, #1      // perform SHIFT, followed by AND
          AND     R1, R1, R2      
          ADD     R0, #1          // count the string length so far
          B       ONESLOOP            

END:      B       END             

TEST_NUM: .word   0x103fe00f, 0xffff, 0xff, 0x2cf294f, 0x6591c
          .word   0x4a2707,0xc,0x50a8218,0x01, 0x0

          .end                            
