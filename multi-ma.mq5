//+------------------------------------------------------------------+
//|                                                     multi-ma.mq5 |
//|                                        Copyright 2025, Clarence. |
//|                                              https://mcode.co.za |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, Clarence."
#property link      "https://mcode.co.za"
#property version   "1.00"
#property indicator_chart_window

#property indicator_buffers 4
#property indicator_plots 4

#property indicator_label1 "SMA"
#property indicator_label2 "EMA"
#property indicator_label3 "SMMA"
#property indicator_label4 "WMA"

// initials dynamic buffers
double sma[];
double ema[];
double smma[];
double wma[];

// user input
input ENUM_DRAW_TYPE drawTypeSma = DRAW_LINE;   //Simple Moving Averages
input ENUM_DRAW_TYPE drawTypeEma = DRAW_LINE;   //Exponenctial Moving Averages
input ENUM_DRAW_TYPE drawTypeSmma = DRAW_LINE;  //Smoothed Moving Averages
input ENUM_DRAW_TYPE drawTypeWma = DRAW_LINE;   //Weighted Moving Averages

input ENUM_LINE_STYLE lineStyleSma = STYLE_SOLID;
input ENUM_LINE_STYLE lineStyleEma = STYLE_SOLID;
input ENUM_LINE_STYLE lineStyleSmma = STYLE_SOLID;
input ENUM_LINE_STYLE lineStyleWma = STYLE_SOLID;

input int sma_period = 10;
input int sma_shift = 0;

input int ema_period = 10;
input int ema_shift = 0;

input int smma_period = 10;
input int smma_shift = 0;

input int wma_period = 10;
input int wma_shift = 0;

input ENUM_APPLIED_PRICE sma_price = PRICE_CLOSE;
input ENUM_APPLIED_PRICE ema_price = PRICE_CLOSE;
input ENUM_APPLIED_PRICE smma_price = PRICE_CLOSE;
input ENUM_APPLIED_PRICE wma_price = PRICE_CLOSE;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0, sma);
   SetIndexBuffer(1, ema);
   SetIndexBuffer(2, smma);
   SetIndexBuffer(3, wma);
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
