//+------------------------------------------------------------------+
//|                                                       pinbar.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link "https://www.mql5.com"
#property version "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 2

//---variable
double buyBuffer[], sellBuffer[];
#define buyIndicator 0
#define sellIndicator 1

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
  //--- indicator buffers mapping
  SetIndexBuffer(buyIndicator, buyBuffer);
  SetIndexStyle(buyIndicator, DRAW_ARROW, STYLE_SOLID, 2, clrGreen);
  SetIndexArrow(buyIndicator, 218);

  SetIndexBuffer(sellIndicator, sellBuffer);
  SetIndexStyle(sellIndicator, DRAW_ARROW, STYLE_SOLID, 2, clrRed);
  SetIndexArrow(sellIndicator, 217);

  //---
  return (INIT_SUCCEEDED);
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
  int limit = rates_total - prev_calculated - 1;
  if (limit == 0)
    limit++;

  for (int i = 0; i < limit; i++)
  {
    if (i == iHighest(_Symbol, PERIOD_CURRENT, MODE_CLOSE, 1000,i))
    {
      buyBuffer[i] = High[i] + 20 * _Point;
    }
    else if (i == iLowest(_Symbol, PERIOD_CURRENT, MODE_CLOSE, 1000,i))
    {
      sellBuffer[i] = Low[i] - 20 * _Point;
    }
  }

  //--- return value of prev_calculated for next call
  return (rates_total);
}
//+------------------------------------------------------------------+
