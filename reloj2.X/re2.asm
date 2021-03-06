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
UNIDADES_HORAS	    EQU 0X18
DECENAS_HORAS	    EQU 0X19
CONTHU		    EQU 0X1A
CONTHD		    EQU 0X1B
CONTSD2		    EQU	0X1C; HACER LOS CONTADORES COMPLEMENTARIOS DEL LOS CONTADORES RESTANTES
FLAG		    EQU	0X1D
CONTMU2		    EQU 0X1E
CONTMD2		    EQU 0X1F
CONTHU2		    EQU 0X20
CONTHD2		    EQU 0X21    
		
		    
	
INICIO
    BSF	STATUS,RP0
    CLRF	TRISB
    CLRF	TRISA
    BCF	STATUS,RP0


    CLRF	UNIDADES_SEGUNDOS
    CLRF	UNIDADES_MINUTOS
    CLRF	DECENAS_SEGUNDOS
    CLRF	DECENAS_MINUTOS
    CLRF	UNIDADES_HORAS
    CLRF	DECENAS_HORAS
    CLRF	FLAG
    
	
RELOJ
    CLRF	DECENAS_HORAS
    MOVLW	D'2'
    MOVWF	CONTHD
    MOVWF	CONTHD2
RH2    
    MOVLW	D'10'
    MOVWF	CONTHU
    MOVWF	CONTHU2
RH
    MOVLW	D'6'
    MOVWF	CONTMD
    MOVWF	CONTMD2
    CLRF	DECENAS_MINUTOS
RA
    MOVLW	D'10'
    MOVWF	CONTMU
    MOVWF	CONTMU2
    CLRF	UNIDADES_MINUTOS
RB
    MOVLW	D'6'
    MOVWF	CONTSD
    MOVWF	CONTSD2
    CLRF	DECENAS_SEGUNDOS
RC
    MOVLW	D'9'
    MOVWF	CONTSU
    CLRF	UNIDADES_SEGUNDOS
DECS
    INCF	UNIDADES_SEGUNDOS   ;SEGUNDO REG 0C
    CALL	shineForASecond
    DECFSZ	CONTSU
    GOTO	DECS
    
    CLRF	UNIDADES_SEGUNDOS ;SEGUNDOS DECENAS, 0D
    INCF	DECENAS_SEGUNDOS
    DECFSZ	CONTSD
    CALL	shineForASecond
    DECFSZ	CONTSD2
    GOTO	RC
    
    
    CLRF	UNIDADES_SEGUNDOS
    CLRF	DECENAS_SEGUNDOS    ;MINUTOS UNIDADES
    INCF	UNIDADES_MINUTOS
    DECFSZ	CONTMU2
    CALL	shineForASecond
    DECFSZ	CONTMU
    GOTO	RB
    
    CLRF	UNIDADES_SEGUNDOS
    CLRF	DECENAS_SEGUNDOS 
    CLRF	UNIDADES_MINUTOS    ;MINUTOS DECENAS
    INCF	DECENAS_MINUTOS
    DECFSZ	CONTMD2
    CALL	shineForASecond
    DECFSZ	CONTMD
    GOTO	RA
    
    CLRF	UNIDADES_SEGUNDOS
    CLRF	DECENAS_SEGUNDOS 
    CLRF	UNIDADES_MINUTOS 
    CLRF	DECENAS_MINUTOS	    ;HORAS UNIDADES
    INCF	UNIDADES_HORAS 
    DECFSZ	CONTHU2
    CALL	shineForASecond
    DECFSZ	CONTHU
    GOTO	RH
    
    BTFSC	FLAG,0
    GOTO	A
        
    CLRF	UNIDADES_SEGUNDOS
    CLRF	DECENAS_SEGUNDOS 
    CLRF	UNIDADES_MINUTOS 
    CLRF	DECENAS_MINUTOS	
    CLRF	UNIDADES_HORAS	    ;HORAS DECENAS
    INCF	DECENAS_HORAS
    DECFSZ	CONTHD2
    CALL	shineForASecond
    DECFSZ	CONTHD
    GOTO	RH2
   
    MOVLW	D'4'
    MOVWF	CONTHU
    BSF		FLAG,0
    GOTO	RH
    
A
    CLRF	UNIDADES_SEGUNDOS
    CLRF	DECENAS_SEGUNDOS 
    CLRF	UNIDADES_MINUTOS 
    CLRF	DECENAS_MINUTOS
    CLRF	UNIDADES_HORAS
    GOTO	RELOJ

shineForASecond
	MOVLW	D'2';109
	MOVWF	RealT1
TA
	MOVLW	D'2';235
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
	COMF	RCOM,1
	BSF	RCOM,7
	MOVF	RCOM,0
	MOVWF	PORTB
	
	
	MOVLW	B'11101'
	MOVWF	PORTA
	MOVF	DECENAS_SEGUNDOS,0
	CALL	BCDa7S
	MOVWF	RCOM
	COMF	RCOM,1
	BSF	RCOM,7
	MOVF	RCOM,0
	MOVWF	PORTB
	
	
	MOVLW	B'11011'
	MOVWF	PORTA
	MOVF	UNIDADES_MINUTOS,0
	CALL	BCDa7S
	MOVWF	RCOM
	COMF	RCOM,1
	BSF	RCOM,7
	MOVF	RCOM,0
	MOVWF	PORTB
	
	
	MOVLW	B'10111'
	MOVWF	PORTA
	MOVF	DECENAS_MINUTOS,0
	CALL	BCDa7S
	MOVWF	RCOM
	COMF	RCOM,1
	BSF	RCOM,7
	MOVF	RCOM,0
	MOVWF	PORTB
	;DECFSZ	RealT3
	;GOTO	TC
	
	MOVLW	B'01111'
	MOVWF	PORTA
	MOVF	UNIDADES_HORAS,0
	CALL	BCDa7S
	MOVWF	RCOM
	COMF	RCOM,1
	BSF	RCOM,7
	MOVF	RCOM,0
	MOVWF	PORTB
	
	
	MOVLW	B'00000'
	MOVWF	PORTA
	MOVF	DECENAS_HORAS,0
	CALL	BCDa7S
	MOVWF	RCOM
	COMF	RCOM,1
	BCF	RCOM,7
	MOVF	RCOM,0
	MOVWF	PORTB
	
	
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
    
CFLAG
     BTFSS  FLAG,0
     GOTO   ALGO   
     BCF    FLAG,0
     RETURN
ALGO
     BSF    FLAG,0
     RETURN
		
END