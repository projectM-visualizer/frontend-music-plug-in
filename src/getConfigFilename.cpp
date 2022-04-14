#include "getConfigFilename.h"

#include <sys/stat.h>

#include <fstream>
#include <vector>

#define PROJECTM_PREFIX ""

// get the full pathname of a configfile
std::string getConfigFilename()
{
    std::string configHome(getenv("HOME"));
    configHome.append("/.projectM");

    std::string projectMConfigFile = configHome;
    projectMConfigFile.append("/config.inp");

    std::string projectMSystemConfig(PROJECTM_PREFIX CONFIG_FILE);

    {
        std::ifstream configStream(projectMConfigFile.c_str(), std::ios::in);
        if (configStream.good())
        {
            return projectMConfigFile;
        }
    }

    mkdir(configHome.c_str(), 0755);


    std::ofstream configStream(projectMConfigFile.c_str(), std::ios::out);
    if(configStream.good())
	{
        std::ifstream systemConfigStream(projectMSystemConfig.c_str(), std::ios::in);
        if (systemConfigStream.good())
        {
            systemConfigStream.seekg (0, systemConfigStream.end);
            size_t length = systemConfigStream.tellg();
            systemConfigStream.seekg (0, systemConfigStream.beg);

            std::vector<char> buffer(length);
            systemConfigStream.read(buffer.data(), buffer.size());
            configStream.write(buffer.data(), buffer.size());

            return projectMConfigFile;
        }
	}

    // Use built-in defaults then.
    return "";
}

