
_TelaInicial:

;display.c,36 :: 		void TelaInicial(void){
;display.c,38 :: 		_lcdClr = 1;                       //Seta a Flag para a função ClearLcd
	BSF         __lcdClr+0, BitPos(__lcdClr+0) 
;display.c,39 :: 		ClearLcd();                        //Apaga o display
	CALL        _ClearLcd+0, 0
;display.c,40 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          //Desliga o Cursor
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;display.c,41 :: 		Lcd_Out(1,4,"Registrador");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_display+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_display+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,42 :: 		Lcd_Out(2,4,"Eletronico de");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_display+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_display+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,43 :: 		Lcd_Out(3,4,"Pressao...");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_display+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_display+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,44 :: 		Lcd_Out(4,4, "Aperte [ENTER]");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_display+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_display+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,45 :: 		_telaInicial = 1;                  //seta a Flag da tela inicial
	BSF         __telaInicial+0, BitPos(__telaInicial+0) 
;display.c,46 :: 		_teste = 0;                        //garante a flag apagada
	BCF         __teste+0, BitPos(__teste+0) 
;display.c,47 :: 		_iniciado = 0;
	BCF         __iniciado+0, BitPos(__iniciado+0) 
;display.c,48 :: 		}
L_end_TelaInicial:
	RETURN      0
; end of _TelaInicial

_MenuPrincipal:

;display.c,50 :: 		void MenuPrincipal(void){
;display.c,52 :: 		_lcdClr = 1;
	BSF         __lcdClr+0, BitPos(__lcdClr+0) 
;display.c,53 :: 		ClearLcd();
	CALL        _ClearLcd+0, 0
;display.c,54 :: 		Lcd_Chr(Linha,1, '>');
	MOVF        _Linha+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       62
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;display.c,55 :: 		Lcd_Out(2,3, "Iniciar Teste");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_display+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_display+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,56 :: 		Lcd_Out(3,3, "Ultimos Resultados");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_display+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_display+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,57 :: 		_atualizaLcd = 0;                  //pra garantia que a flag está limpa
	BCF         __atualizaLcd+0, BitPos(__atualizaLcd+0) 
;display.c,58 :: 		_menu = 1;
	BSF         __menu+0, BitPos(__menu+0) 
;display.c,59 :: 		_submenu1 = 0;                     //garante que a flag do submenu esteja limpa
	BCF         __submenu1+0, BitPos(__submenu1+0) 
;display.c,60 :: 		}
L_end_MenuPrincipal:
	RETURN      0
; end of _MenuPrincipal

_SubMenu1:

;display.c,62 :: 		void SubMenu1(void){
;display.c,64 :: 		_lcdClr = 1;
	BSF         __lcdClr+0, BitPos(__lcdClr+0) 
;display.c,65 :: 		ClearLcd();
	CALL        _ClearLcd+0, 0
;display.c,66 :: 		Lcd_Out(2,1,"[ENTER] - Iniciar");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_display+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_display+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,67 :: 		Lcd_Out(3,1,"[RETURN] - Voltar");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_display+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_display+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,68 :: 		_submenu1 = 1;
	BSF         __submenu1+0, BitPos(__submenu1+0) 
;display.c,69 :: 		_teste = 0;             //garante a flag de teste apagada
	BCF         __teste+0, BitPos(__teste+0) 
;display.c,71 :: 		}
L_end_SubMenu1:
	RETURN      0
; end of _SubMenu1

_MsgTestInProgress:

;display.c,73 :: 		void MsgTestInProgress(void){
;display.c,75 :: 		_lcdClr = 1;
	BSF         __lcdClr+0, BitPos(__lcdClr+0) 
;display.c,76 :: 		ClearLcd();
	CALL        _ClearLcd+0, 0
;display.c,77 :: 		Lcd_Out(2,7,"Teste");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_display+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_display+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,78 :: 		Lcd_Out(3,2,"Em Andamento...");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_display+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_display+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,79 :: 		_teste = 1;                    //seta a flag
	BSF         __teste+0, BitPos(__teste+0) 
;display.c,80 :: 		_emAndamento = 0;              //garante as flags apagadas
	BCF         __emAndamento+0, BitPos(__emAndamento+0) 
;display.c,81 :: 		_acionamento = 0;
	BCF         __acionamento+0, BitPos(__acionamento+0) 
;display.c,82 :: 		_retorno = 0;
	BCF         __retorno+0, BitPos(__retorno+0) 
;display.c,83 :: 		}
L_end_MsgTestInProgress:
	RETURN      0
