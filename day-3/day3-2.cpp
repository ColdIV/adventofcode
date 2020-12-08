#include <iostream>
#include <vector>
#include <fstream>

long long solve () {
	std::ifstream infile("data.txt");
	std::string tmp;
	
	int width = -1, height = 0;
	std::vector <std::string> matrix;
	
	while (std::getline(infile, tmp)) {
		if (width < 0) width = tmp.length();
		++height;
		matrix.push_back(tmp);
	}
	
	long long count = 1;
	long long tmpC = 0;
	// 1 right 1 down
	for (int i = 0; i < height; ++i) {
		int x = 1 * i;
		int y = 1 * i;
		if (x * i > width) x = x % width;
		if (matrix[y][x] == '#') ++tmpC;
	}
	count *= tmpC;
	tmpC = 0;

	// 3 right 1 down
	for (int i = 0; i < height; ++i) {
		int x = 3 * i; // 3 to right
		int y = 1 * i; // 1 down
		if (x * i > width) x = x % width;
		if (matrix[y][x] == '#') ++tmpC;
	}
	count *= tmpC;
	tmpC = 0;
	
	// 5 right 1 down
	for (int i = 0; i < height; ++i) {
		int x = 5 * i;
		int y = 1 * i;
		if (x * i > width) x = x % width;
		if (matrix[y][x] == '#') ++tmpC;
	}
	count *= tmpC;
	tmpC = 0;
	
	// 7 right 1 down
	for (int i = 0; i < height; ++i) {
		int x = 7 * i;
		int y = 1 * i;
		if (x * i > width) x = x % width;
		if (matrix[y][x] == '#') ++tmpC;
	}
	count *= tmpC;
	tmpC = 0;
	
	// 1 right 2 down
	for (int i = 0; i < height / 2; ++i) {
		int x = 1 * i;
		int y = 2 * i;
		if (x * i > width) x = x % width;
		if (matrix[y][x] == '#') ++tmpC;
	}
	count *= tmpC;
	
	return count;
}

int main () {
	std:: cout << solve() << "\n";

	return 0;
}