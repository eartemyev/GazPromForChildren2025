using System.Data.Common;

namespace GazPromForChildren2025WebApp;

public static class DbConnectionFactory
{
    private const string ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Data\\GazPromForChildren2025.mdf;Integrated Security=True;Connect Timeout=30";

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