SELECT 
  ROW_NUMBER ( ) OVER(ORDER BY TotalPoints desc, MinTime1 asc, MinTime2 asc, MinTime3 asc) Position,
  [AthleteName], TotalPoints, MinTime1, MinTime2, MinTime3
FROM
(
  select [AthleteName], sum(TotalPoints) TotalPoints
    , min(Time1) MinTime1
    , min(Time2) MinTime2
    , min(Time3) MinTime3
  from [dbo].[RaceResults] 
  group by [AthleteName]
) t
order by 1