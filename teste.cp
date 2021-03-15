#line 1 "C:/Users/tiago/OneDrive/햞ea de Trabalho/Etapas TCC/ULTIMA_ETAPA/teste.c"
#line 1 "c:/users/tiago/onedrive/햞ea de trabalho/etapas tcc/ultima_etapa/teste.h"




void TesteEmAndamento(void);
void FuncaoTempo(unsigned char segundos);
void Calculos(unsigned int *acion, unsigned int *ret);
void MotorDePasso(unsigned int, unsigned char);
#line 1 "c:/users/tiago/onedrive/햞ea de trabalho/etapas tcc/ultima_etapa/config_pic.h"
#line 22 "c:/users/tiago/onedrive/햞ea de trabalho/etapas tcc/ultima_etapa/config_pic.h"
sbit LCD_RS at RB3_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D7 at RB4_bit;
sbit LCD_D6 at RB5_bit;
sbit LCD_D5 at RB6_bit;
sbit LCD_D4 at RB7_bit;


sbit LCD_RS_Direction at TRISB3_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB4_bit;
sbit LCD_D6_Direction at TRISB5_bit;
sbit LCD_D5_Direction at TRISB6_bit;
sbit LCD_D4_Direction at TRISB7_bit;

void Config_18F(void);
void Config_INT0(void);
void ConfigTIMERZERO(void);
#line 1 "c:/users/tiago/onedrive/햞ea de trabalho/etapas tcc/ultima_etapa/display.h"




void TelaInicial(void);
void ClearLcd(void);
void LerBotoes(void);
void MenuPrincipal(void);
void SubMenu1(void);
void MsgTestInProgress(void);
void Resultados(unsigned int *acion, unsigned int *ret);
#line 9 "C:/Users/tiago/OneDrive/햞ea de Trabalho/Etapas TCC/ULTIMA_ETAPA/teste.c"
bit _emAndamento;
bit _tempo;
bit _resultado;
bit _final;
bit _nb, _nm, _na;
unsigned int Acionamento[4];
unsigned int Retorno[4];
unsigned char timer;
unsigned char *ptr = &timer;
extern bit _acionamento;
extern bit _retorno;
extern volatile unsigned char counter;
unsigned int Passos;
unsigned char Nivel = 0;

void TesteEmAndamento(void){

 if(!(_emAndamento)){
  PORTD.RD7  = 1;
 _tempo = 0;
 _resultado = 0;
 _final = 0;
 _acionamento = 0;
 _retorno = 0;
 _nb = 0, _nm = 1, _na = 1;

 }

 do{
 _emAndamento = 1;
 if(_retorno){
 if(!(_tempo)) FuncaoTempo(10);
 switch(counter){

 case 2:  PORTD.RD6  = 1;
  PORTB.RB1  = 1;
 if(!(_nb)){
 MotorDePasso(258,  1 );
 _nb = 1;
 _nm = 0;
 }
 else
 if(_nb && !(_nm)){
 MotorDePasso(248,  1 );
 _nm = 1;
 _na = 0;
 }
 else
 if(_nm && !(_na)){
 MotorDePasso(244,  1 );
 _na = 1;
 }
 break;

 case 9:  PORTD.RD6  = 0;
  PORTB.RB1  = 0;
 _retorno = 0;
 _tempo = 0;
  PORTD.RD7  = 1;
 break;
 }
 }

 if(_acionamento){

 if(!(_tempo)) FuncaoTempo(10);
 switch(counter){

 case 2:  PORTD.RD5  = 1;
 break;

 case 7:  PORTD.RD5  = 0;
 break;

 case 9:  PORTD.RD6  = 1;
 _acionamento = 0;
 _tempo = 0;
 break;
 }
 }


 if(_resultado){

 Calculos(Acionamento, Retorno);
 Resultados(Acionamento, Retorno);
 _final = 1;
 }

 while(_final);

 }while(_emAndamento);

}

void FuncaoTempo(unsigned char segundos){

 *ptr = segundos;
 T0CON.TMR0ON = 1;
 _tempo = 1;
}


void Calculos(unsigned int *acion, unsigned int *ret){

 volatile float varTemp;
 unsigned char i, j;

 for(i = 0; i < 4; i++){
 varTemp =  (( 100.0  * *acion) / 58.7 ) ;
 *acion = varTemp;
 ++acion;
 }

 for(j = 0; j < 4; j++){
 varTemp =  (( 100.0  * *ret) / 58.7 ) ;
 *ret = varTemp;
 ++ret;
 }
}

void MotorDePasso(unsigned int passos, unsigned char sentido){

 Passos = passos;
  PORTC.RC6  = sentido;
  PORTD.RD4  = 0;
 while(Passos){
  PORTC.RC7  = 1;
 Delay_ms(5);
  PORTC.RC7  = 0;
 Delay_ms(5);
 --Passos;
 }
  PORTD.RD4  = 1;
}
