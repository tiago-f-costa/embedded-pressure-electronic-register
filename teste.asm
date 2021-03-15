
_TesteEmAndamento:

;teste.c,24 :: 		void TesteEmAndamento(void){
;teste.c,26 :: 		if(!(_emAndamento)){
	BTFSC       __emAndamento+0, BitPos(__emAndamento+0) 
	GOTO        L_TesteEmAndamento0
;teste.c,27 :: 		V_In = 1;                                 //Liga a válvula de entrada
	BSF         PORTD+0, 7 
;teste.c,28 :: 		_tempo = 0;                               //garante a flag zerada
	BCF         __tempo+0, BitPos(__tempo+0) 
;teste.c,29 :: 		_resultado = 0;                           //garante a flag zerada
	BCF         __resultado+0, BitPos(__resultado+0) 
;teste.c,30 :: 		_final = 0;
	BCF         __final+0, BitPos(__final+0) 
;teste.c,31 :: 		_acionamento = 0;
	BCF         __acionamento+0, BitPos(__acionamento+0) 
;teste.c,32 :: 		_retorno = 0;
	BCF         __retorno+0, BitPos(__retorno+0) 
;teste.c,33 :: 		_nb = 0, _nm = 1, _na = 1;
	BCF         __nb+0, BitPos(__nb+0) 
	BSF         __nm+0, BitPos(__nm+0) 
	BSF         __na+0, BitPos(__na+0) 
;teste.c,35 :: 		}
L_TesteEmAndamento0:
;teste.c,37 :: 		do{
L_TesteEmAndamento1:
;teste.c,38 :: 		_emAndamento = 1;                         //seta a flag
	BSF         __emAndamento+0, BitPos(__emAndamento+0) 
;teste.c,39 :: 		if(_retorno){
	BTFSS       __retorno+0, BitPos(__retorno+0) 
	GOTO        L_TesteEmAndamento4
;teste.c,40 :: 		if(!(_tempo)) FuncaoTempo(10);      //chama a função tempo para contar 10s
	BTFSC       __tempo+0, BitPos(__tempo+0) 
	GOTO        L_TesteEmAndamento5
	MOVLW       10
	MOVWF       FARG_FuncaoTempo_segundos+0 
	CALL        _FuncaoTempo+0, 0
L_TesteEmAndamento5:
;teste.c,41 :: 		switch(counter){
	GOTO        L_TesteEmAndamento6
;teste.c,43 :: 		case 2: V_Out = 1;             //liga válvula de saída pra mudar nível
L_TesteEmAndamento8:
	BSF         PORTD+0, 6 
;teste.c,44 :: 		MudaNivel = 1;         //led de sinalização pra mudar nível
	BSF         PORTB+0, 1 
;teste.c,45 :: 		if(!(_nb)){
	BTFSC       __nb+0, BitPos(__nb+0) 
	GOTO        L_TesteEmAndamento9
;teste.c,46 :: 		MotorDePasso(258, horario);
	MOVLW       2
	MOVWF       FARG_MotorDePasso+0 
	MOVLW       1
	MOVWF       FARG_MotorDePasso+1 
	MOVLW       1
	MOVWF       FARG_MotorDePasso+0 
	CALL        _MotorDePasso+0, 0
;teste.c,47 :: 		_nb = 1;          //seta a flag
	BSF         __nb+0, BitPos(__nb+0) 
;teste.c,48 :: 		_nm = 0;
	BCF         __nm+0, BitPos(__nm+0) 
;teste.c,49 :: 		}
	GOTO        L_TesteEmAndamento10
L_TesteEmAndamento9:
;teste.c,51 :: 		if(_nb && !(_nm)){
	BTFSS       __nb+0, BitPos(__nb+0) 
	GOTO        L_TesteEmAndamento13
	BTFSC       __nm+0, BitPos(__nm+0) 
	GOTO        L_TesteEmAndamento13
L__TesteEmAndamento40:
;teste.c,52 :: 		MotorDePasso(248, horario);
	MOVLW       248
	MOVWF       FARG_MotorDePasso+0 
	MOVLW       0
	MOVWF       FARG_MotorDePasso+1 
	MOVLW       1
	MOVWF       FARG_MotorDePasso+0 
	CALL        _MotorDePasso+0, 0
;teste.c,53 :: 		_nm = 1;
	BSF         __nm+0, BitPos(__nm+0) 
;teste.c,54 :: 		_na = 0;
	BCF         __na+0, BitPos(__na+0) 
;teste.c,55 :: 		}
	GOTO        L_TesteEmAndamento14
L_TesteEmAndamento13:
;teste.c,57 :: 		if(_nm && !(_na)){
	BTFSS       __nm+0, BitPos(__nm+0) 
	GOTO        L_TesteEmAndamento17
	BTFSC       __na+0, BitPos(__na+0) 
	GOTO        L_TesteEmAndamento17
L__TesteEmAndamento39:
;teste.c,58 :: 		MotorDePasso(244, horario);
	MOVLW       244
	MOVWF       FARG_MotorDePasso+0 
	MOVLW       0
	MOVWF       FARG_MotorDePasso+1 
	MOVLW       1
	MOVWF       FARG_MotorDePasso+0 
	CALL        _MotorDePasso+0, 0
;teste.c,59 :: 		_na = 1;
	BSF         __na+0, BitPos(__na+0) 
;teste.c,60 :: 		}
L_TesteEmAndamento17:
L_TesteEmAndamento14:
L_TesteEmAndamento10:
;teste.c,61 :: 		break;
	GOTO        L_TesteEmAndamento7
;teste.c,63 :: 		case 9: V_Out = 0;             //desliga válvula de saída
L_TesteEmAndamento18:
	BCF         PORTD+0, 6 
;teste.c,64 :: 		MudaNivel = 0;         //desliga led
	BCF         PORTB+0, 1 
;teste.c,65 :: 		_retorno = 0;
	BCF         __retorno+0, BitPos(__retorno+0) 
;teste.c,66 :: 		_tempo = 0;
	BCF         __tempo+0, BitPos(__tempo+0) 
;teste.c,67 :: 		V_In = 1;              //liga válvula de entrada para novo ciclo
	BSF         PORTD+0, 7 
;teste.c,68 :: 		break;
	GOTO        L_TesteEmAndamento7
;teste.c,69 :: 		}
L_TesteEmAndamento6:
	MOVF        _counter+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_TesteEmAndamento8
	MOVF        _counter+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_TesteEmAndamento18
L_TesteEmAndamento7:
;teste.c,70 :: 		}
L_TesteEmAndamento4:
;teste.c,72 :: 		if(_acionamento){
	BTFSS       __acionamento+0, BitPos(__acionamento+0) 
	GOTO        L_TesteEmAndamento19
;teste.c,74 :: 		if(!(_tempo)) FuncaoTempo(10);      //chama a função tempo para contar 10s
	BTFSC       __tempo+0, BitPos(__tempo+0) 
	GOTO        L_TesteEmAndamento20
	MOVLW       10
	MOVWF       FARG_FuncaoTempo_segundos+0 
	CALL        _FuncaoTempo+0, 0
L_TesteEmAndamento20:
;teste.c,75 :: 		switch(counter){
	GOTO        L_TesteEmAndamento21
;teste.c,77 :: 		case 2: Led_Estab = 1;       //led que indica estabilização da leitura do sensor
L_TesteEmAndamento23:
	BSF         PORTD+0, 5 
;teste.c,78 :: 		break;
	GOTO        L_TesteEmAndamento22
;teste.c,80 :: 		case 7: Led_Estab = 0;       //desliga o led estabilizador
L_TesteEmAndamento24:
	BCF         PORTD+0, 5 
;teste.c,81 :: 		break;
	GOTO        L_TesteEmAndamento22
;teste.c,83 :: 		case 9: V_Out = 1;           //liga válvula de saída pra despressurizar o sistema
L_TesteEmAndamento25:
	BSF         PORTD+0, 6 
;teste.c,84 :: 		_acionamento = 0;    //apaga a flag
	BCF         __acionamento+0, BitPos(__acionamento+0) 
;teste.c,85 :: 		_tempo = 0;
	BCF         __tempo+0, BitPos(__tempo+0) 
;teste.c,86 :: 		break;
	GOTO        L_TesteEmAndamento22
;teste.c,87 :: 		}
L_TesteEmAndamento21:
	MOVF        _counter+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_TesteEmAndamento23
	MOVF        _counter+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_TesteEmAndamento24
	MOVF        _counter+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_TesteEmAndamento25
L_TesteEmAndamento22:
;teste.c,88 :: 		}
L_TesteEmAndamento19:
;teste.c,91 :: 		if(_resultado){
	BTFSS       __resultado+0, BitPos(__resultado+0) 
	GOTO        L_TesteEmAndamento26
;teste.c,93 :: 		Calculos(Acionamento, Retorno);    //chama a função para realizar os cálculos
	MOVLW       _Acionamento+0
	MOVWF       FARG_Calculos_acion+0 
	MOVLW       hi_addr(_Acionamento+0)
	MOVWF       FARG_Calculos_acion+1 
	MOVLW       _Retorno+0
	MOVWF       FARG_Calculos_ret+0 
	MOVLW       hi_addr(_Retorno+0)
	MOVWF       FARG_Calculos_ret+1 
	CALL        _Calculos+0, 0
;teste.c,94 :: 		Resultados(Acionamento, Retorno);  //chama a função que imprime os Resultados no display
	MOVLW       _Acionamento+0
	MOVWF       FARG_Resultados_acion+0 
	MOVLW       hi_addr(_Acionamento+0)
	MOVWF       FARG_Resultados_acion+1 
	MOVLW       _Retorno+0
	MOVWF       FARG_Resultados_ret+0 
	MOVLW       hi_addr(_Retorno+0)
	MOVWF       FARG_Resultados_ret+1 
	CALL        _Resultados+0, 0
;teste.c,95 :: 		_final = 1;                        //seta a flag final
	BSF         __final+0, BitPos(__final+0) 
;teste.c,96 :: 		}
L_TesteEmAndamento26:
;teste.c,98 :: 		while(_final);
L_TesteEmAndamento27:
	BTFSS       __final+0, BitPos(__final+0) 
	GOTO        L_TesteEmAndamento28
	GOTO        L_TesteEmAndamento27
L_TesteEmAndamento28:
;teste.c,100 :: 		}while(_emAndamento);
	BTFSC       __emAndamento+0, BitPos(__emAndamento+0) 
	GOTO        L_TesteEmAndamento1
;teste.c,102 :: 		}
L_end_TesteEmAndamento:
	RETURN      0
