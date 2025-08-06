using System.Data.Common;

namespace GazPromForChildren2025WebApp;

public static class DbConnectionFactory
{
    private const string ConnectionString = "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=GazPromForChildren2025;Integrated Security=True;Connect Timeout=60;Encrypt=False;Trust Server Certificate=False;Application Intent=ReadWrite;Multi Subnet Failover=False";

    public static async Task<DbConnection> OpenConnectionAsync()
    {
        var connection = GetNewConnection();
        await connection.OpenAsync();
        return connection;
    }
    public static DbConnection GetNewConnection()
    {
        return new SqlConnection(ConnectionString);
    }
}