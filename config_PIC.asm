
_Config_18F:

;config_PIC.c,3 :: 		void Config_18F(void){
;config_PIC.c,5 :: 		ADCON0 = 0B00000000;  //RA0 Como analógica
	CLRF        ADCON0+0 
;config_PIC.c,6 :: 		ADCON1 = 0B00001110;  //Inicialmente todos digitais com exceção do AN0
	MOVLW       14
	MOVWF       ADCON1+0 
;config_PIC.c,7 :: 		TRISB = 0B00000001;         //PORTB como saída e RB0 como entrada
	MOVLW       1
	MOVWF       TRISB+0 
;config_PIC.c,8 :: 		TRISC = 0B00000000;         //será utilizado para o motor de passo
	CLRF        TRISC+0 
;config_PIC.c,9 :: 		TRISD = 0B00001111;   //O Nibble menos significativo como entrada
	MOVLW       15
	MOVWF       TRISD+0 
;config_PIC.c,10 :: 		PORTD = 0B00001111;   //PORTD inicia com as saídas em zero
	MOVLW       15
	MOVWF       PORTD+0 
;config_PIC.c,11 :: 		TRISA.RA0 = 1;        //RA0 como entrada para realizar a leitura analógica
	BSF         TRISA+0, 0 
;config_PIC.c,12 :: 		TRISB.RB0 = 1;        //RB0 como entrada para a interrupção externa
	BSF         TRISB+0, 0 
;config_PIC.c,13 :: 		}
L_end_Config_18F:
	RETURN      0
; end of _Config_18F

_Config_INT0:

;config_PIC.c,15 :: 		void Config_INT0(void){
;config_PIC.c,18 :: 		INTCON.GIEH = 1;                //Habilita Interrupção global
	BSF         INTCON+0, 7 
;config_PIC.c,19 :: 		INTCON.GIEL = 1;                //Habilita Interrupção baixa prioridade
	BSF         INTCON+0, 6 
;config_PIC.c,20 :: 		RCON.IPEN = 1;                //Se zero fica compátivel com a linha 16F
	BSF         RCON+0, 7 
;config_PIC.c,24 :: 		INTCON.INT0IE = 1;          //Habilita interrupção INT0
	BSF         INTCON+0, 4 
;config_PIC.c,25 :: 		INTCON.INT0IF = 0;          //Flag da interrupção INT0 inicia em zero
	BCF         INTCON+0, 1 
;config_PIC.c,26 :: 		INTCON2.INTEDG0 = 0;        //Interrupção na borda de descida
	BCF         INTCON2+0, 6 
;config_PIC.c,28 :: 		}
L_end_Config_INT0:
	RETURN      0
; end of _Config_INT0

_ConfigTIMERZERO:

;config_PIC.c,30 :: 		void ConfigTIMERZERO()
;config_PIC.c,32 :: 		T0CON = 0B00000110;                  //PRESCALER 1:128, INICIA OFF, MODO 16BITS
	MOVLW       6
	MOVWF       T0CON+0 
;config_PIC.c,33 :: 		TMR0H = 0xC2;                        //CARGA CALCULADA PARA 1s
	MOVLW       194
	MOVWF       TMR0H+0 
;config_PIC.c,34 :: 		TMR0L = 0xF7;
	MOVLW       247
	MOVWF       TMR0L+0 
;config_PIC.c,37 :: 		INTCON.TMR0IF = 0;                   //FLAG INICIA LIMPA
	BCF         INTCON+0, 2 
;config_PIC.c,38 :: 		INTCON.TMR0IE = 1;                   //HABILITA INTERRUPÇÃO DO TIMER ZERO
	BSF         INTCON+0, 5 
;config_PIC.c,39 :: 		INTCON2.TMR0IP = 0;                  //BAIXA PRIORIDADE DE INTERRUPÇÃO
	BCF         INTCON2+0, 2 
;config_PIC.c,40 :: 		}
L_end_ConfigTIMERZERO:
	RETURN      0
; end of _ConfigTIMERZERO
