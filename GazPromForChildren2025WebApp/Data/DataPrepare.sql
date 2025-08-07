-- 1. Set best lap value (update manually)
SELECT TOP 1000 [RaceNumber] ,[LapNumber] ,[CarNumber] ,[Time] ,[BestLap] 
FROM [dbo].[RaceLapTime] 
-- WHERE [BestLap] > 0 
ORDER BY [RaceNumber], [CarNumber], [Time]

-- 2. insert into [dbo].[RaceResults] 
  insert into [dbo].[RaceResults] 
  (
    [RaceNumber], [CarNumber], [AthleteId], [AthleteName],
    [Time1], [Time2], [Time3], [TimeDelta],
    [DeltaTimePosition], [BestTimePosition], [TotalPosition],
    [DeltaTimePoints],[BestTimePoints],[TotalPoints]
  )

  select --t.*,
     t.RaceNumber, t.CarNumber, t.AthleteId , t.AthleteName,
     t.Time1, t.Time2, t.Time3, t.TimeDelta,
     t.DeltaTimePosition, t.BestTimePosition, 0 /*(t.BestTimePosition + t.DeltaTimePosition)*/ [TotalPosition],

     [dbo].[CalcPointByPosition](t.DeltaTimePosition) DeltaTimePoints, 
     [dbo].[CalcPointByPosition](t.BestTimePosition) BestTimePoints,
     ([dbo].[CalcPointByPosition](t.DeltaTimePosition) + [dbo].[CalcPointByPosition] (t.BestTimePosition)) TotalPoints
  from
  (
    select *,
        ROW_NUMBER ( ) OVER(PARTITION BY RaceNumber ORDER BY Time1 ASC, Time2 ASC, Time2 ASC) BestTimePosition,
        ROW_NUMBER ( ) OVER(PARTITION BY RaceNumber ORDER BY TimeDelta ASC,Time1 ASC, Time2 ASC, Time2 ASC) DeltaTimePosition
    from 
    (
      select t.*, ra.AthleteId, a.Name AthleteName, 
      
         rlt1.Time Time1,
         rlt2.Time Time2,
         rlt3.Time Time3,
      
         round((rlt3.Time - rlt1.Time) + (rlt2.Time - rlt1.Time), 3) TimeDelta
      from 
      (
      	SELECT DISTINCT [RaceNumber], [CarNumber]
      	FROM [dbo].[RaceLapTime]
      ) t
      left join [dbo].[RaceAthlete] ra on ra.CarNumber = t.CarNumber and ra.RaceNumber = t.RaceNumber
      left join [dbo].[Athlete] a on a.Id = ra.AthleteId
      
      left join [dbo].[RaceLapTime] rlt1 on rlt1.RaceNumber = t.RaceNumber and rlt1.CarNumber = t.CarNumber and rlt1.BestLap = 1
      left join [dbo].[RaceLapTime] rlt2 on rlt2.RaceNumber = t.RaceNumber and rlt2.CarNumber = t.CarNumber and rlt2.BestLap = 2
      left join [dbo].[RaceLapTime] rlt3 on rlt3.RaceNumber = t.RaceNumber and rlt3.CarNumber = t.CarNumber and rlt3.BestLap = 3
    ) t
  ) t


--  3.1 Position by Total Time
select 
   ROW_NUMBER ( ) OVER(ORDER BY TotalPoints desc, MinTime1 asc, MinTime2 asc, MinTime3 asc) Position,
   [AthleteName], TotalPoints, MinTime1, MinTime2, MinTime3
from
(
  select [AthleteName], sum(TotalPoints) TotalPoints
  , min(Time1) MinTime1
  , min(Time2) MinTime2
  , min(Time3) MinTime3
  from [dbo].[RaceResults] 
  group by [AthleteName]
) t
order by 1

--  3.2 Position by Best Time
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
order by 1

--  3.3 Position by Best Delta
select 
   ROW_NUMBER ( ) OVER(ORDER BY DeltaTimePoints desc, MinTime1 asc, MinTime2 asc, MinTime3 asc) Position,
   [AthleteName], BestTimePoints, MinTime1, MinTime2, MinTime3
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