// -----------------------------------------------
// 'lsproc'
// Copyright © 2022
// Ian Pride @ New Pride Software/Services
// Sat 11 Jun 2022 21:28:21 CST
// -----------------------------------------------
#include "Bench.h"
#include "ProcessDirectory.h"
#include "functions.h"

#include <chrono>

int main()
{
	Bench::start();
	ProcessDirectory ProcDirs;
	Bench::stop();
	Bench::print_duration("'ProcessDirectory ProcDirs;' execution Time: ", "\n", Bench::Start, Bench::Stop);

	const auto PROCDIR = ProcDirs.getProcDir();
	const auto PROCPATH	= ProcDirs.getProcPath();
	const auto & ethrow = GLOBALS::ethrow;
	std::error_code ecode;
	if (!std::filesystem::exists(PROCPATH, ecode))
	{
		ethrow(ecode, true, 0);
		std::cerr << PROCPATH << " does not exist for an unknown reason.\n";
		return 1;
	}

	// for (const auto & dir : ProcDirs.getProcessDirectories(false))
	// {
	// 	std::cout << "Is " << dir << " an absolute path: [" << dir.is_absolute() << ']' << std::endl;
	// }

	for (const auto & dir : ProcDirs.getOtherDirectories(false))
	{
		std::cout  << dir << " is" << ((std::filesystem::is_symlink(dir))?" ":" not ")<< "a sym link." << std::endl;
	}
}
