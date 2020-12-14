#include <iostream>
#include <vector>
#include <fstream>

int solve () {
	std::ifstream infile("data.txt");
	std::vector <int> values;
	
	int tmp;
	while (infile >> tmp) {
		values.push_back(tmp);
	}
	
	for (int i : values) {
		for (int j : values) {
			if (i != j && i + j == 2020) return i * j;
		}
	}
	
	return 0;
}

int main () {
	std:: cout << solve() << "\n";

	return 0;
}