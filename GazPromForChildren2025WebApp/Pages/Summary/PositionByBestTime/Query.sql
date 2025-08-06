select 
  ROW_NUMBER ( ) OVER(ORDER BY BestTimePoints desc, MinTime1 asc, MinTime2 asc, MinTime3 asc) Position,
  [AthleteName], BestTimePoints, MinTime1, MinTime2, MinTime3
from
(
  select [AthleteName], sum(BestTimePoints) BestTimePoints
    , min(Time1) MinTime1
    , min(Time2) MinTime2
    , min(Time3) MinTime3
  from [dbo].[RaceResults] 
  group by [AthleteName]
) t
order by 1;