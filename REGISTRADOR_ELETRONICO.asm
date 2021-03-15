
_Interrupt_HIGH:

;REGISTRADOR_ELETRONICO.c,48 :: 		void Interrupt_HIGH() iv 0x0008 ics ICS_AUTO {
;REGISTRADOR_ELETRONICO.c,52 :: 		volatile unsigned int LeituraAdc = 0;      //variável que armzena o valor do ADC
	CLRF        Interrupt_HIGH_LeituraAdc_L0+0 
	CLRF        Interrupt_HIGH_LeituraAdc_L0+1 
	MOVLW       10
	MOVWF       Interrupt_HIGH_acc_L0+0 
;REGISTRADOR_ELETRONICO.c,55 :: 		while(acc){
L_Interrupt_HIGH0:
	MOVF        Interrupt_HIGH_acc_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Interrupt_HIGH1
;REGISTRADOR_ELETRONICO.c,56 :: 		LeituraAdc += ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	ADDWF       Interrupt_HIGH_LeituraAdc_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      Interrupt_HIGH_LeituraAdc_L0+1, 1 
;REGISTRADOR_ELETRONICO.c,57 :: 		--acc;
	DECF        Interrupt_HIGH_acc_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       Interrupt_HIGH_acc_L0+0 
;REGISTRADOR_ELETRONICO.c,58 :: 		}
	GOTO        L_Interrupt_HIGH0
L_Interrupt_HIGH1:
;REGISTRADOR_ELETRONICO.c,60 :: 		if(INTCON.INT0IF){
	BTFSS       INTCON+0, 1 
	GOTO        L_Interrupt_HIGH2
;REGISTRADOR_ELETRONICO.c,62 :: 		if(!Pressostato) flagAc = 1;
	BTFSC       PORTB+0, 0 
	GOTO        L_Interrupt_HIGH3
	MOVLW       1
	MOVWF       _flagAc+0 
L_Interrupt_HIGH3:
;REGISTRADOR_ELETRONICO.c,63 :: 		if(Pressostato) flagRet = 1;
	BTFSS       PORTB+0, 0 
	GOTO        L_Interrupt_HIGH4
	MOVLW       1
	MOVWF       _flagRet+0 
L_Interrupt_HIGH4:
;REGISTRADOR_ELETRONICO.c,65 :: 		if(!Pressostato && flagAc){           //Se Normalmente fechado
	BTFSC       PORTB+0, 0 
	GOTO        L_Interrupt_HIGH7
	MOVF        _flagAc+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Interrupt_HIGH7
L__Interrupt_HIGH34:
;REGISTRADOR_ELETRONICO.c,67 :: 		V_In = 0;                                 //Desliga válvula de entrada
	BCF         PORTD+0, 7 
;REGISTRADOR_ELETRONICO.c,68 :: 		Acionamento[nivel] = ((LeituraAdc/10) - offset);         //vai receber o valor da leitura analógica
	MOVF        Interrupt_HIGH_nivel_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _Acionamento+0
	ADDWF       R0, 0 
	MOVWF       FLOC__Interrupt_HIGH+0 
	MOVLW       hi_addr(_Acionamento+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__Interrupt_HIGH+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        Interrupt_HIGH_LeituraAdc_L0+0, 0 
	MOVWF       R0 
	MOVF        Interrupt_HIGH_LeituraAdc_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       100
	SUBWF       R0, 1 
	MOVLW       1
	SUBWFB      R1, 1 
	MOVFF       FLOC__Interrupt_HIGH+0, FSR1L+0
	MOVFF       FLOC__Interrupt_HIGH+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;REGISTRADOR_ELETRONICO.c,69 :: 		_acionamento = 1;                        //flag que indica o Acionamento
	BSF         __acionamento+0, BitPos(__acionamento+0) 
;REGISTRADOR_ELETRONICO.c,70 :: 		flagAc = 0;                              //limpa a flag
	CLRF        _flagAc+0 
;REGISTRADOR_ELETRONICO.c,71 :: 		}
	GOTO        L_Interrupt_HIGH8
L_Interrupt_HIGH7:
;REGISTRADOR_ELETRONICO.c,73 :: 		if(Pressostato && flagRet){          //Se Normalmente aberto
	BTFSS       PORTB+0, 0 
	GOTO        L_Interrupt_HIGH11
	MOVF        _flagRet+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Interrupt_HIGH11
L__Interrupt_HIGH33:
;REGISTRADOR_ELETRONICO.c,75 :: 		V_Out = 0;                              //Desliga válvula de saída
	BCF         PORTD+0, 6 
;REGISTRADOR_ELETRONICO.c,76 :: 		Retorno[nivel] = ((LeituraAdc/10) - offset);
	MOVF        Interrupt_HIGH_nivel_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _Retorno+0
	ADDWF       R0, 0 
	MOVWF       FLOC__Interrupt_HIGH+0 
	MOVLW       hi_addr(_Retorno+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__Interrupt_HIGH+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        Interrupt_HIGH_LeituraAdc_L0+0, 0 
	MOVWF       R0 
	MOVF        Interrupt_HIGH_LeituraAdc_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       100
	SUBWF       R0, 1 
	MOVLW       1
	SUBWFB      R1, 1 
	MOVFF       FLOC__Interrupt_HIGH+0, FSR1L+0
	MOVFF       FLOC__Interrupt_HIGH+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;REGISTRADOR_ELETRONICO.c,77 :: 		_retorno = 1;
	BSF         __retorno+0, BitPos(__retorno+0) 
;REGISTRADOR_ELETRONICO.c,78 :: 		++nivel;                    //Incrementa o nível para armazenar o valor do próximo nível
	MOVF        Interrupt_HIGH_nivel_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       Interrupt_HIGH_nivel_L0+0 
;REGISTRADOR_ELETRONICO.c,79 :: 		flagRet = 0;                //limpa a flag
	CLRF        _flagRet+0 
;REGISTRADOR_ELETRONICO.c,80 :: 		}
L_Interrupt_HIGH11:
L_Interrupt_HIGH8:
;REGISTRADOR_ELETRONICO.c,82 :: 		INTCON.INT0IF = 0;                       //Apaga a flag
	BCF         INTCON+0, 1 
;REGISTRADOR_ELETRONICO.c,83 :: 		INTCON2.INTEDG0 = (x % 2);                //Altera o tipo de borda a cada passagem
	MOVLW       1
	ANDWF       Interrupt_HIGH_x_L0+0, 0 
	MOVWF       R0 
	BTFSC       R0, 0 
	GOTO        L__Interrupt_HIGH42
	BCF         INTCON2+0, 6 
	GOTO        L__Interrupt_HIGH43
L__Interrupt_HIGH42:
	BSF         INTCON2+0, 6 
L__Interrupt_HIGH43:
;REGISTRADOR_ELETRONICO.c,84 :: 		++x;
	MOVF        Interrupt_HIGH_x_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       Interrupt_HIGH_x_L0+0 
;REGISTRADOR_ELETRONICO.c,86 :: 		if(nivel == 4){
	MOVF        Interrupt_HIGH_nivel_L0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Interrupt_HIGH12
;REGISTRADOR_ELETRONICO.c,88 :: 		INTCON.INT0IE = 0;                     //desabilita interrupção externa
	BCF         INTCON+0, 4 
;REGISTRADOR_ELETRONICO.c,89 :: 		_resultado = 1;                        //seta a flag
	BSF         __resultado+0, BitPos(__resultado+0) 
;REGISTRADOR_ELETRONICO.c,90 :: 		}
L_Interrupt_HIGH12:
;REGISTRADOR_ELETRONICO.c,92 :: 		}
L_Interrupt_HIGH2:
;REGISTRADOR_ELETRONICO.c,93 :: 		} // ========= Fim Vetor de Interrupção Alta Prioridade ==========
L_end_Interrupt_HIGH:
L__Interrupt_HIGH41:
	RETFIE      1
; end of _Interrupt_HIGH

_Interrupt_LOW:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;REGISTRADOR_ELETRONICO.c,97 :: 		void Interrupt_LOW() iv 0x0018 ics ICS_AUTO {
;REGISTRADOR_ELETRONICO.c,99 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_Interrupt_LOW13
;REGISTRADOR_ELETRONICO.c,101 :: 		if(counter < timer){  //se o contador for menor que o tempo desejado incrementa
	MOVF        _timer+0, 0 
	SUBWF       _counter+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Interrupt_LOW14
;REGISTRADOR_ELETRONICO.c,103 :: 		++counter;
	MOVF        _counter+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _counter+0 
;REGISTRADOR_ELETRONICO.c,104 :: 		}
	GOTO        L_Interrupt_LOW15
L_Interrupt_LOW14:
;REGISTRADOR_ELETRONICO.c,107 :: 		counter = 1;
	MOVLW       1
	MOVWF       _counter+0 
;REGISTRADOR_ELETRONICO.c,108 :: 		T0CON.TMR0ON = 0;      //Desliga o timer
	BCF         T0CON+0, 7 
;REGISTRADOR_ELETRONICO.c,109 :: 		}
L_Interrupt_LOW15:
;REGISTRADOR_ELETRONICO.c,111 :: 		TMR0H = 0xC2;                     //Recarrega os registradores para 1s
	MOVLW       194
	MOVWF       TMR0H+0 
;REGISTRADOR_ELETRONICO.c,112 :: 		TMR0L = 0xF7;
	MOVLW       247
	MOVWF       TMR0L+0 
;REGISTRADOR_ELETRONICO.c,113 :: 		INTCON.TMR0IF = 0;                //Zera a flag para a próxima contagem
	BCF         INTCON+0, 2 
;REGISTRADOR_ELETRONICO.c,114 :: 		}
L_Interrupt_LOW13:
;REGISTRADOR_ELETRONICO.c,115 :: 		} // =========== Fim do Vetor de Interrupção de Baixa Prioridade =============
L_end_Interrupt_LOW:
L__Interrupt_LOW45:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _Interrupt_LOW

