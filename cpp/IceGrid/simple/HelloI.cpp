// Copyright (c) ZeroC, Inc.

#include "HelloI.h"
#include <Ice/Ice.h>
#include <iostream>

using namespace std;

HelloI::HelloI(string_view name) : _name(name) {}

void
HelloI::sayHello(const Ice::Current&)
{
    cout << _name << " says Hello World!" << endl;
}

void
HelloI::shutdown(const Ice::Current& current)
{
    cout << _name << " shutting down..." << endl;
    current.adapter->getCommunicator()->shutdown();
}
