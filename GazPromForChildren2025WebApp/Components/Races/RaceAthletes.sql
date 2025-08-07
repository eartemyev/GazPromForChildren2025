SELECT 
    rr.RaceNumber
  , rr.CarNumber
  , rr.AthleteId
  , rr.AthleteName

  , rr.Time1
  , rr.TimeDelta
  , rr.DeltaTimePoints
  , rr.BestTimeTimePoints
  , rr.DeltaTimePosition
  , rr.BestTimePosition
  , rr.TotalPoints
FROM [dbo].[RaceResults] rr
