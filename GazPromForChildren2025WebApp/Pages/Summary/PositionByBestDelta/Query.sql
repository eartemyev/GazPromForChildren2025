select 
   ROW_NUMBER ( ) OVER(ORDER BY DeltaTimePoints desc, MinTime1 asc, MinTime2 asc, MinTime3 asc) Position,
   [AthleteName], DeltaTimePoints, MinTime1, MinTime2, MinTime3
from
(
  select [AthleteName], sum(DeltaTimePoints) DeltaTimePoints
  , min(Time1) MinTime1
  , min(Time2) MinTime2
  , min(Time3) MinTime3
  from [dbo].[RaceResults] 
  group by [AthleteName]
) t
order by 1