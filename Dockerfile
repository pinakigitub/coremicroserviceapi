FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app


FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["API_GateWay/API_GateWay.csproj", "API_GateWay/"]
RUN dotnet restore "API_GateWay/API_GateWay.csproj"
COPY . .
WORKDIR "/src/API_GateWay"
RUN dotnet build "API_GateWay.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "API_GateWay.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .

CMD dotnet API_GateWay.dll


