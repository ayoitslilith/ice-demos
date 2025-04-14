#!/usr/bin/env ruby
# Copyright (c) ZeroC, Inc.

require 'etc'
require 'Ice'

# Load the code generated by the Slice compiler. The Slice module VisitorCenter maps to a Ruby module with the same
# name.
require_relative 'Greeter.rb'

# Create an Ice communicator. We'll use this communicator to create proxies and manage outgoing connections.
# This communicator gets its configuration properties from file "config.client" in the client's current working directory.
# The communicator initialization also parses the command-line options to find and set additional properties.
Ice::initialize(ARGV, "config.client") do |communicator|
    # GreeterPrx is a class generated by the Slice compiler. We create a proxy from a communicator, a property found
    # with the "Greeter.Proxy" specification with the address of the target object, and the "config.client" file that
    # we referenced during initialization.
    greeter = VisitorCenter::GreeterPrx.uncheckedCast(communicator.propertyToProxy("Greeter.Proxy"))
    
    # Send a request to the remote object and get the response.
    greeting = greeter.greet(Etc.getlogin)

    puts greeting
end