; end of _TesteEmAndamento

_FuncaoTempo:

;teste.c,104 :: 		void FuncaoTempo(unsigned char segundos){
;teste.c,106 :: 		*ptr = segundos;
	MOVFF       _ptr+0, FSR1L+0
	MOVFF       _ptr+1, FSR1H+0
	MOVF        FARG_FuncaoTempo_segundos+0, 0 
	MOVWF       POSTINC1+0 
;teste.c,107 :: 		T0CON.TMR0ON = 1;                      //Liga Contagem do timer
	BSF         T0CON+0, 7 
;teste.c,108 :: 		_tempo = 1;                            //seta a flag
	BSF         __tempo+0, BitPos(__tempo+0) 
;teste.c,109 :: 		}
L_end_FuncaoTempo:
	RETURN      0
; end of _FuncaoTempo

_Calculos:

;teste.c,112 :: 		void Calculos(unsigned int *acion, unsigned int *ret){
;teste.c,117 :: 		for(i = 0; i < 4; i++){                 //laço for para as pressões de acionamento
	CLRF        Calculos_i_L0+0 
L_Calculos29:
	MOVLW       4
	SUBWF       Calculos_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Calculos30
;teste.c,118 :: 		varTemp = Pressao(referencia, *acion, constante);
	MOVFF       FARG_Calculos_acion+0, FSR0L+0
	MOVFF       FARG_Calculos_acion+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       106
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       Calculos_varTemp_L0+0 
	MOVF        R1, 0 
	MOVWF       Calculos_varTemp_L0+1 
	MOVF        R2, 0 
	MOVWF       Calculos_varTemp_L0+2 
	MOVF        R3, 0 
	MOVWF       Calculos_varTemp_L0+3 
;teste.c,119 :: 		*acion = varTemp;
	MOVF        Calculos_varTemp_L0+0, 0 
	MOVWF       R0 
	MOVF        Calculos_varTemp_L0+1, 0 
	MOVWF       R1 
	MOVF        Calculos_varTemp_L0+2, 0 
	MOVWF       R2 
	MOVF        Calculos_varTemp_L0+3, 0 
	MOVWF       R3 
	CALL        _double2word+0, 0
	MOVFF       FARG_Calculos_acion+0, FSR1L+0
	MOVFF       FARG_Calculos_acion+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;teste.c,120 :: 		++acion;                      //incrementa o ponteiro para ir ao próximo endereço
	MOVLW       2
	ADDWF       FARG_Calculos_acion+0, 1 
	MOVLW       0
	ADDWFC      FARG_Calculos_acion+1, 1 
;teste.c,117 :: 		for(i = 0; i < 4; i++){                 //laço for para as pressões de acionamento
	INCF        Calculos_i_L0+0, 1 
;teste.c,121 :: 		}
	GOTO        L_Calculos29
L_Calculos30:
;teste.c,123 :: 		for(j = 0; j < 4; j++){                     //laço for para as pressões de retorno
	CLRF        Calculos_j_L0+0 
L_Calculos32:
	MOVLW       4
	SUBWF       Calculos_j_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Calculos33
;teste.c,124 :: 		varTemp = Pressao(referencia, *ret, constante);
	MOVFF       FARG_Calculos_ret+0, FSR0L+0
	MOVFF       FARG_Calculos_ret+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       106
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       Calculos_varTemp_L0+0 
	MOVF        R1, 0 
	MOVWF       Calculos_varTemp_L0+1 
	MOVF        R2, 0 
	MOVWF       Calculos_varTemp_L0+2 
	MOVF        R3, 0 
	MOVWF       Calculos_varTemp_L0+3 
;teste.c,125 :: 		*ret = varTemp;
	MOVF        Calculos_varTemp_L0+0, 0 
	MOVWF       R0 
	MOVF        Calculos_varTemp_L0+1, 0 
	MOVWF       R1 
	MOVF        Calculos_varTemp_L0+2, 0 
	MOVWF       R2 
	MOVF        Calculos_varTemp_L0+3, 0 
	MOVWF       R3 
	CALL        _double2word+0, 0
	MOVFF       FARG_Calculos_ret+0, FSR1L+0
	MOVFF       FARG_Calculos_ret+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;teste.c,126 :: 		++ret;                      //incrementa o ponteiro para ir ao próximo endereço
	MOVLW       2
	ADDWF       FARG_Calculos_ret+0, 1 
	MOVLW       0
	ADDWFC      FARG_Calculos_ret+1, 1 
;teste.c,123 :: 		for(j = 0; j < 4; j++){                     //laço for para as pressões de retorno
	INCF        Calculos_j_L0+0, 1 
;teste.c,127 :: 		}
	GOTO        L_Calculos32
L_Calculos33:
;teste.c,128 :: 		}
L_end_Calculos:
	RETURN      0
; end of _Calculos

_MotorDePasso:

;teste.c,130 :: 		void MotorDePasso(unsigned int passos, unsigned char sentido){
;teste.c,132 :: 		Passos = passos;
;teste.c,133 :: 		Sentido = sentido;
	BTFSC       FARG_MotorDePasso_sentido+0, 0 
	GOTO        L__MotorDePasso45
	BCF         PORTC+0, 6 
	GOTO        L__MotorDePasso46
L__MotorDePasso45:
	BSF         PORTC+0, 6 
L__MotorDePasso46:
;teste.c,134 :: 		Enable = 0;             //habilita alimentação para as bobinas
	BCF         PORTD+0, 4 
;teste.c,135 :: 		while(Passos){
L_MotorDePasso35:
	MOVF        FARG_MotorDePasso_passos+0, 0 
	IORWF       FARG_MotorDePasso_passos+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_MotorDePasso36
;teste.c,136 :: 		Step = 1;
	BSF         PORTC+0, 7 
;teste.c,137 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_MotorDePasso37:
	DECFSZ      R13, 1, 1
	BRA         L_MotorDePasso37
	DECFSZ      R12, 1, 1
	BRA         L_MotorDePasso37
	NOP
	NOP
;teste.c,138 :: 		Step = 0;
	BCF         PORTC+0, 7 
;teste.c,139 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_MotorDePasso38:
	DECFSZ      R13, 1, 1
	BRA         L_MotorDePasso38
	DECFSZ      R12, 1, 1
	BRA         L_MotorDePasso38
	NOP
	NOP
;teste.c,140 :: 		--Passos;
	MOVLW       1
	SUBWF       FARG_MotorDePasso_passos+0, 1 
	MOVLW       0
	SUBWFB      FARG_MotorDePasso_passos+1, 1 
;teste.c,141 :: 		}
	GOTO        L_MotorDePasso35
L_MotorDePasso36:
;teste.c,142 :: 		Enable = 1;             //desabilita a alimentação para as bobinas
	BSF         PORTD+0, 4 
;teste.c,143 :: 		}
L_end_MotorDePasso:
	RETURN      0
; end of _MotorDePasso

teste____?ag:

L_end_teste___?ag:
	RETURN      0
; end of teste____?ag
