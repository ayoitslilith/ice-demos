// Copyright (c) ZeroC, Inc.

#pragma once

module Demo
{
    interface CounterObserver
    {
        void init(int value);
        void inc(int value);
    }

    interface Counter
    {
        void subscribe(CounterObserver* observer);
        void unsubscribe(CounterObserver* observer);
        void inc(int value);
    }
}
