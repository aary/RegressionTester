#include <iostream>
#include <unordered_map>
using namespace std;

int main(int argc, char** argv) {
	int x, y;
    cin >> x >> y;

    cout << "Arguments : ";
    for (int i = 1; i < argc; ++i) {
        cout << argv[i] << ' ';
    } cout << endl;
    cout << "X : " << x << endl << "Y : " << y << endl;

    cerr << "ERROR MESSAGE" << endl;
    
	return 0;
}
