namespace GazPromForChildren2025WebApp.Pages;

public class IndexModel() : PageModel
{
    public Data? Data;

    public async Task OnGet()
    {
        await using var connection = await DbConnectionFactory.OpenConnectionAsync();
        var sql = await typeof(IndexModel).EmbeddedResource("./Index.cshtml.sql").ReadAsStringAsync();

        Data = new Data();

        // multi-row query
        Data.RaceAthletes = connection.Query<RaceAthlete>(sql);

        //var data = connection.Query<RaceAthlete>(sql, (raceAthlete) =>
        //{
        //    return new Data
        //    {
        //        RaceAthletes = raceAthlete
        //    };
        //});
    }
}

public class Data
{
    public IEnumerable<RaceAthlete>? RaceAthletes { get; set; } 
}

public class RaceAthlete
{
    public int RaceNumber { get; set; }
    public int CarNumber { get; set; }
    public int AthleteId { get; set; }
    public required string AthleteName { get; set; }
}