_main:

;REGISTRADOR_ELETRONICO.c,118 :: 		void main() {  // --------- Inicio Função Principal ------------
;REGISTRADOR_ELETRONICO.c,120 :: 		Config_18F();                    //Configuração registradores I/Os
	CALL        _Config_18F+0, 0
;REGISTRADOR_ELETRONICO.c,121 :: 		Config_INT0();                   //Configuração interrupção externa
	CALL        _Config_INT0+0, 0
;REGISTRADOR_ELETRONICO.c,122 :: 		ConfigTIMERZERO();               //Configuração interrupção e timer zero
	CALL        _ConfigTIMERZERO+0, 0
;REGISTRADOR_ELETRONICO.c,123 :: 		Lcd_Init();                      //Função nativa compilador que inializa LCD
	CALL        _Lcd_Init+0, 0
;REGISTRADOR_ELETRONICO.c,124 :: 		ADC_Init();                      //Inicializa o Conversor AD
	CALL        _ADC_Init+0, 0
;REGISTRADOR_ELETRONICO.c,125 :: 		TelaInicial();                   //Função que printa tela inicial
	CALL        _TelaInicial+0, 0
;REGISTRADOR_ELETRONICO.c,126 :: 		Enable = 1;                      //pra o motorde passo não receber vcc nas bobinas inicialmente
	BSF         PORTD+0, 4 
;REGISTRADOR_ELETRONICO.c,129 :: 		while(TRUE){ // ------ Início Loop Infinito ---------
L_main16:
;REGISTRADOR_ELETRONICO.c,131 :: 		LerBotoes();                     //função para varredura das teclas
	CALL        _LerBotoes+0, 0
;REGISTRADOR_ELETRONICO.c,132 :: 		if(_telaInicial && Tela == 1){
	BTFSS       __telaInicial+0, BitPos(__telaInicial+0) 
	GOTO        L_main20
	MOVF        _Tela+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
L__main39:
;REGISTRADOR_ELETRONICO.c,133 :: 		MenuPrincipal();              //printa o menu principal no LCD
	CALL        _MenuPrincipal+0, 0
;REGISTRADOR_ELETRONICO.c,134 :: 		_enter = 0;                   //limpa a flag enter
	BCF         __enter+0, BitPos(__enter+0) 
;REGISTRADOR_ELETRONICO.c,135 :: 		_telaInicial = 0;             //Limpa a flag tela inicial
	BCF         __telaInicial+0, BitPos(__telaInicial+0) 
;REGISTRADOR_ELETRONICO.c,136 :: 		}
L_main20:
;REGISTRADOR_ELETRONICO.c,138 :: 		if(_atualizaLcd || (!(_menu) && Tela == 1)) MenuPrincipal();  //Para atualizar o LCD caso o usuário solicite um comando
	BTFSC       __atualizaLcd+0, BitPos(__atualizaLcd+0) 
	GOTO        L__main37
	BTFSC       __menu+0, BitPos(__menu+0) 
	GOTO        L__main38
	MOVF        _Tela+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__main38
	GOTO        L__main37
L__main38:
	GOTO        L_main25
L__main37:
	CALL        _MenuPrincipal+0, 0
L_main25:
;REGISTRADOR_ELETRONICO.c,140 :: 		if(Tela == 2 && !(_submenu1)){                                //Para acessar o submenu 1 da interface
	MOVF        _Tela+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main28
	BTFSC       __submenu1+0, BitPos(__submenu1+0) 
	GOTO        L_main28
L__main36:
;REGISTRADOR_ELETRONICO.c,142 :: 		SubMenu1();
	CALL        _SubMenu1+0, 0
;REGISTRADOR_ELETRONICO.c,143 :: 		_menu = 0;                 //apaga a flag de sinalização do Menu principal
	BCF         __menu+0, BitPos(__menu+0) 
;REGISTRADOR_ELETRONICO.c,144 :: 		}
L_main28:
;REGISTRADOR_ELETRONICO.c,146 :: 		if(Tela == 3 && !(_teste) && !(_iniciado)){
	MOVF        _Tela+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main31
	BTFSC       __teste+0, BitPos(__teste+0) 
	GOTO        L_main31
	BTFSC       __iniciado+0, BitPos(__iniciado+0) 
	GOTO        L_main31
L__main35:
;REGISTRADOR_ELETRONICO.c,148 :: 		MsgTestInProgress();
	CALL        _MsgTestInProgress+0, 0
;REGISTRADOR_ELETRONICO.c,149 :: 		}
L_main31:
;REGISTRADOR_ELETRONICO.c,151 :: 		if(_teste) TesteEmAndamento();
	BTFSS       __teste+0, BitPos(__teste+0) 
	GOTO        L_main32
	CALL        _TesteEmAndamento+0, 0
L_main32:
;REGISTRADOR_ELETRONICO.c,154 :: 		} // ---------- Fim do Loop infinito -----------------
	GOTO        L_main16
;REGISTRADOR_ELETRONICO.c,156 :: 		}// -------- Fim Função Principal -----------------
L_end_main:
	GOTO        $+0
; end of _main
