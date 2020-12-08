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
	
	while (std::getline(infile, tmp)) {
		if (tmp.empty()) {
			if (tmpc == 7) ++count;
			tmpc = 0;
		}
		
		std::string x;
		x = getValue("byr:", tmp);
		if (!x.empty()) {
			int check = std::stoi(x);
			if (check >= 1920 && check <= 2002) ++tmpc;
		}
		
		x = getValue("iyr:", tmp);
		if (!x.empty()) {
			int check = std::stoi(x);
			if (check >= 2010 && check <= 2020) ++tmpc;
		}
		
		x = getValue("eyr:", tmp);
		if (!x.empty()) {
			int check = std::stoi(x);
			if (check >= 2020 && check <= 2030) ++tmpc;
		}
		
		x = getValue("hgt:", tmp);
		if (!x.empty()) {
			// @TODO:
			// switched to lua here, won't finish in cpp...
			int val;
			std::string s;
			scanf("%d%s", val, s);
			
		}
		
		x = getValue("hcl:", tmp);
		if (!x.empty()) {
			if (x[0] == '#') {
				int tmpfi = 0;
				for (int i = 1; i < 7; ++i) {
					// look away! i'm tired!
					if (x[i] == '0' ||
						x[i] == '1' ||
						x[i] == '2' ||
						x[i] == '3' ||
						x[i] == '4' ||
						x[i] == '5' ||
						x[i] == '6' ||
						x[i] == '7' ||
						x[i] == '8' ||
						x[i] == '9' ||
						x[i] == 'a' ||
						x[i] == 'b' ||
						x[i] == 'c' ||
						x[i] == 'd' ||
						x[i] == 'e' ||
						x[i] == 'f') {
						++tmpfi;
					}
				}
				if (tmpfi == 6) ++tmpc;
			}
		}
		
		x = getValue("ecl:", tmp);
		if (!x.empty()) {
			if (x == "amb" ||
				x == "blu" ||
				x == "brn" ||
				x == "gry" ||
				x == "grn" ||
				x == "hzl" ||
				x == "oth") {
				++tmpc;
			}
		}
		
		x = getValue("pid:", tmp);
		if (!x.empty() && x.length() == 9) {
			int tmpfi = 0;
			for (int i = 0; i < 9; ++i) {
				if (x[i] == '0' ||
					x[i] == '1' ||
					x[i] == '2' ||
					x[i] == '3' ||
					x[i] == '4' ||
					x[i] == '5' ||
					x[i] == '6' ||
					x[i] == '7' ||
					x[i] == '8' ||
					x[i] == '9') {
					++tmpfi;
				}
			}
			
			if (tmpfi == 9) ++tmpc;
		}
	}
	
	return count;
}

int main () {
	std:: cout << solve() << "\n";

	return 0;
}