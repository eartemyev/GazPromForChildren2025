namespace GazPromForChildren2025WebApp.Pages.Summary.PositionByBestDelta;

public partial class Component : ComponentBase
{
    public IEnumerable<Item>? Data;

    protected override async Task OnInitializedAsync()
    {
        await using var connection = await DbConnectionFactory.OpenConnectionAsync();
        var sql = await GetType().EmbeddedResource("./Query.sql").ReadAsStringAsync();
        Data = connection.Query<Item>(sql);
    }
}