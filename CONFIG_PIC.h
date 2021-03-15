#ifndef __config_PIC_H__
#define __config_PIC_H__

#define     TRUE            1                   //Define TRUE como 1
#define     Pressostato     PORTB.RB0           //Entrada de monitoramento do pressostato
#define     MudaNivel       PORTB.RB1           //led que indica a mudança de um nível pro outro
#define     Sentido         PORTC.RC6           //pinos para controle do motor de passo RC5
#define     Step            PORTC.RC7           //------------------------ RC6
#define     Enable          PORTD.RD4           //------------------------RC4
#define     V_In            PORTD.RD7           //Válvula de entrada de ar
#define     V_Out           PORTD.RD6           //Válvula de saída de ar
#define     Led_Estab       PORTD.RD5           //Led indicador estabilizador
#define     Select          PORTD.RD1           //Botão select
#define     Enter           PORTD.RD0           //Botão enter
#define     Return          PORTD.RD2           //Botão return
#define     offset          356                 //valor do offset do sensor de pressão
#define     horario         1
#define     antihorario     0


// Pinagem do display LCD ----------------
sbit LCD_RS at RB3_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D7 at RB4_bit;
sbit LCD_D6 at RB5_bit;
sbit LCD_D5 at RB6_bit;
sbit LCD_D4 at RB7_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB3_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB4_bit;
sbit LCD_D6_Direction at TRISB5_bit;
sbit LCD_D5_Direction at TRISB6_bit;
sbit LCD_D4_Direction at TRISB7_bit;

void Config_18F(void);          //Configuração de IOs e registradores em geral
void Config_INT0(void);         //Configuração da interrupção externa
void ConfigTIMERZERO(void);     //Configuração da rotina de temporização

#endif