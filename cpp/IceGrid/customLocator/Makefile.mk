# Copyright (c) ZeroC, Inc.

$(demo)_programs = server client locator

$(demo)_client_dependencies     = IceGrid Glacier2 Ice

$(demo)_locator_sources         = Locator.cpp

demos += $(demo)
