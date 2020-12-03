#include <iostream>
#include <vector>
#include <fstream>

int solve () {
	std::ifstream infile("data.txt");
	std::string tmp;
	
	int correct = 0;
	int first, second;
	first = second = 0;
	char c;
	while (std::getline(infile, tmp)) {
		first = std::stoi(tmp);
		tmp = tmp.substr(tmp.find("-") + 1);
		second = std::stoi(tmp);
		tmp = tmp.substr(tmp.find(" ") + 1);
		c = tmp[0];
		tmp = tmp.substr(tmp.find(":") + 2);
		
		int tmpCheck = 0;
		if (tmp[first - 1] == c) ++tmpCheck;
		if (tmp[second - 1] == c) ++tmpCheck;
		
		if (tmpCheck == 1) ++correct;
	}
	
	return correct;
}

int main () {
	std:: cout << solve() << "\n";

	return 0;
}