; end of _MsgTestInProgress

_Resultados:

;display.c,85 :: 		void Resultados(unsigned int *acion, unsigned int *ret){
;display.c,88 :: 		WordToStr(*acion, txt1);         //passa o valor para string
	MOVFF       FARG_Resultados_acion+0, FSR0L+0
	MOVFF       FARG_Resultados_acion+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt1+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;display.c,89 :: 		++acion;                         //incrementa o ponteiro
	MOVLW       2
	ADDWF       FARG_Resultados_acion+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_Resultados_acion+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_Resultados_acion+0 
	MOVF        R1, 0 
	MOVWF       FARG_Resultados_acion+1 
;display.c,90 :: 		WordToStr(*acion, txt2);
	MOVFF       R0, FSR0L+0
	MOVFF       R1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt2+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;display.c,91 :: 		++acion;
	MOVLW       2
	ADDWF       FARG_Resultados_acion+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_Resultados_acion+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_Resultados_acion+0 
	MOVF        R1, 0 
	MOVWF       FARG_Resultados_acion+1 
;display.c,92 :: 		WordToStr(*acion, txt3);
	MOVFF       R0, FSR0L+0
	MOVFF       R1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt3+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt3+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;display.c,93 :: 		++acion;
	MOVLW       2
	ADDWF       FARG_Resultados_acion+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_Resultados_acion+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_Resultados_acion+0 
	MOVF        R1, 0 
	MOVWF       FARG_Resultados_acion+1 
;display.c,94 :: 		WordToStr(*acion, txt4);
	MOVFF       R0, FSR0L+0
	MOVFF       R1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt4+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;display.c,96 :: 		WordToStr(*ret, txt5);         //passa o valor para string
	MOVFF       FARG_Resultados_ret+0, FSR0L+0
	MOVFF       FARG_Resultados_ret+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt5+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;display.c,97 :: 		++ret;                         //incrementa o ponteiro
	MOVLW       2
	ADDWF       FARG_Resultados_ret+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_Resultados_ret+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_Resultados_ret+0 
	MOVF        R1, 0 
	MOVWF       FARG_Resultados_ret+1 
;display.c,98 :: 		WordToStr(*ret, txt6);
	MOVFF       R0, FSR0L+0
	MOVFF       R1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt6+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt6+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;display.c,99 :: 		++ret;
	MOVLW       2
	ADDWF       FARG_Resultados_ret+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_Resultados_ret+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_Resultados_ret+0 
	MOVF        R1, 0 
	MOVWF       FARG_Resultados_ret+1 
;display.c,100 :: 		WordToStr(*ret, txt7);
	MOVFF       R0, FSR0L+0
	MOVFF       R1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt7+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt7+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;display.c,101 :: 		++ret;
	MOVLW       2
	ADDWF       FARG_Resultados_ret+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_Resultados_ret+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_Resultados_ret+0 
	MOVF        R1, 0 
	MOVWF       FARG_Resultados_ret+1 
;display.c,102 :: 		WordToStr(*ret, txt8);
	MOVFF       R0, FSR0L+0
	MOVFF       R1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt8+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt8+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;display.c,104 :: 		_lcdClr = 1;
	BSF         __lcdClr+0, BitPos(__lcdClr+0) 
;display.c,105 :: 		ClearLcd();
	CALL        _ClearLcd+0, 0
;display.c,106 :: 		Lcd_Out(1,1,"NEB:      Ret:      ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_display+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_display+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,107 :: 		Lcd_Out(1,5, txt1);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,108 :: 		Lcd_Out(1,15, txt5);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt5+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,109 :: 		Lcd_Out(2,1,"NB:      Ret:      ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr12_display+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr12_display+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,110 :: 		Lcd_Out(2,4, txt2);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,111 :: 		Lcd_Out(2,14, txt6);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt6+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt6+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,112 :: 		Lcd_Out(3,1,"NM:      Ret:      ");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr13_display+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr13_display+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,113 :: 		Lcd_Out(3,4, txt3);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt3+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt3+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,114 :: 		Lcd_Out(3,14, txt7);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt7+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt7+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,115 :: 		Lcd_Out(4,1,"NA:      Ret:      ");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr14_display+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_display+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,116 :: 		Lcd_Out(4,4, txt4);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt4+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,117 :: 		Lcd_Out(4,14, txt8);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt8+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt8+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display.c,118 :: 		}
L_end_Resultados:
	RETURN      0
; end of _Resultados

_ClearLcd:

;display.c,120 :: 		void ClearLcd(void)
;display.c,122 :: 		if(_lcdClr){
	BTFSS       __lcdClr+0, BitPos(__lcdClr+0) 
	GOTO        L_ClearLcd0
;display.c,123 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;display.c,124 :: 		_lcdClr = 0;
	BCF         __lcdClr+0, BitPos(__lcdClr+0) 
;display.c,125 :: 		}
L_ClearLcd0:
;display.c,126 :: 		}
L_end_ClearLcd:
	RETURN      0
