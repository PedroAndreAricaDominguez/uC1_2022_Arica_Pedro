;_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
;    
;Archivo:  Retardos.inc
;BRIEF: Lo que se hace acontinuación es una librería de retardos de diferentes tiempos.
;Frecuencia a trabajar = 4MHz
;TCY = 1us
;DATE:  08/01/2023
;AUTOR: Arica Dominguez Pedro Andre 
;_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
      

PSECT udata_acs
Contador1: DS 1	    ;Lo que hacemos es reservar 1 bytes en acces RAM 
Contador2: DS 1	    
    
PSECT code
;; Primer Retardo(10us)
    ;T=(6 + 4k)*TCY  
Delay_10us:		    ;  2TCY---CALL
    MOVLW   1               ;  1TCY (El valor que le carguemos a "W" es el valor de "k")
    MOVWF   Contador1,0     ;  1TCY
Delay_Loop_1:   
    NOP                     ;  k*TCY
    DECFSZ  Contador1,1,0   ;  (k-1) + 3*TCY
    GOTO    Delay_Loop_1    ;  (k-1)*2TCY
    RETURN                  ;  2TCY

    
;; Segundo Retardo(25us)
    ;T= (9 + 4*k)*TCY 
Delay_25us:                 ;  2TCY---CALL
    MOVLW   4               ;  1TCY (El valor que le carguemos a "W" es el valor de "k")
    MOVWF   Contador1,0     ;  1TCY
    ;La dos siguientes instrucciones Son un poco absurdas,  
    ;ya que solo las ejecutamos para completar los TCY
    NOP			    ;  1TCY
    GOTO    Delay_Loop_2    ;  2TCY
Delay_Loop_2:
    NOP                     ;  k*TCY
    DECFSZ  Contador1,1,0   ;  (k-1) + 3*TCY
    GOTO    Delay_Loop_2    ;  (k-1)*2TCY
    RETURN                  ;  2TCY
    
    
;; Tercer Retardo(50us)
    ;T= (6 + 4k)*TCY   
Delay_50us:                  ;  2TCY---CALL
    MOVLW   11               ;  1TCY (El valor que le carguemos a "W" es el valor de "k")
    MOVWF   Contador1,0      ;  1TCY
Delay_Loop_3:
    NOP                      ;  k*TCY
    DECFSZ  Contador1,1,0    ;  (k-1) + 3*TCY
    GOTO    Delay_Loop_3     ;  (k-1)*2TCY
    RETURN                   ;  2TCY
    
   
;; Cuarto Retardo(100us)           
    ;T= (8 + 4k)*TCY  
Delay_100us:                 ;  2TCY---CALL
    MOVLW  23                ;  1TCY (El valor que le carguemos a "W" es el valor de "k")
    MOVWF  Contador1,0       ;  1TCY
    ;La  siguiente instruccione es un poco absurda,  
    ;ya que solo la ejecutamos para completar los TCY
    GOTO    Delay_Loop_4    ;   2TCY
Delay_Loop_4:
    NOP                      ;  k*TCY
    DECFSZ Contador1,1,0     ;  (k-1) + 3*TCY
    GOTO   Delay_Loop_4      ;  (k-1)*2TCY
    RETURN                   ;  2TCY   
    
    
;; Quinto Retardo(200us)
    ;T= (8 + 4k)*TCY   
Delay_200us:                 ;  2TCY---CALL
    MOVLW  48                ;  1TCY (El valor que le carguemos a "W" es el valor de "k")
    MOVWF  Contador1,0       ;  1TCY
    ;La  siguiente instruccione es un poco absurda,  
    ;ya que solo la ejecutamos para completar los TCY
    GOTO    Delay_Loop_5    ;   2TCY
Delay_Loop_5:
    NOP                      ;  k*TCY
    DECFSZ Contador1,1,0     ;  (k-1) + 3*TCY
    GOTO   Delay_Loop_5      ;  (k-1)*2TCY
    RETURN                   ;  2TCY
  
    
;; Sexto Retardo (250us)
      ;T=(6+4k)*TCY  
Delay_250us:             ; 2TCY---CALL
    MOVLW  61                ;  1TCY (El valor que le carguemos a "W" es el valor de "k")
    MOVWF  Contador1,0       ;  1TCY
Delay_Loop_6:
    NOP                      ;  k*TCY
    DECFSZ Contador1,1,0     ;  (k-1) + 3*TCY
    GOTO   Delay_Loop_6             ;  (k-1)*2TCY
    RETURN                   ;  2TCY
    

