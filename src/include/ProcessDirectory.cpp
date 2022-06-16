#include "ProcessDirectory.h"
#include "functions.h"
#include <regex>

ProcessDirectory::ProcessDirectory()
{
  procDir = GLOBALS::PROCDIR;
  procPath = GLOBALS::PROCPATH;
  setProcessDirectories();
}

void ProcessDirectory::setProcessDirectories()
{
		for (auto const &di : std::filesystem::directory_iterator(procPath))
		{
      if (di.is_directory() && std::regex_match(di.path().filename().native().c_str(), REGEX::UINT))
      {
        processDirectories.push_back(di.path());
      }
    }
}

std::vector<std::filesystem::path> ProcessDirectory::getProcessDirectories(bool set_)
{
  if (set_) setProcessDirectories();
  return processDirectories;
}

std::string ProcessDirectory::getProcDir()
{
  return procDir;
}
std::filesystem::path ProcessDirectory::getProcPath()
{
  return procPath;
}