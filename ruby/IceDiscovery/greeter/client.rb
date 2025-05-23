#!/usr/bin/env ruby
# Copyright (c) ZeroC, Inc.

require 'etc'
require 'Ice'

# Load the code generated by the Slice compiler. The Slice module VisitorCenter maps to a Ruby module with the same
# name.
require_relative 'Greeter.rb'

# Configure the communicator to load the IceDiscovery plugin during initialization. This plugin installs a default
# locator on the communicator.
initData = Ice::InitializationData.new()
initData.properties = Ice.createProperties(ARGV)
initData.properties.setProperty("Ice.Plugin.IceDiscovery", "1")

# Create an Ice communicator. We'll use this communicator to create proxies and manage outgoing connections.
Ice::initialize(initData) do |communicator|
    # Create a proxy to the Greeter object hosted by the server(s). 'greeter' is a stringified proxy with no addressing
    # information, also known as a well-known proxy. It's resolved by the default locator installed by the IceDiscovery
    # plugin.
    greeter = VisitorCenter::GreeterPrx.new(communicator, "greeter")

    # Send a request to the remote object and get the response.
    greeting = greeter.greet(Etc.getlogin)

    puts greeting
end
