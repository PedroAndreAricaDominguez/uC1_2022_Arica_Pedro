;**********************************
    ;@author  		Arica Dominguez Pedro Andre
    ;@date    		08/01/2023
    ;@file    		Retardos.inc
    ;@description   	Alberga una libreria de retardos
    ;IDE		PMLAB X IDE
    ;@assembler version 6.05
    ;oscillator frequency  = 4MHz
    ;TCY 	           = 1us
;**********************************
    
   
PSECT myVars, space=1,class=COMRAM
contador1: DS 1      ;reserva 1 byte en access ram
contador2: DS 1      ;reserva 1 byte en access ram
  
PSECT code


    ; Retardo1(10us)
    ;T=(6+4k1)*TCY  
Delay_10us:                  ;  2TCY---CALL
    MOVLW  1                 ;  1TCY --- w = k1
    MOVWF  contador1,0       ;  1TCY
Loop_1:   
    NOP                      ;  k1*TCY
    DECFSZ contador1,1,0     ;  (k1-1) + 3*TCY
    GOTO   Loop_1             ;  (k1-1)*2TCY
    RETURN                   ;  2*TCY
    
    ; Retardo2(25us)
    ;T=(6+4k1)*TCY 
Delay_25us:                  ;  2TCY---CALL
    MOVLW  5                 ;  1TCY --- w = k2
    MOVWF  contador1,0       ;  1TCY
