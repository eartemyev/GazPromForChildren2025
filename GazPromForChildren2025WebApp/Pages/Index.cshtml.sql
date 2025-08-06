-- Заезды
SELECT ra.[RaceNumber], ra.[CarNumber], ra.[AthleteId], a.[Name] [AthleteName]
FROM [dbo].[RaceAthlete] ra
INNER JOIN [dbo].[Athlete] a on a.Id = ra.AthleteId