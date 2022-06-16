// -----------------------------------------------
// 'lsproc'
// Copyright © 2022
// Ian Pride @ New Pride Software/Services
// Sat 11 Jun 2022 21:28:21 CST
// -----------------------------------------------
#include "ProcessDirectory.h"
#include "functions.h"

int main()
{
	ProcessDirectory ProcDirs;
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
}
