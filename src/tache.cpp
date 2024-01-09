#include <iostream>
#include <unistd.h>
#include "fight.h"

using namespace std;

bool livraison(string allerA)
{
    cout << "tu te mes en chemin pour aller a " << allerA << endl;
    sleep(1);
    cout << "tu rencontre un chien gentill, et tu le carresse" << endl;
    cout << "tu continue ton chemin" << endl;
    sleep(1);
    cout << "tu arrive a " << allerA << endl;
    return true;
}

bool trouverObjet(string objet, int playerHp, int attaque)
{
    cout << "tu te mes en chemin pour trouver " << objet << endl;
    sleep(1);
    cout << "tu voit une creature et tu la combat" << endl;
    
    if (fight(playerHp, attaque) == 0)
    {
        return false;
    }
    else
    {
        cout << "tu a gagner le combat" << endl;
        sleep(1);
        cout << "tu continue ton chemin" << endl;
        sleep(1);
        cout << "tu trouve " << objet << endl;
        return true;
    }

}

bool espionnage()
{
    cout << "tu te mes en chemin pour aller espionner" << endl;
    sleep(1);
    cout << "tu arrive a destination" << endl;
    sleep(1);
    cout << "tu espionne" << endl;
    sleep(1);
    cout << "tu a fini d'espionner et tu rentre" << endl;
    return true;
}