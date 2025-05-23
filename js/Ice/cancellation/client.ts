// Copyright (c) ZeroC, Inc.

import { Ice } from "@zeroc/ice";
import { VisitorCenter } from "./Greeter.js";
import process from "node:process";

// Create an Ice communicator. We'll use this communicator to create proxies and manage outgoing connections.
await using communicator = Ice.initialize(process.argv);

// GreeterPrx is a class generated by the Slice compiler. We create a proxy from a communicator and a "stringified
// proxy" with the address of the target object.
// If you run the server on a different computer, replace localhost in the string below with the server's hostname
// or IP address.
const greeter = new VisitorCenter.GreeterPrx(communicator, "greeter:tcp -h localhost -p 4061");

// Create a proxy to the slow greeter. It uses the same connection as the regular greeter.
const slowGreeter = new VisitorCenter.GreeterPrx(communicator, "slowGreeter:tcp -h localhost -p 4061");

// Create another slow greeter proxy with an invocation timeout of 4 seconds (the default invocation timeout is
// infinite).
const slowGreeter4s = slowGreeter.ice_invocationTimeout(4000);

// Retrieve my name
const name = process.env.USER || process.env.USERNAME || "masked user";

// Send a request to the regular greeter and get the response.
let greeting = await greeter.greet(name);
console.log(greeting);

// Send a request to the slow greeter with the 4-second invocation timeout.
try {
    greeting = await slowGreeter4s.greet("alice");
    console.log(`Received unexpected greeting: ${greeting}`);
} catch (exception) {
    console.assert(exception instanceof Ice.InvocationTimeoutException, exception);
    console.log(`Caught InvocationTimeoutException, as expected: ${exception.message}`);
}

// Send a request to the slow greeter, and cancel this request after 4 seconds.
try {
    const greetingResult = slowGreeter.greet("bob");
    setTimeout(() => greetingResult.cancel(), 4000);
    greeting = await greetingResult;
    console.log(`Received unexpected greeting: ${greeting}`);
} catch (exception) {
    console.assert(exception instanceof Ice.InvocationCanceledException, exception);
    console.log(`Caught InvocationCanceledException, as expected: ${exception.message}`);
}

// Verify the regular greeter still works.
greeting = await greeter.greet("carol");
console.log(greeting);
