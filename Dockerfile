#FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
#WORKDIR /app
#
#COPY ["weatherforecast/weatherforecast.csproj", "weatherforecast/"]
#COPY ["weatherforecast.Infar.Common/weatherforecast.Infar.Common.csproj", "weatherforecast.Infar.Common/"]
#RUN dotnet restore "weatherforecast/weatherforecast.csproj"
#
#COPY . ./
#
#RUN dotnet publish -c Release -o out
#
#FROM mcr.microsoft.com/dotnet/sdk:3.1
#WORKDIR /app
#EXPOSE 80
#EXPOSE 443
#COPY --from=build /app/out .
#ENTRYPOINT ["dotnet", "weatherforecast.dll"]

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS base
WORKDIR /app
#EXPOSE 5000
#ENV ASPNETCORE_URLS=http://+:5000

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY . .
RUN dotnet restore "weatherforecast/weatherforecast.csproj"
WORKDIR "/src/weatherforecast"
RUN dotnet build "weatherforecast.csproj" -c Release -o /app

FROM build AS publish
WORKDIR "/src/weatherforecast"
RUN dotnet publish "weatherforecast.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "weatherforecast.dll"]
#ENTRYPOINT ["dotnet", "BuySellApi.dll", "--server.urls", "http://0.0.0.0:5000"]

