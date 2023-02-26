FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app

EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["TerraCope.csproj", "."]
RUN dotnet restore "./TerraCop.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "TerraCop.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "TerraCop.csproj" -c Release -o /app/publish
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TerraCop.dll"]