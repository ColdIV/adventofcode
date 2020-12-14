#include <iostream>
#include <vector>
#include <fstream>

std::string getValue (std::string key, std::string str) {
	std::string value;
	
	std::size_t found;
	found = str.find(key);
	if (found != std::string::npos) {
		std::string tmp = str.substr(found);
		if (found != std::string::npos) {
			found = tmp.find(" ");
			value = tmp.substr(0, found);
		}
	}
	
	return value;
}

int solve () {
	std::ifstream infile("data.txt");
	std::string tmp;
	
	int count = 0;
	int tmpc = 0;
	std::size_t found;
	
	while (std::getline(infile, tmp)) {
		if (tmp.empty()) {
			if (tmpc == 7) ++count;
			tmpc = 0;
		}
		
		found = tmp.find("ecl:");
		if (found != std::string::npos) ++tmpc;
		
		found = tmp.find("pid:");
		if (found != std::string::npos) ++tmpc;
		
		found = tmp.find("eyr:");
		if (found != std::string::npos) ++tmpc;
		
		found = tmp.find("hcl:");
		if (found != std::string::npos) ++tmpc;
		
		found = tmp.find("iyr:");
		if (found != std::string::npos) ++tmpc;
		
		found = tmp.find("hgt:");
		if (found != std::string::npos) ++tmpc;
		
		found = tmp.find("byr:");
		if (found != std::string::npos) ++tmpc;
	}
	
	return count;
}

int main () {
	std:: cout << solve() << "\n";

	return 0;
}