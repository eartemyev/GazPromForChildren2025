namespace GazPromForChildren2025WebApp.Pages.Summary.PositionByBestDelta;

public class Item
{
    public int Position { get; set; }
    public required string AthleteName { get; set; }
    public int DeltaTimePoints { get; set; }
    public decimal MinTime1 { get; set; }
    public decimal MinTime2 { get; set; }
    public decimal MinTime3 { get; set; }
}