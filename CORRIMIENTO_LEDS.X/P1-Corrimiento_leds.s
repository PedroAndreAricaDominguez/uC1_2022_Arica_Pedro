;_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
;    
;NOMBRE DEL PROYECTO:  P1-Corrimiento_Leds
;DESCRIPCIÓN: Este codigo permite el corrimiento de leds conectados al puerto C, con
;             un retardo de 500 ms en un numero de corrimientos pares
;             y un retardo de 250ms en un numero de corrimientos impares.
;             El corrimiento inicia cuando se presiona el pulsador de la placa
;             una vez y se detiene cuando se vuelve a presionar.
;Frecuencia  = 4MHz
;TCY = 1us
;Fecha:  11/01/2023
;AUTOR: Arica Dominguez Pedro Andre 
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
 OPEN:
    BTFSC   PORTA,3,0	    ;verifica si esta presionado el pulsador PORA=0
    GOTO    APAGADO_INICIAL ;si no esta presionado saltara a apagado 
 ;; Si lo precionamos PORA=0-> salta para encender   
  Leds_on_pares:
    BCF     LATE,0,1	    ;Como el corrimiento es par,Apagamos la led que indica que e impar
    MOVLW   1		    ;iniciamos con uno para hacer la multiplicación
    MOVWF   0X502,a	    ;lo guardamos en este registro
   LOPP:
    ;BANKSEL 0X5h
    RLNCF   0x502,f,a	    ;Rotamo el 1 uno del bit 0 (x2)
    MOVF    0X502,w,a	    
    BANKSEL PORTC
    MOVWF   PORTC,1	    ; Para poder leer el acunlador lo pasamos al PORC
    BSF     LATE,1,1	    ; prendemos la leds que indica que son pares
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSC   PORTA,3,0	    ;Si preionamos PORA=0 SALTA A PARE
    GOTO    Continua_par
    GOTO    PARE_1
   Continua_par:
    BTFSC   0x502,7,0	    ;Verifica si el octavo led ya prendio
    GOTO    Led_on_impar    ;Si esta prendido el octavo lo iguiente es el coorimiento impar 
    RLNCF   0x502,f,a	    ;Si todacia no se a prendido el octavo led seguimos rotando
    MOVF    0X502,w,a
    ;BTFSC   PORTA,3,0; si preionamos PORA=0
    GOTO    LOPP
    ;GOTO    PARE_1
   
    
  Led_on_impar:
    BCF     LATE,1,1	    ;Como el corrimiento es impar,Apagamos el led que indica que es par
    MOVLW   1		    ;iniciamos con uno (00000001) para hacer la rotación 
    MOVWF   0X502,a	    ;lo guardamos en este registro
   LOPP2:
    BANKSEL PORTC	    ; Para poder leer esos bits, el acunlador lo pasamos al PORC
    MOVWF   PORTC,1
    BSF     LATE,0,1
    CALL    Delay_250ms,1
    BTFSC   PORTA,3,0; si preionamos PORA=0
    GOTO    Continua_impar
    GOTO    PARE_2
   Continua_impar:
    BTFSC   0x502,6,0	    ;Verifica si el septimo led ya prendio
    GOTO    Leds_on_pares   ;Si esta prendido lo siguiente es el coorimiento par 
    RLNCF   0x502,f,a
    RLNCF   0x502,f,a	    ;Si todavia no se a prendido seguimos rotando
    MOVF    0X502,w,a
    ;BTFSC   PORTA,3,0; si preionamos PORA=0
    GOTO    LOPP2
    ;GOTO    PARE_2
    
APAGADO_INICIAL:
    CLRF    PORTC,1
    GOTO    OPEN
    
PARE_1:
   RETARDO:
    CALL    Delay_250ms	    ;hacemos un retardo para que logre capturar el pulo y no se alte
    CALL    Delay_250ms
    CALL    Delay_250ms
    CALL    Delay_250ms
   CAPTURA:
    ;Se mantiene lo que esta guardo en el registro 
    MOVF    0X502,w,a
    BANKSEL PORTC
    MOVWF   PORTC,1	    ;leemos lo del regitro hasta detectar otro pulo
    BSF     LATE,1,1
    BTFSC   PORTA,3,0	    ; si preionamos PORA=0
    GOTO    CAPTURA
    GOTO    Continua_par
   
PARE_2:
   RETARDO2:
    ;hacemos un retardo para que logre capturar el pulo y no se alte
    CALL    Delay_250ms
    CALL    Delay_250ms
    CALL    Delay_250ms
    CALL    Delay_250ms
   CAPTURA2: 
    ;Se mantiene lo que esta guardo en el registro 
    MOVF    0X502,w,a
    BANKSEL PORTC
    MOVWF   PORTC,1	    ;leemos lo del regitro hasta detectar otro pulo
    BSF     LATE,0,1
    BTFSC   PORTA,3,0	    ; si preionamos PORA=0
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