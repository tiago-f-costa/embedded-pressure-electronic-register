#include "teste.h"
#include "config_PIC.h"
#include "display.h"

#define     constante           58.7                            //constante para o cálculo equivale a 2,87mV
#define     referencia          100.0                          //referência de 100mmca
#define     Pressao(referencia, ADC, constante)        ((referencia * ADC) / constante)  //macro para cálculo

bit _emAndamento;
bit _tempo;
bit _resultado;
bit _final;
bit _nb, _nm, _na;
unsigned int Acionamento[4];            //vetor que irá armazenar os valores da pressão de Acionamento
unsigned int Retorno[4];              //vetor que irá armazenar os valores de pressão de Retorno
unsigned char timer;
unsigned char *ptr = &timer;
extern bit _acionamento;                              //flag que indica o Acionamento
extern bit _retorno;                                  //flag que indica o retorno do pressostato
extern volatile unsigned char counter;
unsigned int Passos;
unsigned char Nivel = 0;

void TesteEmAndamento(void){

   if(!(_emAndamento)){
         V_In = 1;                                 //Liga a válvula de entrada
         _tempo = 0;                               //garante a flag zerada
         _resultado = 0;                           //garante a flag zerada
         _final = 0;
         _acionamento = 0;
         _retorno = 0;
         _nb = 0, _nm = 1, _na = 1;

       }

      do{
           _emAndamento = 1;                         //seta a flag
           if(_retorno){
                if(!(_tempo)) FuncaoTempo(10);      //chama a função tempo para contar 10s
                  switch(counter){
                  
                      case 2: V_Out = 1;             //liga válvula de saída pra mudar nível
                              MudaNivel = 1;         //led de sinalização pra mudar nível
                              if(!(_nb)){
                                    MotorDePasso(258, horario);
                                    _nb = 1;          //seta a flag
                                    _nm = 0;
                                  }
                              else
                              if(_nb && !(_nm)){
                                    MotorDePasso(248, horario);
                                    _nm = 1;
                                    _na = 0;
                                  }
                              else
                              if(_nm && !(_na)){
                                    MotorDePasso(244, horario);
                                    _na = 1;
                                  }
                              break;

                      case 9: V_Out = 0;             //desliga válvula de saída
                              MudaNivel = 0;         //desliga led
                              _retorno = 0;
                              _tempo = 0;
                              V_In = 1;              //liga válvula de entrada para novo ciclo
                              break;
                  }
             }
             
           if(_acionamento){

                if(!(_tempo)) FuncaoTempo(10);      //chama a função tempo para contar 10s
                   switch(counter){

                       case 2: Led_Estab = 1;       //led que indica estabilização da leitura do sensor
                               break;

                       case 7: Led_Estab = 0;       //desliga o led estabilizador
                               break;

                       case 9: V_Out = 1;           //liga válvula de saída pra despressurizar o sistema
                               _acionamento = 0;    //apaga a flag
                               _tempo = 0;
                               break;
                   }
            }
            

            if(_resultado){
            
                 Calculos(Acionamento, Retorno);    //chama a função para realizar os cálculos
                 Resultados(Acionamento, Retorno);  //chama a função que imprime os Resultados no display
                 _final = 1;                        //seta a flag final
            }

            while(_final);

         }while(_emAndamento);

}

void FuncaoTempo(unsigned char segundos){

  *ptr = segundos;
  T0CON.TMR0ON = 1;                      //Liga Contagem do timer
  _tempo = 1;                            //seta a flag
}


void Calculos(unsigned int *acion, unsigned int *ret){

   volatile float varTemp;          //variável temporária para cálculos
   unsigned char i, j;
   
     for(i = 0; i < 4; i++){                 //laço for para as pressões de acionamento
          varTemp = Pressao(referencia, *acion, constante);
          *acion = varTemp;
          ++acion;                      //incrementa o ponteiro para ir ao próximo endereço
       }
       
     for(j = 0; j < 4; j++){                     //laço for para as pressões de retorno
          varTemp = Pressao(referencia, *ret, constante);
          *ret = varTemp;
          ++ret;                      //incrementa o ponteiro para ir ao próximo endereço
       }
}

void MotorDePasso(unsigned int passos, unsigned char sentido){

    Passos = passos;
    Sentido = sentido;
    Enable = 0;             //habilita alimentação para as bobinas
    while(Passos){
       Step = 1;
       Delay_ms(5);
       Step = 0;
       Delay_ms(5);
       --Passos;
    }
    Enable = 1;             //desabilita a alimentação para as bobinas
}
