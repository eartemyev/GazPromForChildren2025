namespace GazPromForChildren2025WebApp.Components.Races;

public partial class Component : ComponentBase
{
    public IEnumerable<Item>? Data;
    //public IEnumerable<Race>? Races;
    public IEnumerable<RaceAthlete>? RaceAthletes;

    protected override async Task OnInitializedAsync()
    {
        await using var connection = await DbConnectionFactory.OpenConnectionAsync();

        var sql = await GetType().EmbeddedResource("./Query.sql").ReadAsStringAsync();
        Data = connection.Query<Item>(sql);

        //sql = await GetType().EmbeddedResource("./Races.sql").ReadAsStringAsync();
        //Races = connection.Query<Race>(sql);

        sql = await GetType().EmbeddedResource("./RaceAthletes.sql").ReadAsStringAsync();
        RaceAthletes = connection.Query<RaceAthlete>(sql);
    }
}