dotnet tool restore

dotnet build -c Release

dotnet sqlpackage `
    /Action:Publish `
    /SourceFile:"Repro.Data/bin/Release/Repro.Data.dacpac" `
    /TargetConnectionString:"Data Source=.\SQLEXPRESS;Initial Catalog=reprodb;Integrated Security=True;TrustServerCertificate=True"