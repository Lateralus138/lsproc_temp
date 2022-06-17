#include "functions.h"

namespace GLOBALS
{
  extern const std::string PROCDIR = "/proc";
  extern const std::vector<std::string> PATHTYPES { "directory",
			"regular file", "sym link", "pipe/fifo", "other", "unknown" };
  extern const std::filesystem::path PROCPATH(PROCDIR);
  extern void ethrow(std::error_code ec_, bool print_,int exit_)
  {
    const int eint_ = (int)ec_.value();
    if (eint_ != 0)
    {
      if (print_) std::cerr << ec_.message() << '\n';
      exit((exit_ != 0) ? exit_ : eint_);
    }
  }
};

namespace REGEX
{
  extern const std::regex
    UINT("^[0-9]+$"),
    INT("^[-+]?[0-9]+$");
};
