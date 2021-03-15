#line 1 "C:/Users/tiago/OneDrive/햞ea de Trabalho/Etapas TCC/ULTIMA_ETAPA/REGISTRADOR_ELETRONICO.c"
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
#line 1 "c:/users/tiago/onedrive/햞ea de trabalho/etapas tcc/ultima_etapa/teste.h"




void TesteEmAndamento(void);
void FuncaoTempo(unsigned char segundos);
void Calculos(unsigned int *acion, unsigned int *ret);
void MotorDePasso(unsigned int, unsigned char);
#line 21 "C:/Users/tiago/OneDrive/햞ea de Trabalho/Etapas TCC/ULTIMA_ETAPA/REGISTRADOR_ELETRONICO.c"
extern bit _lcdClr;
extern bit _telaInicial;
extern bit _enter;
extern bit _select;
extern bit _return;
extern bit _menu;
extern bit _atualizaLcd;
extern bit _submenu1;
extern bit _teste;
extern bit _iniciado;
extern bit _emAndamento;
extern bit _tempo;
extern bit _resultado;
extern unsigned char Linha;
extern unsigned char Tela;
extern unsigned int Acionamento[4];
extern unsigned int Retorno[4];
bit _acionamento;
bit _retorno;
volatile unsigned char counter = 1;
extern unsigned char timer;
extern unsigned char *ptr;
extern unsigned char Nivel;
volatile unsigned char flagAc = 0, flagRet = 0;



void Interrupt_HIGH() iv 0x0008 ics ICS_AUTO {

 volatile static unsigned char x = 3;
 volatile static unsigned char nivel = 0;
 volatile unsigned int LeituraAdc = 0;
 volatile unsigned char acc = 10;

 while(acc){
 LeituraAdc += ADC_Read(0);
 --acc;
 }

 if(INTCON.INT0IF){

 if(! PORTB.RB0 ) flagAc = 1;
 if( PORTB.RB0 ) flagRet = 1;

 if(! PORTB.RB0  && flagAc){

  PORTD.RD7  = 0;
 Acionamento[nivel] = ((LeituraAdc/10) -  356 );
 _acionamento = 1;
 flagAc = 0;
 }
 else
 if( PORTB.RB0  && flagRet){

  PORTD.RD6  = 0;
 Retorno[nivel] = ((LeituraAdc/10) -  356 );
 _retorno = 1;
 ++nivel;
 flagRet = 0;
 }

 INTCON.INT0IF = 0;
 INTCON2.INTEDG0 = (x % 2);
 ++x;

 if(nivel == 4){

 INTCON.INT0IE = 0;
 _resultado = 1;
 }

 }
}



void Interrupt_LOW() iv 0x0018 ics ICS_AUTO {

 if(INTCON.TMR0IF){

 if(counter < timer){

 ++counter;
 }
 else{

 counter = 1;
 T0CON.TMR0ON = 0;
 }

 TMR0H = 0xC2;
 TMR0L = 0xF7;
 INTCON.TMR0IF = 0;
 }
}


void main() {

 Config_18F();
 Config_INT0();
 ConfigTIMERZERO();
 Lcd_Init();
 ADC_Init();
 TelaInicial();
  PORTD.RD4  = 1;


 while( 1 ){

 LerBotoes();
 if(_telaInicial && Tela == 1){
 MenuPrincipal();
 _enter = 0;
 _telaInicial = 0;
 }

 if(_atualizaLcd || (!(_menu) && Tela == 1)) MenuPrincipal();

 if(Tela == 2 && !(_submenu1)){

 SubMenu1();
 _menu = 0;
 }

 if(Tela == 3 && !(_teste) && !(_iniciado)){

 MsgTestInProgress();
 }

 if(_teste) TesteEmAndamento();


 }

}
