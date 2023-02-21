using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

var connectionstring = @"Data Source=.\SQLEXPRESS;Initial Catalog=reprodb;Integrated Security=True;TrustServerCertificate=True";

var optionsBuilder = new DbContextOptionsBuilder<ReproContext>()
    .UseSqlServer(connectionstring);

using var ctx = new ReproContext(optionsBuilder.Options);

var names = await ctx.GetPaths(null)
    .SelectMany(p => p.Items, (p, i) => p.FullName + " / " +  i.Name )
    .ToListAsync();

foreach (var item in names)
{
    Console.WriteLine(item);
}

// This will cause runtime error
// because the FullName column is not present in the table
var paths = await ctx.Paths.ToListAsync();

public class Path
{
    public int Id { get; set; }
    public string? Name { get; set; }
    public Path? Parent { get; set; }
    public ICollection<Path> Children { get; set; } = new List<Path>();
    public ICollection<Item> Items { get; set; } = new List<Item>();

    // How to make this optional?
    // Adding [NotMapped] will cause it to be removed when using GetPaths() function
    public string? FullName { get; set;}
}

public class Item
{
    public int Id { get; set; }
    public string? Name { get; set; }
    public Path? Path { get; set; }
}

public class ReproContext : DbContext
{
    public ReproContext(DbContextOptions<ReproContext> options) : base(options)
    {
    }

    public DbSet<Path> Paths { get; set; }
    public DbSet<Path> Items { get; set; }
    public IQueryable<Path> GetPaths(int? id) => FromExpression(() => GetPaths(id));

    override protected void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Path>()
            .ToTable("Path", "Repro")
            .HasMany(p => p.Children)
            .WithOne(p => p.Parent)
            .HasForeignKey("ParentId");

        modelBuilder.Entity<Item>()
            .ToTable("Item", "Repro")
            .HasOne(i => i.Path)
            .WithMany(p => p.Items)
            .HasForeignKey("PathId");

        modelBuilder
            .HasDbFunction(typeof(ReproContext).GetMethod(nameof(GetPaths), new[] { typeof(int?) })!)
            .HasName("GetPaths")
            .HasSchema("Repro");
    }
}