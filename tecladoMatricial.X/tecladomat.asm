__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC
    LIST P=16F84A
    INCLUDE <P16F84.INC>
    ORG 0
    
COLUM	EQU 0X0C
ROW	EQU 0X0D
CEROP	EQU 0X0E
CONTC	EQU 0X0F
CONTMOS	EQU 0X10
JUSTC	EQU 0X11
    
INICIO 
	    
	BSF	STATUS,RP0
	MOVLW	B'00001111'
	BCF	OPTION_REG,NOT_RBPU
	MOVWF   TRISB
	CLRF	TRISA
	BCF	STATUS,RP0
	
	CLRF	CEROP
	
PROGRAMA
	CLRF	CONTMOS
	MOVLW	D'4'
	MOVWF	CONTC
	MOVLW	B'11101111'
	MOVWF	COLUM
CambioDePrueba
	
	MOVF	COLUM,0
	MOVWF	PORTB
	MOVF	PORTB,0
	ANDLW	B'00001111'
	MOVWF	ROW
	
	COMF	ROW,0
	ANDLW	B'00001111'
	MOVWF	ROW
	
	MOVF	ROW,0
	SUBWF	CEROP,0
	BTFSC	STATUS,Z
	
	GOTO	AplicacionDeCambio; SI ES IGUAL
	
	CALL	SHOWLED; DE LO CONTRARIO
	
AplicacionDeCambio
	
	RLF	COLUM
	
	
	MOVLW	D'4'
	ADDWF	CONTMOS,1
	
	DECFSZ	CONTC
	GOTO	CambioDePrueba
	GOTO	PROGRAMA
	
SHOWLED
	
	MOVF	ROW,0
	CALL	NUMBERS
	ADDWF	CONTMOS,0
	MOVWF	JUSTC
	
	CALL	N2
	
	MOVWF	PORTA
	RETURN
	
	
NUMBERS
    ADDWF   PCL,F
    RETLW   D'0';0
    RETLW   D'1';1
    RETLW   D'2';2
    RETLW   D'0';3
    RETLW   D'3';4
    RETLW   D'0';5
    RETLW   D'0';6
    RETLW   D'0';7
    RETLW   D'4';8
    RETURN
    
N2
    ADDWF   PCL,F
    RETLW   D'0';0
    RETLW   D'1';1
    RETLW   D'4';2
    RETLW   D'7';3
    RETLW   D'14';4
    RETLW   D'2';5
    RETLW   D'5';6
    RETLW   D'8';7
    RETLW   D'0';8
    RETLW   D'3';9
    RETLW   D'6';10
    RETLW   D'9';11
    RETLW   D'15';12
    RETLW   D'10';13
    RETLW   D'11';
    RETLW   D'12';
    RETLW   D'13';
    RETURN
	
END
	
	
	
	
	
	
	