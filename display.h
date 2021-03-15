#ifndef __display_H__
#define __display_H__


void TelaInicial(void);         //função que printa primeira tela do display
void ClearLcd(void);            //função utilizada para apagar o display
void LerBotoes(void);           //Função para ler os push buttons
void MenuPrincipal(void);       //função para o menu principal
void SubMenu1(void);
void MsgTestInProgress(void);
void Resultados(unsigned int *acion, unsigned int *ret);



#endif