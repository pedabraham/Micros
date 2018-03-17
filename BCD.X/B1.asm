    __CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC
    LIST P=16F84A
    INCLUDE <P16F84A.INC>
    ORG 0
    
INICIO 
	    
    BSF	    STATUS,RP0
    CLRF    TRISB
    MOVLW   B'00011111'
    MOVWF   TRISA
    BCF	    STATUS,RP0
    
PRIN
    MOVF    PORTA,W
    ANDLW   B'00001111'
    CALL    BCD75
    MOVWF   PORTB
    GOTO    PRIN

BCD75
    ADDWF   PCL,F
    RETLW   3Fh
    RETLW   06h
    RETLW   5Bh
    RETLW   4fh
    RETLW   66h
    RETLW   6Dh
    RETLW   7Dh
    RETLW   47h
    RETLW   7fh
    RETLW   6fh
    RETURN
    END


