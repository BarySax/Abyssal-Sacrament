#include <iostream>

using namespace std;

string move(){
    int choice;
    cout << "Où voulez vous aller: \n";
    cout << "1-Church\n";
    cout << "2-Bar\n";
    cout << "3-Market\n";
    cout << "4-Castle\n";
    cin >> choice;
    string enplacement;
    switch (choice)
    {
        case 1:
            enplacement = "Churche";
            break;
        
        case 2:
            enplacement = "Bar";
            break;
        
        case 3:
            enplacement = "Market";
            break;
        
        case 4:
            enplacement = "Castle";
            break;
    }
    return enplacement;    
}