;; Septimo Retardo (500us)
    ;T= (8 + 4k)*TCY    
Delay_500us:                 ;   2TCY---CALL
    MOVLW  123               ;   1TCY (El valor que le carguemos a "W" es el valor de "k")
    MOVWF  Contador1,0       ;   1TCY
    ;La  siguiente instruccione es un poco absurda,  
    ;ya que solo la ejecutamos para completar los TCY
    GOTO   Delay_Loop_7    ;   2TCY
Delay_Loop_7:
    NOP                      ;    k1*TCY
    DECFSZ Contador1,1,0     ;   (k-1) + 3*TCY
    GOTO   Delay_Loop_7      ;   (k-1)*2TCY
    RETURN                   ;   2*TCY

    
;; Octavo Retardo(1ms)
    ;T= (8 + 4k)*TCY  
Delay_1ms:                   ;  2TCY---CALL
    MOVLW  248               ;  1TCY (El valor que le carguemos a "W" es el valor de "k")
    MOVWF  Contador1,0       ;  1TCY
    ;La  siguiente instruccione es un poco absurda,  
    ;ya que solo la ejecutamos para completar los TCY
    GOTO    Delay_Loop_8    ;   2TCY
Delay_Loop_8:
    NOP                      ;  k*TCY
    DECFSZ Contador1,1,0     ;  (k-1) + 3*TCY
    GOTO   Delay_Loop_8      ;  (k-1)*2TCY
    RETURN                   ;  2TCY   

    
;; Noveno Retardo(5ms)
   ;T2= (k1*T1)+(k1+6)*(1us)-(k1*2)*(1us)
    ; T1=(8 + 4k)*(1us)= 1ms
Delay_5ms:                    ;  2TCY---Call
    MOVLW  5                  ;  1TCY ( El valor que le carguemos a "W" es el valor de "k1")
    MOVWF  Contador2,0        ;  1TCY 
Loop_Ext_9:  
    MOVLW  248                ;  k1*TCY.....k=248
    MOVWF  Contador1,0        ;  k1*TCY
    ;La  siguiente instruccione es un poco absurda,  
    ;ya que solo la ejecutamos para acercarno a los "ms" requeridos
    GOTO    Loop_Int_9        ;   2TCY
Loop_Int_9:
    Nop                       ;  k1*k*TCY
    DECFSZ Contador1,1,0      ;  k1*((k-1) + 3*TCY)
    GOTO   Loop_Int_9         ;  k1((k-1)*2TCY)
    DECFSZ Contador2,1,0      ;  (k1-1) + 3*TCY
    GOTO   Loop_Ext_9         ;  (k1-1)*2TCY
    RETURN                    ;  2*TCY   
    
    
;; Decimo Retardo10(10ms)
     ;T2= (k1*T1(us))+k2*(1us)+ 6*(1us)
    ; T1=(6 + 4k)*(1us)= 1ms
Delay_10ms:                   ;  2TCY---Call
    MOVLW  10                 ;  1TCY ( El valor que le carguemos a "W" es el valor de "k1")
    MOVWF  Contador2,0        ;  1TCY 
Loop_Ext_10:  
    MOVLW  249                ;  k1*TCY.....k=249
    MOVWF  Contador1,0        ;  k1*TCY
Loop_Int_10:
    Nop                       ;  k1*k*TCY
    DECFSZ Contador1,1,0      ;  k1*((k-1) + 3*TCY)
    GOTO   Loop_Int_10        ;  k1((k-1)*2TCY)
    DECFSZ Contador2,1,0      ;  (k1-1) + 3*TCY
    GOTO   Loop_Ext_10        ;  (k1-1)*2TCY
    RETURN                    ;  2*TCY 
    

;; Onceavo Retardo(25ms)
     ;T2= (k1*T1(us))+k2*(1us)+ 6*(1us)
    ; T1=(6 + 4k)*(1us)= 1ms
Delay_25ms:                   ;  2TCY---Call
    MOVLW  25                 ;  1TCY ( El valor que le carguemos a "W" es el valor de "k1")
    MOVWF  Contador2,0        ;  1TCY 
Loop_Ext_11:  
    MOVLW  249                ;  k1*TCY.....k=249
    MOVWF  Contador1,0        ;  k1*TCY
