// Copyright (c) ZeroC, Inc.

#ifndef AUTHENTICATOR_I_H
#define AUTHENTICATOR_I_H

#include <Interceptor.h>
#include <chrono>
#include <map>
#include <mutex>
#include <random>

class AuthenticatorI : public Demo::Authenticator
{
public:
    AuthenticatorI();
    std::string getToken(const Ice::Current&) override;
    void validateToken(const std::string&);

private:
    std::mt19937_64 _rand;
    std::map<std::string, std::chrono::time_point<std::chrono::steady_clock>> _tokenStore;
    std::mutex _tokenLock;
};

#endif
