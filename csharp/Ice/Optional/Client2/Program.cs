// Copyright (c) ZeroC, Inc.

// Slice module ClearSky in WeatherStation2.ice maps to C# namespace ClearSky.
using ClearSky;
using System.Security.Cryptography; // for RandomNumberGenerator

// Create an Ice communicator to initialize the Ice runtime. The communicator is disposed before the program exits.
using Ice.Communicator communicator = Ice.Util.initialize(ref args);

// Create a proxy to the Weather station.
WeatherStationPrx weatherStation = WeatherStationPrxHelper.createProxy(communicator, "weatherStation:tcp -p 4061");

// Create an AtmosphericConditions object with random values.
var reading = new AtmosphericConditions
{
    Temperature = RandomNumberGenerator.GetInt32(190, 230) / 10.0,
    Humidity = RandomNumberGenerator.GetInt32(450, 550) / 10.0,
    Pressure = RandomNumberGenerator.GetInt32(10_000, 10_500) / 10.0,
};

// Report this reading to the weather station.
await weatherStation.ReportAsync("sensor v2", reading);

Console.WriteLine("sensor v2: sent reading to weather station");
