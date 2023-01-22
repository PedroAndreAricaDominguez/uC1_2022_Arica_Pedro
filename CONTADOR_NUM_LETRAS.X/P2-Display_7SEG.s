
;_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
;    
;NOMBRE DEL PROYECTO:  P2-Display de 7 segmentos
;DESCRIPCIÓN:          Este código permite mostrar los valores alfanuméricos(0-9 y A-F) 
;                      en un display de 7 segmentos ánodo común, conectados al puerto
;                      D. Los valores a mostrar serán seleccionados por la siguiente condición:
;                      * Si el botón de la placa no esta presionado, se muestran los valores 
;                        numéricos del 0 al 9.
;                      * Si el botón de la placa se mantiene presionado, se muestran los valores
;                        de A hasta F.
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
  CALL CONFI_OSCC_2,1
  CALL CONFI_PORT_2,1
OPEN:
    BTFSC   PORTA,3,0	    ;verifica si esta presionado el pulsador PORA=0
    GOTO    VALORES_0_9	    ;si no esta presionado saltara a apagado 
   ;; Si lo precionamos PORA=0-> salta para mostrar letras
VALORES_A_F:
 
  Letra_A:
    MOVLW   00001000B	    ;configuración de A en el display 7 segmentos ánodo común
    MOVWF   0x500,a	    ;guardamoS ese valor en el banco 5 regiteo 00
    BANKSEL PORTD
    MOVWF   PORTD,1	    ; Para poder leer el acunlador lo pasamos al PORD
    CALL    Delay_250ms,1   ;Retardo de 1 segundo
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSC   PORTA,3,0	    ; verifica se se adejado de presionar 
    GOTO    VALORES_0_9
  Letra_B:
    MOVLW   00000011B	    ;configuración de B en el display 7 segmentos ánodo común
    MOVWF   0x500,a	    ;guardamo ese valor en el banco 5 regiteo 00
    BANKSEL PORTD
    MOVWF   PORTD,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSC   PORTA,3,0	    ; verifica se se adejado de presionar 
    GOTO    VALORES_0_9
  Letra_C:
    MOVLW   01000110B	    ;configuración de C en el display 7 segmentos ánodo común
    MOVWF   0x500,a	    ;guardamo ese valor en el banco 5 regiteo 00
    BANKSEL PORTD
    MOVWF   PORTD,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSC   PORTA,3,0	    ; verifica se se adejado de presionar 
    GOTO    VALORES_0_9
  Letra_D:
    MOVLW   00100001B	    ;configuración de D en el display 7 segmentos ánodo común
    MOVWF   0x500,a	    ;guardamo ese valor en el banco 5 regiteo 00
    BANKSEL PORTD
    MOVWF   PORTD,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSC   PORTA,3,0; si preionamos PORA=0
    GOTO    VALORES_0_9
  Letra_E:
    MOVLW   00000110B	    ;configuración de E en el display 7 segmentos ánodo común
    MOVWF   0x500,a	    ;guardamo ese valor en el banco 5 regiteo 00
    BANKSEL PORTD
    MOVWF   PORTD,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSC   PORTA,3,0	    ; verifica se se adejado de presionar 
    GOTO    VALORES_0_9
  Letra_F:
    MOVLW   00001110B	    ;configuración de F en el display 7 segmentos ánodo común
    MOVWF   0x500,a	    ;guardamo ese valor en el banco 5 regiteo 00
    BANKSEL PORTD
    MOVWF   PORTD,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1 
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSC   PORTA,3,0	    ; verifica se se adejado de presionar 
    GOTO    VALORES_0_9
    GOTO    Letra_A
  
