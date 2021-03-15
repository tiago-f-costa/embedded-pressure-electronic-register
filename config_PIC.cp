#line 1 "C:/Users/tiago/OneDrive/햞ea de Trabalho/Etapas TCC/ULTIMA_ETAPA/config_PIC.c"
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
#line 3 "C:/Users/tiago/OneDrive/햞ea de Trabalho/Etapas TCC/ULTIMA_ETAPA/config_PIC.c"
void Config_18F(void){

 ADCON0 = 0B00000000;
 ADCON1 = 0B00001110;
 TRISB = 0B00000001;
 TRISC = 0B00000000;
 TRISD = 0B00001111;
 PORTD = 0B00001111;
 TRISA.RA0 = 1;
 TRISB.RB0 = 1;
}

void Config_INT0(void){


 INTCON.GIEH = 1;
 INTCON.GIEL = 1;
 RCON.IPEN = 1;



 INTCON.INT0IE = 1;
 INTCON.INT0IF = 0;
 INTCON2.INTEDG0 = 0;

}

void ConfigTIMERZERO()
{
 T0CON = 0B00000110;
 TMR0H = 0xC2;
 TMR0L = 0xF7;


 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;
 INTCON2.TMR0IP = 0;
}
