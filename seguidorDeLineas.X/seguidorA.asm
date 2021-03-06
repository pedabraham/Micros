__CONFIG    _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_ON & _WDT_OFF & _INTRC_OSC_NOCLKOUT
    __CONFIG    _CONFIG2, _WRT_OFF & _BOR21V
    LIST P=16F887
    INCLUDE <P16F887.INC>
    ORG 0
    
    REGENT  EQU	0X0C
    
    INICIO 
	    
	BSF	STATUS,RP0
	MOVLW	B'11111111'
	BCF	OPTION_REG,NOT_RBPU
	MOVWF   TRISD
	CLRF	TRISA
	CLRF	TRISD
	CLRF	TRISC
	BCF	STATUS,RP0
	
    SIGUE
	
	BSF	PORTB,7
	BSF	PORTB,6
	BSF	PORTB,5
	BSF	PORTB,4
	
    RC
	MOVF	PORTD,0
	MOVWF	REGENT
	COMF	REGENT,1
	MOVLW	B'1111111'
	SUBWF	REGENT,0
	BTFSC	STATUS,Z
	GOTO	RECTO;igual
	GOTO	SIGUE;diferente
	
    RECTO
	BCF	PORTB,6
	BCF	PORTB,4
	BSF	PORTB,5
	BSF	PORTB,3
	
    
    PIZQ
	MOVF	PORTD,0
	MOVWF	REGENT
	COMF	REGENT,1
	BTFSS	REGENT,2
	GOTO	GIROIZQ
    PDER
	MOVF	PORTD,0
	MOVWF	REGENT
	COMF	REGENT,1
	BTFSS	REGENT,3
	GOTO	GIRODER
	GOTO	RC
	
	GOTO	PIZQ
	
    GIROIZQ
	BSF	PORTB,6
	GOTO	PIZQ
	
    GIRODER
	BSF	PORTB,4
	GOTO	PDER
	
  
	
	END
	


