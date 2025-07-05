//+------------------------------------------------------------------+
//|                                                     multi-ma.mq5 |
//|                                        Copyright 2025, Clarence. |
//|                                              https://mcode.co.za |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, Clarence."
#property link      "https://mcode.co.za"
#property version   "1.00"

#property description "This indicator it based on 4 moving averages."
#property description "Simple Moving Averages"
#property description "Exponential Moving Averages"
#property description "Smoothed Moving Averages"
#property description "Weighted Moving Averages"
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
// moving averages line type
input ENUM_DRAW_TYPE drawTypeSma = DRAW_LINE;   //Simple Moving Averages
input ENUM_DRAW_TYPE drawTypeEma = DRAW_LINE;   //Exponential Moving Averages
input ENUM_DRAW_TYPE drawTypeSmma = DRAW_LINE;  //Smoothed Moving Averages
input ENUM_DRAW_TYPE drawTypeWma = DRAW_LINE;   //Weighted Moving Averages

// moving averages line style
input ENUM_LINE_STYLE lineStyleSma = STYLE_SOLID;  //Line Style SMA
input ENUM_LINE_STYLE lineStyleEma = STYLE_SOLID;  //Line Style EMA
input ENUM_LINE_STYLE lineStyleSmma = STYLE_SOLID; //Line Style SMMA
input ENUM_LINE_STYLE lineStyleWma = STYLE_SOLID;  //Line Style WMA

// moving averages periods and shifts
input uint sma_period = 10;   //SMA Period
input int sma_shift = 0;   //SMA Shift

input uint ema_period = 10;   //EMA Period
input int ema_shift = 0;   //EMA Shift

input uint smma_period = 10;  //SMMA Period
input int smma_shift = 0;  //SMMA Shift

input uint wma_period = 10;   //WMA Period
input int wma_shift = 0;   //WMA Shift

// moving averages applied prices
input ENUM_APPLIED_PRICE sma_price = PRICE_CLOSE;  //SMA Price
input ENUM_APPLIED_PRICE ema_price = PRICE_CLOSE;  //EMA Price
input ENUM_APPLIED_PRICE smma_price = PRICE_CLOSE; //SMMA Price
input ENUM_APPLIED_PRICE wma_price = PRICE_CLOSE;  //WMA Price

// moving averages period handles
uint sma_p;
uint ema_p;
uint smma_p;
uint wma_p;

// moving averages handles
int sma_handle;
int ema_handle;
int smma_handle;
int wma_handle;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  // initialize periods
  sma_p = (sma_period < 1 ? 10 : sma_period);
  ema_p = (ema_period < 1 ? 10 : ema_period);
  smma_p = (smma_period < 1 ? 10 : smma_period);
  wma_p = (wma_period < 1 ? 10 : wma_period);
  
  //--- indicator title
  IndicatorSetString(INDICATOR_SHORTNAME, "Multi-MA");
//--- indicator buffers mapping
   SetIndexBuffer(0, sma);
   SetIndexBuffer(1, ema);
   SetIndexBuffer(2, smma);
   SetIndexBuffer(3, wma);
   
   // plot index
   PlotIndexSetInteger(0, PLOT_DRAW_TYPE, drawTypeSma);
   PlotIndexSetInteger(0, PLOT_LINE_STYLE, lineStyleSma);
   PlotIndexSetInteger(0, PLOT_LINE_COLOR, clrBlue);
   
   PlotIndexSetInteger(1, PLOT_DRAW_TYPE, drawTypeEma);
   PlotIndexSetInteger(1, PLOT_LINE_STYLE, lineStyleEma);
   PlotIndexSetInteger(1, PLOT_LINE_COLOR, clrRed);
   
   PlotIndexSetInteger(2, PLOT_DRAW_TYPE, drawTypeSmma);
   PlotIndexSetInteger(2, PLOT_LINE_STYLE, lineStyleSmma);
   PlotIndexSetInteger(2, PLOT_LINE_COLOR, clrYellow);
   
   PlotIndexSetInteger(3, PLOT_DRAW_TYPE, drawTypeWma);
   PlotIndexSetInteger(3, PLOT_LINE_STYLE, lineStyleWma);
   PlotIndexSetInteger(3, PLOT_LINE_COLOR, clrGreen);
   
   ArraySetAsSeries(sma, true);
   ArraySetAsSeries(ema, true);
   ArraySetAsSeries(smma, true);
   ArraySetAsSeries(wma, true);
   
   // assigning handles
   sma_handle = iMA(NULL, 0, sma_p, sma_shift, MODE_SMA, sma_price);
   ema_handle = iMA(NULL, 0, ema_p, ema_shift, MODE_EMA, ema_price);
   smma_handle = iMA(NULL, 0, smma_p, smma_shift, MODE_SMMA, smma_price);
   wma_handle = iMA(NULL, 0, wma_p, wma_shift, MODE_LWMA, wma_price);
   
   ResetLastError();
   
   if (sma_handle == INVALID_HANDLE || ema_handle == INVALID_HANDLE || smma_handle == INVALID_HANDLE || wma_handle == INVALID_HANDLE)
   {
      Alert("Error For Creating Handles for indicators: %d", GetLastError(), "!!");
      return(INIT_FAILED);
   }
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
   // return the number of bars that the indicator has calculated for
   if(BarsCalculated(sma_handle) < rates_total || BarsCalculated(ema_handle) < rates_total || BarsCalculated(smma_handle) < rates_total || BarsCalculated(wma_handle) < rates_total)
   {
      return(0);
   }
   
   // number of candles to copy
   int copy;
   if(prev_calculated > rates_total || prev_calculated <= 0)
   {
      copy = rates_total;
   }
   else
   {
      copy = rates_total - prev_calculated;
      copy++;
   }
   if(CopyBuffer(sma_handle, 0, 0, copy, sma) < 0 || CopyBuffer(ema_handle, 0, 0, copy, ema) < 0 || CopyBuffer(smma_handle, 0, 0, copy, smma) < 0 || CopyBuffer(wma_handle, 0, 0, copy, wma) < 0)
   {
      Alert("Error copying Moving Average indicators Buffers - error:",GetLastError(),"!!");
      return(0);
   }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
  
void OnDeinit(const int reason)
{
   // release indicators
   IndicatorRelease(sma_handle);
   IndicatorRelease(ema_handle);
   IndicatorRelease(smma_handle);
   IndicatorRelease(wma_handle);
}
//+------------------------------------------------------------------+
