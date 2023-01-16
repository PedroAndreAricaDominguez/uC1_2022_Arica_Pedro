
;_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
;    
;NOMBRE DEL PROYECTO:  P1-Corrimientos
;DESCRIPCIÓN:          Este código permite el corrimiento de leds conectados al puerto C, 
;                      un retardo de 500 ms en un numero de corrimientos pares
;                      y un retardo de 250ms en un numero de corrimientos impares.
;                      El corrimiento inicia cuando se presiona el pulsador de la placa
;                      una vez y se detiene cuando se vuelve a presionar.
;TCY:        1 us
;FECHA:      12/01/2023
;AUTOR:      Arica Dominguez Pedro Andre
;_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
		       
PROCESSOR 18F57Q84
#include"Config.inc"
#include <xc.inc>
#include"Retardos.inc"
	
PSECT inicio, class=CODE, reloc=2
inicio: 
   GOTO Main

PSECT CODE
Main:
   CALL CONFI_OSCC,1
   CALL CONFI_PORT,1
ABIERTO:
    BTFSC   PORTA,3,0; si presionamos PORA=0
    GOTO    APAGADO_INICIAL
    ;PORA=0-> salta para encender   
Leds_on_pares:
    BCF     LATE,0,1
    MOVLW   1
    MOVWF   0X502,a
LOPP:
    RLNCF   0x502,f,a
    MOVF    0X502,w,a
    BANKSEL PORTC
    MOVWF   PORTC,1
    BSF     LATE,1,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSC   PORTA,3,0; si presionamos PORA=0
    GOTO    Continua_par
    GOTO    PARE_1
Continua_par:
    BTFSC   0x502,7,0
    GOTO    Led_on_impar
    RLNCF   0x502,f,a
    MOVF    0X502,w,a
    ;BTFSC   PORTA,3,0; si presionamos PORA=0
    GOTO    LOPP
    ;GOTO    PARE_1
   
    
Led_on_impar:
    BCF     LATE,1,1
    MOVLW   1
    MOVWF   0X502,a
LOPP2:
    BANKSEL PORTC
    MOVWF   PORTC,1
    BSF     LATE,0,1
    CALL    Delay_250ms,1
    BTFSC   PORTA,3,0; si presionamos PORA=0
    GOTO    Continua_impar
    GOTO    PARE_2
Continua_impar:
    BTFSC   0x502,6,0
    GOTO    Leds_on_pares
    RLNCF   0x502,f,a
    RLNCF   0x502,f,a
    MOVF    0X502,w,a
    ;BTFSC   PORTA,3,0; si presionamos PORA=0
    GOTO    LOPP2
    ;GOTO    PARE_2
    
APAGADO_INICIAL:
    CLRF    PORTC,1
    GOTO    ABIERTO
    
PARE_1:
RETARDO:
    CALL    Delay_250ms
    CALL    Delay_250ms
    CALL    Delay_250ms
    CALL    Delay_250ms
CAPTURA:
    MOVF    0X502,w,a
    BANKSEL PORTC
    MOVWF   PORTC,1
    BSF     LATE,1,1
    BTFSC   PORTA,3,0; si presionamos PORA=0
    GOTO    CAPTURA
    GOTO    Continua_par
   
PARE_2:
RETARDO2:
    CALL    Delay_250ms
    CALL    Delay_250ms
    CALL    Delay_250ms
    CALL    Delay_250ms
CAPTURA2: 
    MOVF    0X502,w,a
    BANKSEL PORTC
    MOVWF   PORTC,1
    BSF     LATE,0,1
    BTFSC   PORTA,3,0; si presionamos PORA=0
    GOTO    CAPTURA2
    GOTO    Continua_impar
    
  
CONFI_OSCC:  
    BANKSEL OSCCON1
    MOVLW   0x60 
    MOVWF   OSCCON1,1
    MOVLW   0x02 
    MOVWF   OSCFRQ,1
    RETURN
    
CONFI_PORT:
    ; Conf. de puertos para los leds de corrimiento
    BANKSEL PORTC   
    CLRF    PORTC,1	;PORTC=0
    CLRF    LATC,1	;LATC=0, Leds apagado
    CLRF    ANSELC,1	;ANSELC=0, Digital
    CLRF    TRISC,1	;Todos salidas 
    ; Conf. de leds para visualizar cuando se da el corrimiento par o impar.
    BANKSEL PORTE   
    CLRF    PORTE,1	;PORTC=0
    BCF     LATE,0,1	;LATC=1, Leds apagado
    BCF     LATE,1,1
    CLRF    ANSELE,1	;ANSELC=0, Digital
    CLRF    TRISE,1	;Todos salidas 
    ;confi butom
    BANKSEL PORTA
    CLRF    PORTA,1	;
    CLRF    ANSELA,1	;ANSELA=0, Digital
    BSF	    TRISA,3,1	; TRISA=1 -> entrada
    BSF	    WPUA,3,1	;Activo la reistencia Pull-Up 
    RETURN
    END inicio


