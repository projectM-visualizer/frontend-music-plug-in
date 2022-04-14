#pragma once

//FIXME: define this here?  in .cpp? or somewhere else?
#define CONFIG_FILE "/share/projectM/config.inp"

#include <string>

// get the full pathname of a configfile
std::string getConfigFilename();
