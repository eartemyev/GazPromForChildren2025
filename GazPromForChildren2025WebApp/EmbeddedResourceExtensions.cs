namespace GazPromForChildren2025WebApp;

using System.Reflection;
using System.Text.RegularExpressions;

public static class EmbeddedResourceExtensions
{
    public static EmbeddedResourceContext EmbeddedResource(this Type type, string path)
    {
        return new EmbeddedResourceContext
        {
            Assembly = type.GetTypeInfo().Assembly,
            Path = EmbeddedResourcePath(type, path)
        };
    }

    public static string ReadAsString(this EmbeddedResourceContext context)
    {
        using var reader = new StreamReader(context.ReadAsStream());
        return reader.ReadToEnd();
    }
    public static async Task<string> ReadAsStringAsync(this EmbeddedResourceContext context)
    {
        using var reader = new StreamReader(context.ReadAsStream());
        return await reader.ReadToEndAsync().ConfigureAwait(false);
    }

    public static byte[] ReadAsBytes(this EmbeddedResourceContext context)
    {
        using var stream = context.ReadAsStream();
        var count = (int)stream.Length;
        var data = new byte[count];
        var _ = stream.Read(data, 0, count);
        return data;
    }
    public static async Task<byte[]> ReadAsBytesAsync(this EmbeddedResourceContext context)
    {
        using var stream = context.ReadAsStream();
        var count = (int)stream.Length;
        var data = new byte[count];
        var _ = await stream.ReadAsync(data, 0, count).ConfigureAwait(false);
        return data;
    }

    public static Stream ReadAsStream(this EmbeddedResourceContext context)
    {
        return context.Assembly.GetManifestResourceStream(context.Path)
               ?? throw new Exception("Embedded resource '" + context.Path + "' was not found.");
    }
    private static string EmbeddedResourcePath(Type type, string path)
    {
        if (path.StartsWith("./") || path.StartsWith(".\\"))
            path = type.Namespace + "." + path.Substring(2);
        path = path.Replace("\\", ".").Replace("/", ".").Replace("-", "_");

        var regex = new Regex(@"(?<dot>\.)(?<number>\d)");

        return regex.Replace(path, m => $"{m.Groups[1].Value}_{m.Groups[2].Value}");
    }
}

public class EmbeddedResourceContext
{
    public required Assembly Assembly { get; set; }
    public required string Path { get; set; }
}