Loop_2:   
    NOP                      ;  k1*TCY
    DECFSZ contador1,1,0     ;  (k1-1) + 3*TCY
    GOTO   Loop_2             ;  (k1-1)*2TCY
    RETURN                   ;  2*TCY
    


    ; Retardo3(50us
    ;T=(6+4k1)*TCY   
Delay_50us:                  ;  2TCY---CALL
    MOVLW  11                ;  1TCY --- w = k3
    MOVWF  contador1,0       ;  1TCY
Loop_3:
    NOP                      ;  k1*TCY
    DECFSZ contador1,1,0     ;  (k1-1) + 3*TCY
    GOTO   Loop_3             ;  (k1-1)*2TCY
    RETURN                   ;  2*TCY
                                  
                                  
     ; Retardo4(100us)           
     ;T=(6+4k1)*TCY  
Delay_100us:                 ;  2TCY---CALL
    MOVLW  24                ;  1TCY....w=k4
    MOVWF  contador1,0       ;  1TCY
Loop_4:
    NOP                      ;  k1*TCY
    DECFSZ contador1,1,0     ;  (k1-1) + 3*TCY
    GOTO   Loop_4             ;  (k1-1)*2TCY
    RETURN                   ;  2*TCY

      
    ; Retardo5(200us)
      ;T=(6+4k1)*TCY  
Delay_200us:                 ;  2TCY---CALL
    MOVLW  49                ;  1TCY
    MOVWF  contador1,0       ;  1TCY
Loop_5:
    NOP                      ;  k1*TCY
    DECFSZ contador1,1,0     ;  (k1-1) + 3*TCY
    GOTO   Loop_5             ; (k1-1)*2TCY
    RETURN                   ;  2TCY

 
      ; Retardo6(250us)
      ;T=(6+4k1)*TCY  
Delay_250us:             ; 2TCY---CALL
    MOVLW  61                ;  1TCY
    MOVWF  contador1,0       ;  1TCY
Loop_6:
    NOP                      ;  k1*TCY
    DECFSZ contador1,1,0     ;  (k1-1) + 3*TCY
    GOTO   Loop_6             ;  (k1-1)*2TCY
    RETURN                   ;  2TCY

    
      ; Retardo7(500us)
      ;T=(6+4k1)*TCY  
Delay_500us:                 ;   2TCY---CALL
    MOVLW  124               ;   1TCY
    MOVWF  contador1,0       ;   1TCY
Loop_7:
    NOP                      ;   k1*TCY
    DECFSZ contador1,1,0     ;   (k1-1) + 3*TCY
    GOTO   Loop_7             ;   (k1-1)*2TCY
    RETURN                   ;   2*TCY
    
    
      ; Retardo8(1ms)
      ;T= (k2*(6+4(k1)us))+k2*(1us)+ 6*(1us)= (k2*(6+4(249)us))+ k2*(1us)+ 6us
      
Delay_1ms:                    ;  2TCY---Call
    MOVLW  1                  ;  1TCY... w=k2
    MOVWF  contador2,0        ;  1TCY
      ; T= (6+4k1)ua= (6+4*(249))= 1ms 
Loop_Ext1:  
    MOVLW  249                ;  k2*TCY..... k1=249
    MOVWF  contador1,0        ;  k2*TCY
Loop_Int1:
    Nop                       ;  k2*k1*TCY
    DECFSZ contador1,1,0      ;  k2*((k1-1) + 3*TCY)
    GOTO   Loop_Int1          ;  k2((k1-1)*2TCY)
    DECFSZ contador2,1,0      ;  (k2-1) + 3*TCY
    GOTO   Loop_Ext1          ;  (k2-1)*2TCY
    RETURN                    ;  2*TCY

  
    ; Retardo9(5ms)
       ;T= (k2*(6+4(k1)us))+k2*(1us)+ 6*(1us)= (k2*(6+4(249)us))+ k2*(1us)+ 6us
      ;  
Delay_5ms:                    ;  2TCY---Call
    MOVLW  5                  ;  1TCY... w=k2
    MOVWF  contador2,0        ;  1TCY
      ; T= (6+4k1)us = (6+4*(249)) = 1ms 
Loop_Ext2:  
    MOVLW  249                ;  k2*TCY.....k1=249
    MOVWF  contador1,0        ;  k2*TCY
Loop_Int2:
    Nop                       ;  k2*k1*TCY
    DECFSZ contador1,1,0      ;  k2*((k1-1) + 3*TCY)
    GOTO   Loop_Int2          ;  k2((k1-1)*2TCY)
    DECFSZ contador2,1,0      ;  (k2-1) + 3*TCY
    GOTO   Loop_Ext2          ;  (k2-1)*2TCY
    RETURN                    ;  2*TCY
    
    
    ; Retardo10(10ms)
      ;T= (k2*(6+4(k1)us))+k2*(1us)+ 6*(1us)= (k2*(6+4(249)us))+k2*(1us)+ 6us
Delay_10ms:                   ;  2TCY---Call
    MOVLW  10                 ;  1TCY... w=k2
    MOVWF  contador2,0        ;  1TCY
      ; T= (6+4k1)us= (6+4*(249))= 1ms 
Loop_Ext3:  
    MOVLW  249                ;  k2*TCY.....k1=249
    MOVWF  contador1,0        ;  k2*TCY
Loop_Int3:
    Nop                       ;  k2*k1*TCY
    DECFSZ contador1,1,0      ;  k2*((k1-1) + 3*TCY)
    GOTO   Loop_Int3          ;  k2((k1-1)*2TCY)
    DECFSZ contador2,1,0      ;  (k2-1) + 3*TCY
    GOTO   Loop_Ext3          ;  (k2-1)*2TCY
    RETURN                    ;  2*TCY
    
   
    ; Retardo11(25ms)
      ;T= (k2*(6+4(k1)us))+k2*(1us)+ 6*(1us)= (k2*(6+4(249)us))+k2*(1us)+ 6us 
      ;  
Delay_25ms:                   ;  2TCY---Call
    MOVLW  25                 ;  1TCY... w=k2
    MOVWF  contador2,0        ;  1TCY
      ; T= (6+4k1)us= (6+4*(249))= 1ms 
Loop_Ext4:  
    MOVLW  249                ;  k2*TCY.....k1=249
    MOVWF  contador1,0        ;  k2*TCY
Loop_Int4:
    Nop                       ;  k2*k1*TCY
    DECFSZ contador1,1,0      ;  k2*((k1-1) + 3*TCY)
    GOTO   Loop_Int4          ;  k2((k1-1)*2TCY)
    DECFSZ contador2,1,0      ;  (k2-1) + 3*TCY
    GOTO   Loop_Ext4          ;  (k2-1)*2TCY
    RETURN                    ;  2*TCY
    
    
    ;; Retardo12(50ms)
      ;T= (k2*(6+4(k1)us))+k2*(1us)+ 6*(1us)= (k2*(6+4(249)us))+k2*(1us)+ 6us 
      ;  
Delay_50ms:                   ;  2TCY---Call
    MOVLW  50                 ;  1TCY... w=k2
    MOVWF  contador2,0        ;  1TCY
      ; T= (6+4k1)us= (6+4*(249))= 1ms 
Loop_Ext5:  
    MOVLW  249                ; k2*TCY.....k1=249
    MOVWF  contador1,0        ;  k2*TCY
Loop_Int5:
    Nop                       ;  k2*k1*TCY
    DECFSZ contador1,1,0      ;  k2*((k1-1) + 3*TCY)
    GOTO   Loop_Int5          ;  k2((k1-1)*2TCY)
    DECFSZ contador2,1,0      ;  (k2-1) + 3*TCY
    GOTO   Loop_Ext5          ;  (k2-1)*2TCY
    RETURN                    ;  2*TCY  
                                  
                                   
    ;; Retardo13(100ms)            
      ;T= (k2*(6+4(k1)us))+k2*(1us)+ 6*(1us)= (k2*(6+4(249)us))+ k2*(1us)+ 6us 
Delay_100ms:                  ;  2TCY---Call
    MOVLW  100                ;  1TCY... w=k2
    MOVWF  contador2,0        ;  1TCY
      ; T= (6+4k1)us= (6+4*(249))= 1ms 
Loop_Ext6:                          
    MOVLW  249                ;  k2*TCY....k1=249
    MOVWF  contador1,0        ;  k2*TCY
Loop_Int6:                             
    Nop                       ;  k2*k1*TCY
    DECFSZ contador1,1,0      ;  k2*((k1-1) + 3*TCY)
    GOTO   Loop_Int6          ;  k2((k1-1)*2TCY)
    DECFSZ contador2,1,0      ;  (k2-1) + 3*TCY
    GOTO   Loop_Ext6          ;  (k2-1)*2TCY
    RETURN                    ;  2*TCY
   
    
    ; Retardo14(200ms)
      ;T= (k2*(6+4(k1)us))+k2*(1us)+ 6*(1us)= (k2*(6+4(249)us))+ k2*(1us)+ 6us 
Delay_200ms:                  ;  2TCY---Call
    MOVLW  200                ;  1TCY... w=k2
    MOVWF  contador2,0        ;  1TCY
      ; T= (6+4k1)us= (6+4*(249))= 1ms 
Loop_Ext7:  
    MOVLW  249                ;  k2*TCY....k1=249
    MOVWF  contador1,0        ;  k2*TCU
Loop_Int7:
    Nop                       ;  k2*k1*TCY
    DECFSZ contador1,1,0      ;  k2*((k1-1) + 3*TCY)
    GOTO   Loop_Int7          ;  k2((k1-1)*2TCY)
    DECFSZ contador2,1,0      ;  (k2-1) + 3*TCY
    GOTO   Loop_Ext7          ;  (k2-1)*2TCY
    RETURN                    ;  2*TCY
    
    
    ; Retardo15(250ms)
      ;T= (k2*(6+4(k1)us))+k2*(1us)+ 6*(1us)= (k2*(6+4(249)us))+ k2*(1us)+ 6us
Delay_250ms:                  ;  2TCY---Call
    MOVLW  250                ;  1TCY... w=k2
    MOVWF  contador2,0        ;  1TCY
      ; T= (6+4k1)us= (6+4*(249))= 1ms 
Loop_Ext8:  
    MOVLW  249                ;  k2*TCY.....k1=249
    MOVWF  contador1,0        ;  k2*TCY
Loop_Int8:
    Nop                       ;  k2*k1*TCY
    DECFSZ contador1,1,0      ;  k2*((k1-1) + 3*Tcy)
    GOTO   Loop_Int8          ;  k2((k1-1)*2TCY)
    DECFSZ contador2,1,0      ;  (k2-1) + 3*TCY
    GOTO   Loop_Ext8          ;  (k2-1)*2TCY
    RETURN                    ;  2*TCY	



