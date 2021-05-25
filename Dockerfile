# Выкачиваем текущий sdk на котором запускается приложение
FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 5000

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
# Копируем файл проекта с конфигурациями
COPY ["ASP_TEMPLATE.csproj", "."]
# Вытягиваем все зависимости проекта 
RUN dotnet restore "./ASP_TEMPLATE.csproj"
COPY . .
# Рабочая директория 
WORKDIR "/src/."
# Билдим проект через sdk dotnet после того как восстановили все зависимости проекта
RUN dotnet build "ASP_TEMPLATE.csproj" -c Release -o /app/build

FROM build AS publish
#Публикуем релиз приложение
RUN dotnet publish "ASP_TEMPLATE.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
# Точка входа основной dll проекта 
ENTRYPOINT ["dotnet", "ASP_TEMPLATE.dll"]