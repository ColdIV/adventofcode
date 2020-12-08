#include <iostream>
#include <vector>
#include <fstream>

int solve () {
	std::ifstream infile("data.txt");
	std::string tmp;
	
	int correct = 0;
	int min, max;
	min = max = 0;
	char c;
	while (std::getline(infile, tmp)) {
		min = std::stoi(tmp);
		tmp = tmp.substr(tmp.find("-") + 1);
		max = std::stoi(tmp);
		tmp = tmp.substr(tmp.find(" ") + 1);
		c = tmp[0];
		tmp = tmp.substr(tmp.find(":") + 2);
		
		int tmpi = 0;
		for (int i = 0; i < tmp.length(); ++i) {
			if (c == tmp[i]) ++tmpi;
		}
		
		if (tmpi >= min && tmpi <= max) ++correct;
	}
	
	return correct;
}

int main () {
	std:: cout << solve() << "\n";

	return 0;
}