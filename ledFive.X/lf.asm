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
PROGRAMA
    MOVF    PORTA,W
    MOVWF   PORTB
    GOTO    PROGRAMA
    END


