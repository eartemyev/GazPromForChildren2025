namespace GazPromForChildren2025WebApp.Components.Races;

public class Item
{
    public int RaceNumber { get; set; }
    public int LapNumber { get; set; }
    public int CarNumber { get; set; }
    public decimal Time { get; set; }
    public int? BestLap { get; set; }
}
public class Race
{
    public int RaceNumber { get; set; }
}
public class RaceAthlete
{
    public int RaceNumber { get; set; }
    public int CarNumber { get; set; }
    
    public decimal Time1 { get; set; }
    public decimal TimeDelta { get; set; }
    public int TotalPoints { get; set; }
    public int BestTimePoints { get; set; }
    public int DeltaTimePoints { get; set; }
    public int DeltaTimePosition { get; set; }
    public int BestTimePosition { get; set; }

    public int AthleteId { get; set; }
    public required string AthleteName { get; set; }
}