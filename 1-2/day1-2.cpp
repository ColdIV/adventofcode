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
			for (int k : values) {
				if (i != j && j != k && i != k && i + j + k == 2020) return i * j * k;
			}
		}
	}
	
	return 0;
}

int main () {
	std:: cout << solve() << "\n";

	return 0;
}