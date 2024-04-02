//+------------------------------------------------------------------+
//|                                             env_ma_indicator.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link "https://www.mql5.com"
#property version "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 4

//---vars
double fastBuffer[], slowBuffer[], buyBuffer[], sellBuffer[];
#define fastMaIndcator 0
#define slowMaIndcator 1
#define buyIndcator 2
#define sellIndcator 3

//--- inputs
extern int fastMaPeriod = 23;
extern int slowMaPeriod = 600;



//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
  //--- indicator buffers mapping
  SetIndexBuffer(fastMaIndcator, fastBuffer);
  SetIndexStyle(fastMaIndcator, DRAW_LINE, STYLE_SOLID, 2, clrPurple);

  SetIndexBuffer(slowMaIndcator, slowBuffer);
  SetIndexStyle(slowMaIndcator, DRAW_LINE, STYLE_SOLID, 2, clrGold);

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
  if (limit==0)
    limit++;

  for (int i = 0; i < limit; i++)
  {
    double fastMaValue = NormalizeDouble(iMA(_Symbol, PERIOD_CURRENT, fastMaPeriod, 0, MODE_SMA, PRICE_CLOSE, i), _Digits);
    double slowMaValue = NormalizeDouble(iMA(_Symbol, PERIOD_CURRENT, slowMaPeriod, 0, MODE_SMA, PRICE_CLOSE, i), _Digits);

    fastBuffer[i]=fastMaValue;
    slowBuffer[i]=slowMaValue;

  }

  //--- return value of prev_calculated for next call
  return (rates_total);
}
//+------------------------------------------------------------------+
