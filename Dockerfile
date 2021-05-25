# ���������� ������� sdk �� ������� ����������� ����������
FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 5000

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
# �������� ���� ������� � ��������������
COPY ["ASP_TEMPLATE.csproj", "."]
# ���������� ��� ����������� ������� 
RUN dotnet restore "./ASP_TEMPLATE.csproj"
COPY . .
# ������� ���������� 
WORKDIR "/src/."
# ������ ������ ����� sdk dotnet ����� ���� ��� ������������ ��� ����������� �������
RUN dotnet build "ASP_TEMPLATE.csproj" -c Release -o /app/build

FROM build AS publish
#��������� ����� ����������
RUN dotnet publish "ASP_TEMPLATE.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
# ����� ����� �������� dll ������� 
ENTRYPOINT ["dotnet", "ASP_TEMPLATE.dll"]