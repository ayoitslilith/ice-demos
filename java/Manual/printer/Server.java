// **********************************************************************
//
// Copyright (c) 2003-2018 ZeroC, Inc. All rights reserved.
//
// **********************************************************************

public class Server
{
    public static void main(String[] args) throws Exception
    {
        //
        // Try with resources block - communicator is automatically destroyed
        // at the end of this try block
        //
        try(com.zeroc.Ice.Communicator ic = com.zeroc.Ice.Util.initialize(args))
        {
            com.zeroc.Ice.ObjectAdapter adapter =
                ic.createObjectAdapterWithEndpoints("SimplePrinterAdapter", "default -h localhost -p 10000");
            com.zeroc.Ice.Object object = new PrinterI();
            adapter.add(object, com.zeroc.Ice.Util.stringToIdentity("SimplePrinter"));
            adapter.activate();

            ic.waitForShutdown();
        }
    }
}
