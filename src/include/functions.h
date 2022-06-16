#pragma once
#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include <iostream>
#include <regex>
#include <vector>
#include <filesystem>

namespace GLOBALS
{
  extern const std::string PROCDIR;
  extern const std::vector<std::string> PATHTYPES;
  extern const std::filesystem::path PROCPATH;
  extern void ethrow(std::error_code ec_, bool print_, int exit_);
};

namespace REGEX
{
  extern const std::regex UINT, INT;
};

#endif
