#include <iostream>
#include <vector>
#include <fstream>

int solve () {
	std::ifstream infile("data.txt");
	std::string tmp;
	
	int width = -1, height = 0;
	std::vector <std::string> matrix;
	
	while (std::getline(infile, tmp)) {
		if (width < 0) width = tmp.length();
		++height;
		matrix.push_back(tmp);
	}
	
	int count = 0;
	for (int i = 0; i < height; ++i) {
		int x = 3 * i; // 3 to right
		int y = 1 * i; // 1 down
		if (3 * i > width) x = x % width;
		if (matrix[y][x] == '#') ++count;
	}
	
	return count;
}

int main () {
	std:: cout << solve() << "\n";

	return 0;
}