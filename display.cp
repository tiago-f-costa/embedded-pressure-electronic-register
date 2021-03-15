#line 1 "C:/Users/tiago/OneDrive/햞ea de Trabalho/Etapas TCC/ULTIMA_ETAPA/display.c"
#line 1 "c:/users/tiago/onedrive/햞ea de trabalho/etapas tcc/ultima_etapa/display.h"




void TelaInicial(void);
void ClearLcd(void);
void LerBotoes(void);
void MenuPrincipal(void);
void SubMenu1(void);
void MsgTestInProgress(void);
void Resultados(unsigned int *acion, unsigned int *ret);
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
#line 1 "c:/users/tiago/onedrive/햞ea de trabalho/etapas tcc/ultima_etapa/teste.h"




void TesteEmAndamento(void);
void FuncaoTempo(unsigned char segundos);
void Calculos(unsigned int *acion, unsigned int *ret);
void MotorDePasso(unsigned int, unsigned char);
#line 5 "C:/Users/tiago/OneDrive/햞ea de Trabalho/Etapas TCC/ULTIMA_ETAPA/display.c"
unsigned char Linha = 2;
unsigned char Tela = 0;



bit _lcdClr;
bit _telaInicial;
bit _enter;
bit _select;
bit _return;
bit _menu;
bit _atualizaLcd;
bit _submenu1;
bit _teste;
bit _iniciado;
extern bit _emAndamento;
extern bit _acionamento;
extern bit _retorno;
extern unsigned int Acionamento[4];
extern unsigned int Retorno[4];
char txt1[6];
char txt2[6];
char txt3[6];
char txt4[6];
char txt5[6];
char txt6[6];
char txt7[6];
char txt8[6];



void TelaInicial(void){

 _lcdClr = 1;
 ClearLcd();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,4,"Registrador");
 Lcd_Out(2,4,"Eletronico de");
 Lcd_Out(3,4,"Pressao...");
 Lcd_Out(4,4, "Aperte [ENTER]");
 _telaInicial = 1;
 _teste = 0;
 _iniciado = 0;
}

void MenuPrincipal(void){

 _lcdClr = 1;
 ClearLcd();
 Lcd_Chr(Linha,1, '>');
 Lcd_Out(2,3, "Iniciar Teste");
 Lcd_Out(3,3, "Ultimos Resultados");
 _atualizaLcd = 0;
 _menu = 1;
 _submenu1 = 0;
}

void SubMenu1(void){

 _lcdClr = 1;
 ClearLcd();
 Lcd_Out(2,1,"[ENTER] - Iniciar");
 Lcd_Out(3,1,"[RETURN] - Voltar");
 _submenu1 = 1;
 _teste = 0;

}

void MsgTestInProgress(void){

 _lcdClr = 1;
 ClearLcd();
 Lcd_Out(2,7,"Teste");
 Lcd_Out(3,2,"Em Andamento...");
 _teste = 1;
 _emAndamento = 0;
 _acionamento = 0;
 _retorno = 0;
}

void Resultados(unsigned int *acion, unsigned int *ret){


 WordToStr(*acion, txt1);
 ++acion;
 WordToStr(*acion, txt2);
 ++acion;
 WordToStr(*acion, txt3);
 ++acion;
 WordToStr(*acion, txt4);

 WordToStr(*ret, txt5);
 ++ret;
 WordToStr(*ret, txt6);
 ++ret;
 WordToStr(*ret, txt7);
 ++ret;
 WordToStr(*ret, txt8);

 _lcdClr = 1;
 ClearLcd();
 Lcd_Out(1,1,"NEB:      Ret:      ");
 Lcd_Out(1,5, txt1);
 Lcd_Out(1,15, txt5);
 Lcd_Out(2,1,"NB:      Ret:      ");
 Lcd_Out(2,4, txt2);
 Lcd_Out(2,14, txt6);
 Lcd_Out(3,1,"NM:      Ret:      ");
 Lcd_Out(3,4, txt3);
 Lcd_Out(3,14, txt7);
 Lcd_Out(4,1,"NA:      Ret:      ");
 Lcd_Out(4,4, txt4);
 Lcd_Out(4,14, txt8);
}

void ClearLcd(void)
{
 if(_lcdClr){
 Lcd_Cmd(_LCD_CLEAR);
 _lcdClr = 0;
 }
}

void LerBotoes(void){

 if(! PORTD.RD0 ) _enter = 1;
 if(! PORTD.RD1 ) _select = 1;
 if(! PORTD.RD2 ) _return = 1;

 if( PORTD.RD1  && _select){

 ++Linha;
 if(Linha > 3) Linha = 2;
 _select = 0;
 _atualizaLcd = 1;
 }
 if( PORTD.RD0  && _enter){

 ++Tela;
 _enter = 0;
 }

 if( PORTD.RD2  && _return){

 _return = 0;
 if(Tela > 0) --Tela;

 }
}
