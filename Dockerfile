# See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

# Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
# For more information, please see https://aka.ms/containercompat

# This stage is used when running from VS in fast mode (Default for Debug configuration)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 8081


# This stage is used to build the service project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src

# Copy the project file and restore dependencies
COPY ["SimpleAPIWith_CICD/SimpleAPIWith_CICD.csproj", "SimpleAPIWith_CICD/"]
RUN dotnet restore "SimpleAPIWith_CICD/SimpleAPIWith_CICD.csproj"

# Copy the rest of the application source code
COPY . . 
WORKDIR "/src/SimpleAPIWith_CICD"
RUN dotnet build "SimpleAPIWith_CICD.csproj" -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish "SimpleAPIWith_CICD.csproj" -c Release -o /app/publish

# Final stage: Use the ASP.NET Core runtime to run the app
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .  
ENTRYPOINT ["dotnet", "SimpleAPIWith_CICD.dll"]