# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY . ./

# Specify the solution or project file explicitly
RUN dotnet restore docker-dotnet-api.csproj

RUN dotnet publish docker-dotnet-api.csproj -c Release -o out

# Serve Stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /src/out .

ENTRYPOINT [ "dotnet", "docker-dotnet-api.dll" ]