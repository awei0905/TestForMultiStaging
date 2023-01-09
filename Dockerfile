FROM mcr.microsoft.com/dotnet/aspnet:6.0.12-alpine3.17-amd64 AS base
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:5000
# ENV ASPNETCORE_ENVIRONMENT=STAGING_1

FROM mcr.microsoft.com/dotnet/sdk:6.0.404-alpine3.17-amd64 AS build
WORKDIR /src
COPY . .
RUN dotnet restore
RUN dotnet publish -c release -o /app/build

FROM base AS final
WORKDIR /app
COPY --from=build /app/build .
ENTRYPOINT ["dotnet", "TestForMultiStaging.dll"]
