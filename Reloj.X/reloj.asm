    __CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC
    LIST P=16F84A
    INCLUDE <P16F84.INC>
    
    ORG 0
    
   
UNIDADES_SEGUNDOS   EQU 0X0C
DECENAS_SEGUNDOS    EQU 0X0D
UNIDADES_MINUTOS    EQU 0X0E
DECENAS_MINUTOS	    EQU 0X0F
CONTSU		    EQU 0X10
CONTSD		    EQU 0X11
CONTMU		    EQU 0X12
CONTMD		    EQU 0X13
RealT1		    EQU 0X14
RealT2		    EQU 0X15
RealT3		    EQU 0X16
RCOM		    EQU	0X17
	
INICIO
    BSF	STATUS,RP0
    CLRF	TRISB
    CLRF	TRISA
    BCF	STATUS,RP0
	
    CLRF	UNIDADES_SEGUNDOS
    CLRF	UNIDADES_MINUTOS
    CLRF	DECENAS_SEGUNDOS
    CLRF	DECENAS_MINUTOS
	
RELOJ
    MOVLW	D'5'
    MOVWF	CONTMD
    CLRF	DECENAS_MINUTOS
RA
    MOVLW	D'9'
    MOVWF	CONTMU
    CLRF	UNIDADES_MINUTOS
RB
    MOVLW	D'5'
    MOVWF	CONTSD
    CLRF	DECENAS_SEGUNDOS
RC
    MOVLW	D'9'
    MOVWF	CONTSU
    CLRF	UNIDADES_SEGUNDOS
DECS
	
    INCF	UNIDADES_SEGUNDOS   
    CALL	shineForASecond
    DECFSZ	CONTSU
    GOTO	DECS
    
    
    CLRF	UNIDADES_SEGUNDOS
    INCF	DECENAS_SEGUNDOS
    CALL	shineForASecond
    DECFSZ	CONTSD
    GOTO	RC
    
    
    CLRF	DECENAS_SEGUNDOS
    INCF	UNIDADES_MINUTOS
    CALL	shineForASecond
    DECFSZ	CONTMU
    GOTO	RB
    
    CLRF	UNIDADES_MINUTOS
    INCF	DECENAS_MINUTOS
    CALL	shineForASecond
    GOTO	RA
    
    DECFSZ	CONTMD
    GOTO	RA
    GOTO	RELOJ

shineForASecond
	MOVLW	D'109'
	MOVWF	RealT1
TA
	MOVLW	D'235'
	MOVWF	RealT2
TB
;	MOVLW	D'100'
;	MOVWF	RealT3
;    TC
	MOVLW	B'11110'
	MOVWF	PORTA
	MOVF	UNIDADES_SEGUNDOS,0
	CALL	BCDa7S
	MOVWF	RCOM
	COMF	RCOM,0
	MOVWF	PORTB
	MOVLW	B'11101'
	MOVWF	PORTA
	MOVF	DECENAS_SEGUNDOS,0
	CALL	BCDa7S
	MOVWF	RCOM
	COMF	RCOM,0
	MOVWF	PORTB
	MOVLW	B'11011'
	MOVWF	PORTA
	MOVF	UNIDADES_MINUTOS,0
	CALL	BCDa7S
	MOVWF	PORTB
	MOVLW	B'10111'
	MOVWF	PORTA
	MOVF	DECENAS_MINUTOS,0
	CALL	BCDa7S
	MOVWF	PORTB
	;DECFSZ	RealT3
	;GOTO	TC
	DECFSZ	RealT2
	GOTO	TB
	DECFSZ	RealT1
	GOTO	TA
	RETURN
	
BCDa7S
    ADDWF   PCL,F
    RETLW   h'FC';0
    RETLW   h'60';1
    RETLW   h'DA';2
    RETLW   h'F2';3
    RETLW   h'66';4
    RETLW   h'B6';5
    RETLW   h'BE';6
    RETLW   h'E0';7
    RETLW   h'FE';8
    RETLW   h'F6';9
    RETURN
		
END
    

