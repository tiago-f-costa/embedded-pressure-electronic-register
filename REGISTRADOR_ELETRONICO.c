/*  ----------------- Registrador Eletrônico de pressão ------------------------------
--------------------------------------------------------------------------------------
-> Autor: Tiago Fontoura Costa -------------------------------------------------------
--------------------------------------------------------------------------------------
-> Objetivo: Registrar os valores de pressão de acionamento e retorno de -------------
pressostatos eletromecânicos de 04 níveis que são utilizados em lavadoras de roupas, -
de maneira autônoma inclusove mudando os níveis de maneira automática através de -----
um motor de passo. -------------------------------------------------------------------
--------------------------------------------------------------------------------------
-> Microcontrolador: PIC18F4550, Clock: 8MHz, Display LCD 20x4 -----------------------
-> Data inicial: 23/02/2021 (salientando que esse projeto é uma melhoria realizada no
TCC apresentado em Novembro/2020 a UNIP no curso Engenharia de Controle e Automação).
Portanto é um projeto que teve real início no primeiro semestre de 2020. -------------
-----------------------------------------------------------------------------------*/

#include "config_PIC.h"
#include "display.h"
#include "teste.h"

// --- Variáveis e Flags declaradas em outros arquivos ---
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
extern unsigned int Acionamento[4];            //vetor que irá armazenar os valores da pressão de Acionamento
extern unsigned int Retorno[4];              //vetor que irá armazenar os valores de pressão de retorno
bit _acionamento;                              //flag que indica o Acionamento
bit _retorno;                                  //flag que indica o retorno do pressostato
volatile unsigned char counter = 1;            //será utilizada na temporização
extern unsigned char timer;
extern unsigned char *ptr;
extern unsigned char Nivel;
volatile unsigned char flagAc = 0, flagRet = 0;
//-------------------------------------------------------

// ============ Vetor de Interrupção Alta Prioridade =============
void Interrupt_HIGH() iv 0x0008 ics ICS_AUTO {

   volatile static unsigned char x = 3;       //variável para auxiliar na mudança de borda
   volatile static unsigned char nivel = 0;   //vai informar os níveis das leituras
   volatile unsigned int LeituraAdc = 0;      //variável que armzena o valor do ADC
   volatile unsigned char acc = 10;

            while(acc){
               LeituraAdc += ADC_Read(0);
               --acc;
            }

     if(INTCON.INT0IF){

        if(!Pressostato) flagAc = 1;
        if(Pressostato) flagRet = 1;

        if(!Pressostato && flagAc){           //Se Normalmente fechado

           V_In = 0;                                 //Desliga válvula de entrada
           Acionamento[nivel] = ((LeituraAdc/10) - offset);         //vai receber o valor da leitura analógica
           _acionamento = 1;                        //flag que indica o Acionamento
           flagAc = 0;                              //limpa a flag
        }
        else
        if(Pressostato && flagRet){          //Se Normalmente aberto

           V_Out = 0;                              //Desliga válvula de saída
           Retorno[nivel] = ((LeituraAdc/10) - offset);
           _retorno = 1;
           ++nivel;                    //Incrementa o nível para armazenar o valor do próximo nível
           flagRet = 0;                //limpa a flag
        }

           INTCON.INT0IF = 0;                       //Apaga a flag
           INTCON2.INTEDG0 = (x % 2);                //Altera o tipo de borda a cada passagem
           ++x;

           if(nivel == 4){

              INTCON.INT0IE = 0;                     //desabilita interrupção externa
              _resultado = 1;                        //seta a flag
           }

     }
} // ========= Fim Vetor de Interrupção Alta Prioridade ==========


// ============== Vetor de Interrupção de Baixa Prioridade ==================
void Interrupt_LOW() iv 0x0018 ics ICS_AUTO {

   if(INTCON.TMR0IF){

      if(counter < timer){  //se o contador for menor que o tempo desejado incrementa
      
         ++counter;
       }
       else{                //se o contador for maior ou igual então reseta
       
         counter = 1;
         T0CON.TMR0ON = 0;      //Desliga o timer
       }
       
       TMR0H = 0xC2;                     //Recarrega os registradores para 1s
       TMR0L = 0xF7;
       INTCON.TMR0IF = 0;                //Zera a flag para a próxima contagem
     }
} // =========== Fim do Vetor de Interrupção de Baixa Prioridade =============


void main() {  // --------- Inicio Função Principal ------------

  Config_18F();                    //Configuração registradores I/Os
  Config_INT0();                   //Configuração interrupção externa
  ConfigTIMERZERO();               //Configuração interrupção e timer zero
  Lcd_Init();                      //Função nativa compilador que inializa LCD
  ADC_Init();                      //Inicializa o Conversor AD
  TelaInicial();                   //Função que printa tela inicial
  Enable = 1;                      //pra o motorde passo não receber vcc nas bobinas inicialmente

  
  while(TRUE){ // ------ Início Loop Infinito ---------
  
    LerBotoes();                     //função para varredura das teclas
    if(_telaInicial && Tela == 1){
       MenuPrincipal();              //printa o menu principal no LCD
       _enter = 0;                   //limpa a flag enter
       _telaInicial = 0;             //Limpa a flag tela inicial
    }
    
    if(_atualizaLcd || (!(_menu) && Tela == 1)) MenuPrincipal();  //Para atualizar o LCD caso o usuário solicite um comando
    
    if(Tela == 2 && !(_submenu1)){                                //Para acessar o submenu 1 da interface
    
       SubMenu1();
       _menu = 0;                 //apaga a flag de sinalização do Menu principal
    }
    
    if(Tela == 3 && !(_teste) && !(_iniciado)){
    
       MsgTestInProgress();
    }
    
    if(_teste) TesteEmAndamento();


  } // ---------- Fim do Loop infinito -----------------

}// -------- Fim Função Principal -----------------