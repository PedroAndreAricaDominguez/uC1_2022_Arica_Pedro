;_ _ __ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
;    
;NOMBRE DEL PROYECTO:  Secuencia_LEDS
;DESCRIPCIÓN:              Este código permite que al presionarme un botón (placa) 
;                          se inicie una secuencia de un encendido de Leds 
;                          conectados al puerto C, terminada esta, se inicia otra 
;                          secuencia, deteniendose al presionar un pulsador externo
;                          o también se reinicia al también presionarse otro pulsador
;                          conectado.    
;TCY:        1 us
;FECHA:      29/01/2023
;AUTOR:      Arica Dominguez Pedro Andre
;_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
PROCESSOR 18F57Q84
#include "Config.inc"   ;config statements should precede project file includes.*/
#include<xc.inc> 
    
PSECT udata_acs
Conta5:     DS 1    ;reserva 1 byte en acces ram   
Contar:     DS 1    ;reserva 1 byte en acces ram 
Offset:     DS 1    ;reserva 1 byte en acces ram
Verificar:  DS 1    ;reserva 1 byte en acces ram
contador1:  DS 1    ;reserva 1 byte en acces ram
contador2:  DS 1    ;reserva 1 byte en acces ram
  
PSECT BajaPrioridad,class=CODE,reloc=2
BajaPrioridad:
    BTFSS   PIR1,0,0	; ¿Se ha producido la INT0?-->PIR1(0)=1??
    GOTO    Exit1       ; se va a la subrutina Exit1
    BCF	    PIR1,0,0	; limpiamos el flag de la INT0
    GOTO    Iniciar     ; se va a la subrutina Iniciar
Exit1:
    RETFIE         
  
PSECT AltaPrioridad,class=CODE,reloc=2
AltaPrioridad:
    BTFSC   PIR6,0,0	; ¿Se ha producido la INT1?-->PIR6(0)=0??, entonces si se pulso INT1 que genera un valor de 1 en PIR6(0), entonces va a la siguiente instruccion
    GOTO    Captura     ; se va a la subrutina Captura
    BTFSC   PIR10,0,0	; ¿Se ha producido la INT2?-->PIR10(0)=0??, entonces si se pulso INT2 que genera un valor de 1 en PIR10(0) entonces va a la siguiente instruccion
    GOTO    Reinicia
Exit3:  
    RETFIE  
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
        
PSECT CODE 
Main:
    CALL   CONFI_OSC,1   ;Llamamos a la subrutina CONFI_OS
    CALL   CONFI_PORT,1  ;Llamamos a la subrutina CONFI_POR
    CALL   CONFI_PPS,1   ;Llamamos a la subrutina CONFI_PPS
    CALL   CONFI_INTG,1  ;Llamamos a la subrutina CONFI_INTG
    
Toggle_Led:
    BANKSEL LATF            ;Llamamos a LATF
    BTG	    LATF,3,0	    ;Complemento de LATF(3)
    CALL    Delay_250ms,1   ;Llamamos a la subrutina Delay_250ms
    CALL    Delay_250ms,1   
    BTG	    LATF,3,0	    ;Cambiar el LATF(3)
    CALL    Delay_250ms,1   
    CALL    Delay_250ms,1   
    GOTO    Toggle_Led	    ;se va a la subrutina Toggle_Led
Iniciar:
    MOVLW   5             ; (W)= 5
    MOVWF   Conta5,0	  ; (W)-->Conta5, conta5: # de repeticiones de la secuencia de leds 
    MOVLW   0             ; (W)=0
    MOVWF   Verificar,0	  ; (W)-->Verificar, este valor nos sirve para hacer la captura de leds y el reinicio 
    GOTO    Siguiente     ; se va a la subrutina Siguiente  
    
    
