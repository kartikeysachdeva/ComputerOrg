            .text
            .global     _start
_start:
            MOV      R1, #LIST               /* Point R1 to the start of the list */
            LDR      R2, [R1]                /* Initialize R2 with the first number */
            ADD      R1, #4                  // Point to next list item
            LDR      R3, [R1]                /* Get the next number */
            ADD      R2, R3
            ADD      R1, #4                  // Point to next list item
            LDR      R3, [R1]                /* Get the next number */
            ADD      R2, R2, R3
            ADD      R1, #4                  // Point to next list item
            LDR      R3, [R1]                /* Get the next number */
            ADD      R2, R2, R3
END:        B        END                     /* Wait here */

LIST:
            .word    10, 20, 30, 40          /* The numbers to be added */
            .end
