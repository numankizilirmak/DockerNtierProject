FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as build
WORKDIR /app

COPY ./DockerNtierProject/*.csproj ./DockerNtierProject/
COPY ./Data/*.csproj ./Data/
COPY ./Business/*.csproj ./Business/
COPY *.sln .
RUN dotnet restore
COPY . .
RUN dotnet publish ./DockerNtierProject/*.csproj -o /publish/
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /publish .
ENV ASPNETCORE_URLS="http://*:3000"
ENV ASPNETCORE_ENVIRONMENT="Development"
ENTRYPOINT ["dotnet","DockerNtierProject.dll"]