;Pasos para implementar en Conputed Goto
;   1.Escribir el byte superior en PCLATU
;   2.Escribir el byte alto en PCLATH
;   3.Escribir el byte bajo en PCL
; NOTA: El offset debe ser multiplicado *2 para el alineamiento en memoria
Loop: 
    BANKSEL PCLATU                ; Nos ubicamos en el banco de PCLATU
    MOVLW   low highword(Table)   ; (W)=low highword(Table), Cargar el byte superior (CPU)
    MOVWF   PCLATU,1              ; (W)-->PCLATU , Escribir el byte superior a PCLATU 
    MOVLW   high(Table)           ; (W -->high(Table), cargar el byte alto (PCH)
    MOVWF   PCLATH,1              ; (W)-->PCLATH, Escribir el byte alto en PCLATH
    RLNCF   Offset,0,0            ; realizamos una rotacion de izquierda a derecha del offset
    CALL    Table                 ; Llamamos a la subrutina Table 
    MOVWF   LATC,0                ; (W)-->LATC
    CALL    Delay_250ms           
    DECFSZ  Contar,1,0            ; Decrementa en menos uno a Contar, y si este es igual a 0, entonces hace un salto 
    GOTO    SecuenOff             ; se va a la subrutina SecuenOff    
    GOTO    Apagado               ; se va a la subrutina Apagado
SecuenOff:
    INCF    Offset,1,0            ; Incrementa en uno mas al Ofsset
    BTFSS   Verificar,1,0         ; si Verificar(1)=1, entonces hace un salto 
    GOTO    Loop                  ; se va a la subrutina Loop
    GOTO    Exit1                 ; se va a la subrutina Exit1 
    
Apagado:
    DECFSZ  Conta5,1,0            ; Decrementa en menos uno a Conta5, y si este es igual a 0, entonces hace un salto 
    GOTO    Siguiente             ; se va a la subrutina Siguiente
    GOTO    Exit1                 ; se va a la subrutina  Exit1 
Siguiente: 
    SETF    LATC,0                
    BSF	    LATF,3,1	          ; LATF(3) tiene un estado de 5V---Led apagado
    MOVLW   10                    ; W=10
    MOVWF   Contar,0	          ;(W)-->Contar,Contar es el numero de las veces que Offset hace
    MOVLW   0x00                  ;(W)=0
    MOVWF   Offset,0           	  ;(W)-->Offset,  
    GOTO    Loop                  ; se va a la subrutina Loop  
    
Table:
    ADDWF   PCL,1,0     ;(W)+PCL
    RETLW   01111110B	; offset: 0 
    RETLW   10111101B	; offset: 1 
    RETLW   11011011B	; offset: 2 
    RETLW   11100111B	; offset: 3 
    RETLW   11111111B	; offset: 4
    RETLW   11100111B	; offset: 5 
    RETLW   11011011B	; offset: 6 
    RETLW   10111101B	; offset: 7 
    RETLW   01111110B	; offset: 8 
    RETLW   11111111B	; offset: 9 
 
Captura:
    BCF	    PIR6,0,0	 ; limpiamos el flag de INT1
    SETF    Verificar,0  ; Verificar = FFh 
    GOTO    Exit3        ; se va a la subrutina Exit3
    
Reinicia:
    BCF	    PIR10,0,0	 ; limpiamos el flag de INT2
    SETF    Verificar,0  ; Verificar = FFh 
    SETF    LATC,0       ; LATC = FFh
    GOTO    Exit3        ; se va a la subrutina Exit3
   

CONFI_OSC:  
    BANKSEL OSCCON1
    MOVLW   0x60	;seleccionamos el bloque del osc interno (HF1NTOSC)con un Div:1
    MOVWF   OSCCON1,1
    MOVLW   0x02	;seleccionamos una frecuencia de Clock = 4 MHz
    MOVWF   OSCFRQ,1
    RETURN
    
CONFI_PORT:

    ;PORTA (RA3,PULSADOR DE LA PLACA)
    BANKSEL PORTA
    CLRF    PORTA,1	;PORTA = 0
    CLRF    ANSELA,1	;ANSELA<7:0> = 0 
    BSF	    TRISA,3,1	;TRISA<3> = 0 
    BSF	    WPUA,3,1	;Activo la reistencia Pull-Up
    
    ;PORTB (RB4--INT1) 
    BANKSEL PORTB
    CLRF    PORTB,1
    BCF     ANSELB,4,1    ; Puerto digital
    BSF     TRISB,4,1     ;TRISB<3> = 0 
    BSF     WPUB,4,1      ; Activamos la resistencia
    
    
    ;Configuracion de PORTC
    BANKSEL PORTC       ;Llamamos a PORTC
    CLRF    PORTC,1	;PORTC = 0
    SETF    LATC,1	;LATC = 0 -- Leds apagado
    CLRF    ANSELC,1	;ANSELC = 0 -- Digital
    CLRF    TRISC,1 
    
    ;PORTF (RF2 Y RF3,INT2 Y LED DE LA PLACA)
    BANKSEL PORTF       ;Llamamos a PORTF
    CLRF    PORTF,1	;PORTF = 0
    CLRF    ANSELF,1	;ANSELF = 0 -- Digital    
    ;RF2---INT2
    BSF     TRISF,2,1   ; Puerto de Entrada 
    BSF     WPUF,2,1    ; Activamos la resistencia
    ;RF3---LED PLACA  
    BSF     LATF,3,1	; LATF(3) tiene un estado de 5V---Led apagado
    BCF     TRISF,3,1   ;Puerto de salida

    RETURN 
    
CONFI_PPS:
    ;Config INT0
    BANKSEL INT0PPS     ;Llamamos a INT0PPS
    MOVLW   0x03        ;(W)=3
    MOVWF   INT0PPS,1	;(W)-->INT0PPS, entonces INT0 --> RA3  
    
    ;Config INT1
    BANKSEL INT1PPS     ;Llamamos a INT1PPS
    MOVLW   0x0C        ;(W)=0x0Ch
    MOVWF   INT1PPS,1   ;(W)-->INT1PPS, entonces INT1 --> RB4
    
    ;Config INT2
    BANKSEL INT2PPS    ;Llamamos a INT2PPS
    MOVLW   0x2A       ;(W)=0x2Ah
    MOVWF   INT2PPS,1  ;(W)-->INT1PPS, entonces INT2 --> RF2
    RETURN
    
;   Secuencia para configurar interrupcion:
;    1. Definir prioridades
;    2. Configurar interrupcion
;    3. Limpiar el flag
;    4. Habilitar la interrupcion
;    5. Habilitar las interrupciones globales
CONFI_INTG:
    BSF	INTCON0,5,0 ; INTCON0<IPEN> = 0 -- Deshabilitar prioridades
    BANKSEL IPR1
    BCF	IPR1,0,1    ; IPR1<INT0IP> = 0 -- INT0 de BAJA prioridad
    BSF	IPR6,0,1    ; IPR6<INT1IP> = 0 -- INT1 de baja prioridad
    BSF	IPR10,0,1    ;IPR10<INT2IP> = 1 -- INT2 de ALTA prioridad
    
    ;Configuracion INT0
    BCF	INTCON0,0,0 ; INTCON0<INT0EDG> = 0 -- INT0 por flanco de bajada
    BCF	PIR1,0,0    ; PIR1<INT0IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE1,0,0    ; PIE1<INT0IE> = 1 -- habilitamos la interrupcion ext
   
    ;Configuracion INT1
    BCF	INTCON0,1,0 ; INTCON0<INT1EDG> = 0 -- INT1 por flanco de bajada
    BCF	PIR6,0,0    ; PIR6<INT1IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE6,0,0    ; PIE6<INT1IE> = 1 -- habilitamos la interrupcion ext1
    
    ;Configuracion INT2
    BCF	INTCON0,2,0 ; INTCON0<INT2EDG> = 0 -- INT2 por flanco de bajada
    BCF	PIR10,0,0    ; PIR10<INT2IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE10,0,0    ; PIE10<INT2IE> = 1 -- habilitamos la interrupcion ext1
    ;Globales
    BSF	INTCON0,7,0 ; INTCON0<GIE/GIEH> = 1 -- habilitamos las interrupciones de forma global
    BSF	INTCON0,6,0 ; INTCON0<GIEL> = 1 -- habilitamos las interrupciones de baja prioridad
    RETURN
    
;Retardos    
Delay_250ms:		    ; 2Tcy -- Call
    MOVLW   250		    ; 1Tcy -- k2
    MOVWF   contador2,0	    ; 1Tcy
; T = (6 + 4k)us	    1Tcy = 1us
Ext_Loop:		    
    MOVLW   249		    ; 1Tcy -- k1
    MOVWF   contador1,0	    ; 1Tcy
Int_Loop:
    NOP			    ; k1*Tcy
    DECFSZ  contador1,1,0   ; (k1-1)+ 3Tcy
    GOTO    Int_Loop	    ; (k1-1)*2Tcy
    DECFSZ  contador2,1,0
    GOTO    Ext_Loop
    RETURN		    ; 2Tcy
END resetVect		    ; 2Tcy   ; 2Tcy	    ; 2Tcy


