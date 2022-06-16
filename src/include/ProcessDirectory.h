#pragma once
#ifndef PROCESSDIRECTORY_H
#define PROCESSDIRECTORY_H

#include <vector>
#include <filesystem>

class ProcessDirectory
{
  private:
    std::vector<std::filesystem::path> processDirectories;
    std::vector<std::filesystem::path> otherDirectories;
    std::string procDir;
    std::filesystem::path procPath;
  public:
    ProcessDirectory();
    void setProcessDirectories();
    void setOtherDirectories();
    std::vector<std::filesystem::path> getProcessDirectories(bool set_);
    std::vector<std::filesystem::path> getOtherDirectories(bool set_);
    std::string getProcDir();
    std::filesystem::path getProcPath();
};

#endif