Loop_Int_11:
    Nop                       ;  k1*k*TCY
    DECFSZ Contador1,1,0      ;  k1*((k-1) + 3*TCY)
    GOTO   Loop_Int_11        ;  k1((k-1)*2TCY)
    DECFSZ Contador2,1,0      ;  (k1-1) + 3*TCY
    GOTO   Loop_Ext_11        ;  (k1-1)*2TCY
    RETURN                    ;  2*TCY 
 
    
;; DOCEAVO Retardo(50ms)
     ;T2= (k1*T1(us))+k2*(1us)+ 6*(1us)
    ; T1=(6 + 4k)*(1us)= 1ms
Delay_50ms:                   ;  2TCY---Call
    MOVLW  50                 ;  1TCY ( El valor que le carguemos a "W" es el valor de "k1")
    MOVWF  Contador2,0        ;  1TCY 
Loop_Ext_12:  
    MOVLW  249                ;  k1*TCY.....k=249
    MOVWF  Contador1,0        ;  k1*TCY
Loop_Int_12:
    Nop                       ;  k1*k*TCY
    DECFSZ Contador1,1,0      ;  k1*((k-1) + 3*TCY)
    GOTO   Loop_Int_12        ;  k1((k-1)*2TCY)
    DECFSZ Contador2,1,0      ;  (k1-1) + 3*TCY
    GOTO   Loop_Ext_12        ;  (k1-1)*2TCY
    RETURN                    ;  2*TCY 
    
    
;; Treceavo Retardo (100ms)            
;T2= (k1*T1(us))+k2*(1us)+ 6*(1us)
    ; T1=(6 + 4k)*(1us)= 1ms
Delay_100ms:                   ;  2TCY---Call
    MOVLW  100                 ;  1TCY ( El valor que le carguemos a "W" es el valor de "k1")
    MOVWF  Contador2,0        ;  1TCY 
Loop_Ext_13:  
    MOVLW  249                ;  k1*TCY.....k=249
    MOVWF  Contador1,0        ;  k1*TCY
Loop_Int_13:
    Nop                       ;  k1*k*TCY
    DECFSZ Contador1,1,0      ;  k1*((k-1) + 3*TCY)
    GOTO   Loop_Int_13        ;  k1((k-1)*2TCY)
    DECFSZ Contador2,1,0      ;  (k1-1) + 3*TCY
    GOTO   Loop_Ext_13        ;  (k1-1)*2TCY
    RETURN                    ;  2*TCY 
  
    
;; Catorce Retardo (200ms)
   ;T2= (k1*T1(us))+k2*(1us)+ 6*(1us)
    ; T1=(6 + 4k)*(1us)= 1ms
Delay_200ms:                   ;  2TCY---Call
    MOVLW  200                 ;  1TCY ( El valor que le carguemos a "W" es el valor de "k1")
    MOVWF  Contador2,0        ;  1TCY 
Loop_Ext_14:  
    MOVLW  249                ;  k1*TCY.....k=249
    MOVWF  Contador1,0        ;  k1*TCY
Loop_Int_14:
    Nop                       ;  k1*k*TCY
    DECFSZ Contador1,1,0      ;  k1*((k-1) + 3*TCY)
    GOTO   Loop_Int_14        ;  k1((k-1)*2TCY)
    DECFSZ Contador2,1,0      ;  (k1-1) + 3*TCY
    GOTO   Loop_Ext_14        ;  (k1-1)*2TCY
    RETURN                    ;  2*TCY 
    
    
;;Quinceavo Retardo (250ms)
;T2= (k1*T1(us))+k2*(1us)+ 6*(1us)
    ; T1=(6 + 4k)*(1us)= 1ms
Delay_250ms:                   ;  2TCY---Call
    MOVLW  250                 ;  1TCY ( El valor que le carguemos a "W" es el valor de "k1")
    MOVWF  Contador2,0        ;  1TCY 
Loop_Ext_15:  
    MOVLW  249                ;  k1*TCY.....k=249
    MOVWF  Contador1,0        ;  k1*TCY
Loop_Int_15:
    Nop                       ;  k1*k*TCY
    DECFSZ Contador1,1,0      ;  k1*((k-1) + 3*TCY)
    GOTO   Loop_Int_15        ;  k1((k-1)*2TCY)
    DECFSZ Contador2,1,0      ;  (k1-1) + 3*TCY
    GOTO   Loop_Ext_15        ;  (k1-1)*2TCY
    RETURN                    ;  2*TCY 
    