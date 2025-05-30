// Copyright (c) ZeroC, Inc.

import Foundation
import Ice

// Automatically flush stdout
setbuf(__stdoutp, nil)

struct PingI: Ping {}

func run() -> Int32 {
    do {
        var args = CommandLine.arguments
        let communicator = try Ice.initialize(args: &args, configFile: "config.server")
        defer {
            communicator.destroy()
        }

        guard args.count == 1 else {
            print("too many arguments")
            return 1
        }

        let adapter = try communicator.createObjectAdapter("Latency")
        try adapter.add(servant: PingDisp(PingI()), id: Ice.Identity(name: "ping"))
        try adapter.activate()
        communicator.waitForShutdown()
        return 0
    } catch {
        print("Error: \(error)\n")
        return 1
    }
}

exit(run())
