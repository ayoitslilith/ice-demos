//
// Copyright (c) ZeroC, Inc. All rights reserved.
//

import Demo.*;

public class Printer extends _HelloDisp
{
    @Override
    public void sayHello(Ice.Current current)
    {
        System.out.println("Hello World!");
    }
}
