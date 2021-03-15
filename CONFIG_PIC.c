#include "config_PIC.h"

void Config_18F(void){

   ADCON0 = 0B00000000;  //RA0 Como analógica
   ADCON1 = 0B00001110;  //Inicialmente todos digitais com exceção do AN0
   TRISB = 0B00000001;         //PORTB como saída e RB0 como entrada
   TRISC = 0B00000000;         //será utilizado para o motor de passo
   TRISD = 0B00001111;   //O Nibble menos significativo como entrada
   PORTD = 0B00001111;   //PORTD inicia com as saídas em zero
   TRISA.RA0 = 1;        //RA0 como entrada para realizar a leitura analógica
   TRISB.RB0 = 1;        //RB0 como entrada para a interrupção externa
}

void Config_INT0(void){

// --------------- Interrupção Global -----------------------
   INTCON.GIEH = 1;                //Habilita Interrupção global
   INTCON.GIEL = 1;                //Habilita Interrupção baixa prioridade
   RCON.IPEN = 1;                //Se zero fica compátivel com a linha 16F
// -----------------------------------------------------------

// --------------- Interrupção externa INT0 -------------------
   INTCON.INT0IE = 1;          //Habilita interrupção INT0
   INTCON.INT0IF = 0;          //Flag da interrupção INT0 inicia em zero
   INTCON2.INTEDG0 = 0;        //Interrupção na borda de descida
// -------------------------------------------------------------
}

void ConfigTIMERZERO()
{
   T0CON = 0B00000110;                  //PRESCALER 1:128, INICIA OFF, MODO 16BITS
   TMR0H = 0xC2;                        //CARGA CALCULADA PARA 1s
   TMR0L = 0xF7;
    
    // ---- Configuração Interrupção TIMER0 ------------
   INTCON.TMR0IF = 0;                   //FLAG INICIA LIMPA
   INTCON.TMR0IE = 1;                   //HABILITA INTERRUPÇÃO DO TIMER ZERO
   INTCON2.TMR0IP = 0;                  //BAIXA PRIORIDADE DE INTERRUPÇÃO
}