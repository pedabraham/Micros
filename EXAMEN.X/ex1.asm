__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC
    LIST P=16F84A
    INCLUDE <P16F84A.INC>
    ORG 0
    
SECR    EQU	0X0C
SECD	EQU	0X0D
DIS     EQU	0X0E
     
INICIO
     BSF    STATUS,RP0
     CLRF   TRISA
     CLRF   TRISB
     BCF    STATUS,RP0
     
     CLRF   SECR
     CLRF   SECD
     CLRF   DIS
     ;CLRF   STATUS,C
     MOVLW  D'1'
     MOVWF  SECR
     
CIR
     MOVLW  D'8'
     MOVWF  SECD
A
     CALL   SHOWSEC
     RLF    SECR
     DECFSZ SECD
     GOTO   A
     CALL   CPORT
     RLF    SECR
     GOTO   CIR
   
CPORT
     BTFSS  DIS,0
     GOTO   ALGO   
     BCF    DIS,0
     
     RETURN
ALGO
     BSF    DIS,0
     RETURN
     
SHOWSEC
     MOVF   SECR,0
     MOVWF  PORTB
     MOVF   DIS,0
     MOVWF  PORTA
     ;CALL   TIME
     
     
     RETURN


END
     
     ;Pedro Abraham Moreno Vázquez
     ;Microprocesadores y microcontroladores
     ;Examen 7/04/2017 
     ;Ejercicio 2a