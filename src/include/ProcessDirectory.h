#pragma once
#ifndef PROCESSDIRECTORY_H
#define PROCESSDIRECTORY_H

#include <vector>
#include <filesystem>

class ProcessDirectory
{
  private:
    std::vector<std::filesystem::path> processDirectories;
    std::string procDir;
    std::filesystem::path procPath;

  public:
    ProcessDirectory();
    void setProcessDirectories();
    std::vector<std::filesystem::path> getProcessDirectories(bool set_);
    std::string getProcDir();
    std::filesystem::path getProcPath();
};

#endif