VALORES_0_9:
 
  Numero_0:
    MOVLW   11000000B	    ;configuración de 0 en el display 7 segmentos ánodo común
    MOVWF   0x500,a	    ;guardamo ese valor en el banco 5 regiteo 00
    BANKSEL PORTD
    MOVWF   PORTD,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSS   PORTA,3,0	    ; verifica se se adejado de presionar 
    GOTO    VALORES_A_F
  Numero_1:
    MOVLW   11111001B	    ;configuración de 1 en el display 7 segmentos ánodo común
    MOVWF   0x500,a	    ;guardamo ese valor en el banco 5 regiteo 00
    BANKSEL PORTD
    MOVWF   PORTD,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSS   PORTA,3,0	    ; verifica se se adejado de presionar 
    GOTO    VALORES_A_F
  Numero_2:
    MOVLW   10100100B	    ;configuración de 2 en el display 7 segmentos ánodo común
    MOVWF   0x500,a	    ;guardamo ese valor en el banco 5 regiteo 00
    BANKSEL PORTD
    MOVWF   PORTD,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSS   PORTA,3,0	    ; verifica se se adejado de presionar 
    GOTO    VALORES_A_F
  Numero_3:
    MOVLW   10110000B	    ;configuración de 3 en el display 7 segmentos ánodo común
    MOVWF   0x500,a	    ;guardamo ese valor en el banco 5 regiteo 00
    BANKSEL PORTD
    MOVWF   PORTD,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSS   PORTA,3,0	    ; verifica se se adejado de presionar 
    GOTO    VALORES_A_F
  Numero_4:
    MOVLW   10011001B	    ;configuración de 4 en el display 7 segmentos ánodo común
    MOVWF   0x500,a	    ;guardamo ese valor en el banco 5 regiteo 00
    BANKSEL PORTD
    MOVWF   PORTD,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSS   PORTA,3,0	    ; verifica se se adejado de presionar 
    GOTO    VALORES_A_F
  Numero_5:
    MOVLW   10010010B	    ;configuración de 5 en el display 7 segmentos ánodo común
    MOVWF   0x500,a	    ;guardamo ese valor en el banco 5 regiteo 00
    BANKSEL PORTD
    MOVWF   PORTD,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSS   PORTA,3,0	    ; verifica se se adejado de presionar 
    GOTO    VALORES_A_F
  Numero_6:
    MOVLW   10000010B	    ;configuración de 6 en el display 7 segmentos ánodo común
    MOVWF   0x500,a	    ;guardamo ese valor en el banco 5 regiteo 00
    BANKSEL PORTD
    MOVWF   PORTD,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
   BTFSS   PORTA,3,0	    ; verifica se se adejado de presionar 
    GOTO    VALORES_A_F
  Numero_7:
    MOVLW   11111000B	    ;configuración de 7 en el display 7 segmentos ánodo común
    MOVWF   0x500,a	    ;guardamo ese valor en el banco 5 regiteo 00
    BANKSEL PORTD
    MOVWF   PORTD,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSS   PORTA,3,0	    ; verifica se se adejado de presionar 
    GOTO    VALORES_A_F
  Numero_8:
    MOVLW   10000000B	    ;configuración de 7 en el display 8 segmentos ánodo común
    MOVWF   0x500,a
    BANKSEL PORTD
    MOVWF   PORTD,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
   BTFSS   PORTA,3,0	    ; verifica se se adejado de presionar 
    GOTO    VALORES_A_F
  Numero_9:
    MOVLW   10011000B	    ;configuración de 7 en el display 9 segmentos ánodo común
    MOVWF   0x500,a	    ;guardamo ese valor en el banco 5 regiteo 00
    BANKSEL PORTD
    MOVWF   PORTD,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTFSS   PORTA,3,0	    ; verifica se se adejado de presionar 
    GOTO    VALORES_A_F
    GOTO    Numero_0
    
CONFI_OSCC_2:  
    BANKSEL OSCCON1
    MOVLW   0x60 
    MOVWF   OSCCON1,1
    MOVLW   0x02 
    MOVWF   OSCFRQ,1
    RETURN
    
CONFI_PORT_2:
    ; Conf. de puertos para los leds de corrimiento
    BANKSEL PORTD   
    CLRF    PORTD,1	;PORTC=0
    BANKSEL LATD
    CLRF    LATD,1	;LATC=1, Leds apagado
    BANKSEL ANSELD
    CLRF    ANSELD,1	;ANSELC=0, Digital
    BANKSEL TRISD
    CLRF    TRISD,1
    ;confi butom
    BANKSEL PORTA
    CLRF    PORTA,1	;
    CLRF    ANSELA,1	;ANSELA=0, Digital
    BSF	    TRISA,3,1	; TRISA=1 -> entrada
    BSF	    WPUA,3,1	;Activo la reistencia Pull-Up
    RETURN    
    
    
    
END inicio  