; end of _ClearLcd

_LerBotoes:

;display.c,128 :: 		void LerBotoes(void){
;display.c,130 :: 		if(!Enter) _enter = 1;              //se enter for pressionado seta a flag
	BTFSC       PORTD+0, 0 
	GOTO        L_LerBotoes1
	BSF         __enter+0, BitPos(__enter+0) 
L_LerBotoes1:
;display.c,131 :: 		if(!Select) _select = 1;
	BTFSC       PORTD+0, 1 
	GOTO        L_LerBotoes2
	BSF         __select+0, BitPos(__select+0) 
L_LerBotoes2:
;display.c,132 :: 		if(!Return) _return = 1;
	BTFSC       PORTD+0, 2 
	GOTO        L_LerBotoes3
	BSF         __return+0, BitPos(__return+0) 
L_LerBotoes3:
;display.c,134 :: 		if(Select && _select){
	BTFSS       PORTD+0, 1 
	GOTO        L_LerBotoes6
	BTFSS       __select+0, BitPos(__select+0) 
	GOTO        L_LerBotoes6
L__LerBotoes17:
;display.c,136 :: 		++Linha;
	INCF        _Linha+0, 1 
;display.c,137 :: 		if(Linha > 3) Linha = 2;
	MOVF        _Linha+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_LerBotoes7
	MOVLW       2
	MOVWF       _Linha+0 
L_LerBotoes7:
;display.c,138 :: 		_select = 0;
	BCF         __select+0, BitPos(__select+0) 
;display.c,139 :: 		_atualizaLcd = 1;
	BSF         __atualizaLcd+0, BitPos(__atualizaLcd+0) 
;display.c,140 :: 		}
L_LerBotoes6:
;display.c,141 :: 		if(Enter && _enter){
	BTFSS       PORTD+0, 0 
	GOTO        L_LerBotoes10
	BTFSS       __enter+0, BitPos(__enter+0) 
	GOTO        L_LerBotoes10
L__LerBotoes16:
;display.c,143 :: 		++Tela;
	INCF        _Tela+0, 1 
;display.c,144 :: 		_enter = 0;       //apaga a flag
	BCF         __enter+0, BitPos(__enter+0) 
;display.c,145 :: 		}
L_LerBotoes10:
;display.c,147 :: 		if(Return && _return){
	BTFSS       PORTD+0, 2 
	GOTO        L_LerBotoes13
	BTFSS       __return+0, BitPos(__return+0) 
	GOTO        L_LerBotoes13
L__LerBotoes15:
;display.c,149 :: 		_return = 0;       //apaga a flag
	BCF         __return+0, BitPos(__return+0) 
;display.c,150 :: 		if(Tela > 0) --Tela;            //decrementa a variável Tela
	MOVF        _Tela+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_LerBotoes14
	DECF        _Tela+0, 1 
L_LerBotoes14:
;display.c,152 :: 		}
L_LerBotoes13:
;display.c,153 :: 		}
L_end_LerBotoes:
	RETURN      0
; end of _LerBotoes
