#include "display.h"
#include "config_PIC.h"
#include "teste.h"

unsigned char Linha = 2;
unsigned char Tela = 0;


// -------- Separação da variável Flag em vários bits -----------
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
extern bit _acionamento;                              //flag que indica o Acionamento
extern bit _retorno;                                  //flag que indica o retorno do pressostato
extern unsigned int Acionamento[4];            //vetor que irá armazenar os valores da pressão de Acionamento
extern unsigned int Retorno[4];              //vetor que irá armazenar os valores de pressão de Retorno
char txt1[6];                                         //vetores para realizar as conversões para o display
char txt2[6];
char txt3[6];
char txt4[6];
char txt5[6];
char txt6[6];
char txt7[6];
char txt8[6];

// --------------------------------------------------------------

void TelaInicial(void){

     _lcdClr = 1;                       //Seta a Flag para a função ClearLcd
     ClearLcd();                        //Apaga o display
     Lcd_Cmd(_LCD_CURSOR_OFF);          //Desliga o Cursor
     Lcd_Out(1,4,"Registrador");
     Lcd_Out(2,4,"Eletronico de");
     Lcd_Out(3,4,"Pressao...");
     Lcd_Out(4,4, "Aperte [ENTER]");
     _telaInicial = 1;                  //seta a Flag da tela inicial
     _teste = 0;                        //garante a flag apagada
     _iniciado = 0;
}

void MenuPrincipal(void){

  _lcdClr = 1;
  ClearLcd();
  Lcd_Chr(Linha,1, '>');
  Lcd_Out(2,3, "Iniciar Teste");
  Lcd_Out(3,3, "Ultimos Resultados");
  _atualizaLcd = 0;                  //pra garantia que a flag está limpa
  _menu = 1;
  _submenu1 = 0;                     //garante que a flag do submenu esteja limpa
}

void SubMenu1(void){

   _lcdClr = 1;
   ClearLcd();
   Lcd_Out(2,1,"[ENTER] - Iniciar");
   Lcd_Out(3,1,"[RETURN] - Voltar");
   _submenu1 = 1;
   _teste = 0;             //garante a flag de teste apagada

}

void MsgTestInProgress(void){

   _lcdClr = 1;
   ClearLcd();
   Lcd_Out(2,7,"Teste");
   Lcd_Out(3,2,"Em Andamento...");
   _teste = 1;                    //seta a flag
   _emAndamento = 0;              //garante as flags apagadas
   _acionamento = 0;
   _retorno = 0;
}

void Resultados(unsigned int *acion, unsigned int *ret){


    WordToStr(*acion, txt1);         //passa o valor para string
    ++acion;                         //incrementa o ponteiro
    WordToStr(*acion, txt2);
    ++acion;
    WordToStr(*acion, txt3);
    ++acion;
    WordToStr(*acion, txt4);
    
    WordToStr(*ret, txt5);         //passa o valor para string
    ++ret;                         //incrementa o ponteiro
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

    if(!Enter) _enter = 1;              //se enter for pressionado seta a flag
    if(!Select) _select = 1;
    if(!Return) _return = 1;
    
    if(Select && _select){
    
      ++Linha;
      if(Linha > 3) Linha = 2;
      _select = 0;
      _atualizaLcd = 1;
    }
    if(Enter && _enter){
    
      ++Tela;
      _enter = 0;       //apaga a flag
    }
    
    if(Return && _return){
    
       _return = 0;       //apaga a flag
       if(Tela > 0) --Tela;            //decrementa a variável Tela

    }
}