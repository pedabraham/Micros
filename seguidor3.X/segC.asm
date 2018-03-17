__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC & _LVP_OFF
    LIST P=16F877A
    INCLUDE <P16F877A.INC>
    ORG 0
    
    REGENT  EQU	0X20
    
    INICIO 
	    
	BSF	STATUS,RP0
	MOVLW	B'00000011'
	MOVWF   TRISB
	BCF	STATUS,RP0
	CLRF	PORTB
	CLRF	REGENT
	
    SIGUE
	MOVLW	B'01111100'
	MOVWF   PORTB
	
    ;RC
	;MOVF	PORTB,0
	;ANDLW	B'11000000'
	;MOVWF	REGENT
	;OMF	REGENT,1
	;MOVLW	B'0011111'
	;SUBWF	REGENT,0
	;BTFSC	STATUS,Z
	;GOTO	RECTO;igual
	;GOTO	SIGUE;diferente
	
	
	
    PRUEBA
    
	MOVF	PORTB,0
	ANDLW	B'00000011'
	MOVWF	REGENT
	MOVLW	B'00000011'
	SUBWF	REGENT,0
	BTFSC	STATUS,Z
	GOTO	PRUEBA
	
	
    RECTO
	BCF	PORTB,6
	BSF	PORTB,5
	BCF	PORTB,3
	BSF	PORTB,2
	
	
	
    
    PIZQ
	BTFSS	PORTB,0
	BCF	PORTB,4
	BTFSC	PORTB,0
	BSF	PORTB,4
	
	MOVF	PORTB,0
	MOVWF	REGENT
	;COMF	REGENT,1
	BTFSC	REGENT,0
	GOTO	GIROIZQ
    PDER
	MOVF	PORTB,0
	MOVWF	REGENT
	;COMF	REGENT,1
	BTFSC	REGENT,1
	GOTO	GIRODER
	GOTO	PRUEBA
	
	
	
    GIROIZQ
	BSF	PORTB,6
	BCF	PORTB,3
	GOTO	PIZQ
	
    GIRODER
	BSF	PORTB,3
	BCF	PORTB,6
	GOTO	PDER
	
  
	
	END
	








