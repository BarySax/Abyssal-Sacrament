#include "main.h"

using namespace std;

int day_last = 0;

struct player
{
    int hp = 100;
    int xp = 0;
    int level = 1;
    int attack = 10;
    int argent_collecter = 0;
    int tache_effectuer = 0;
    int faith = 100;
    string name;
    string origin;
    string enplacement;
};

string tache[6] = {"aller a la rivière chercher de l'eau pour l'apporter au pretre", "precher la sainte parole dans la rue", "acheter un employer", "eliminer un heritique", "chercher des nouveau compagnon"};            //TODO: add more tache

void printName()
{
    cout << "   db    8888Yb Yb  dP .dPY8 .dPY8      db    88         .dP-Y8    db     dP--b8 88--Yb    db    8b    d8 888888 88b 88 888888 \n";
    cout << "  dPYb   88__dP  YbdP   Ybo.   Ybo.    dPYb   88          Ybo.    dPYb   dP      88__dP   dPYb   88b  d88 88__   88Yb88   88   \n";
    cout << " dP__Yb  88  Yb   8P   o. Y8b o. Y8b  dP__Yb  88  .o     o. Y8b  dP__Yb  Yb      88 Yb   dP__Yb  88YbdP88 88     88 Y88   88   \n";
    cout << "dP    Yb 88oodP  dP    8bodP' 8bodP' dP    Yb 88ood8     8bodP  dP    Yb  YboodP 88  Yb dP    Yb 88 YY 88 888888 88  Y8   88   \n\n\n";
}

int main() 
{
    printName();
    player myPlayer;
    myPlayer.name = createPlayer();
    myPlayer.origin = setPlayerOrigin();
    int choice = 0;
    cout << "Bonjour " << myPlayer.name << "\n";
    //cout << "Pendant la nuit, tu senti une entité te soulever de ton lit pour te parler. C’était ton dieu qui voulait te parler, il te dit que tu vas devoir effectuer des taches pour avoir son pardon sinon à ta mort tu vas finir dans les abysses sacramental.\n\ntu tombes pendant quelque minute.\n\ncette troublante nuit de sommeil, tu te réveil pour commencer ta journée.\n\nTu te lève de ton lit et tu te dirige vers la salle de bain pour te laver et te préparer pour la journée qui t’attend." << endl;
    

    while (true)
    {
        if (myPlayer.origin == "Noble")
        {
            //le personage
            string personage;

            //les choix generique
            cout << "que veux tu faire ?:" << endl;
            cout << "1-te deplacer\n";
            cout << "2-tuer un heritique\n";
            cout << "3-quiter la ville\n";
            
            //choix costum avec enplacement
            if (myPlayer.enplacement == "Churche")
            {
                cout << "4-aller voir le pretre\n";
                personage = "pretre";
            } else if (myPlayer.enplacement == "Bar")
            {
                cout << "4-aller voir le barman\n";
                personage = "barman";
            } else if (myPlayer.enplacement == "Market")
            {
                cout << "4-aller voir le marchand\n";
                personage = "marchand";
            } else if (myPlayer.enplacement == "Castle")
            {
                cout << "4-aller voir le roi\n";
                personage = "roi";                
            }

            cout << "> ";
            cin >> choice;
            switch (choice)
            {
                case 1:
                    myPlayer.enplacement = move();
                    break;
                 
                case 2:
                    myPlayer.hp = fight(myPlayer.hp, myPlayer.attack);
                    if (myPlayer.hp <= 0)
                    {
                        cout << "Vous êtes mort" << endl;
                        return 0;
                    }
                    break;
                
                case 3:
                    cout << "Vous avez quitter la ville" << endl;
                    return 0;
                    break;

                case 4:
                    int taskChoice;
                    cout << "Vous avez choisi d'aller voir le " << personage << endl;
                    cout << "Quelle tâche souhaitez-vous lui confier ?" << endl;
                    cout << "1 - Livrer un message important" << endl;
                    cout << "2 - Trouver un objet précieux" << endl;
                    cout << "3 - Récupérer des informations confidentielles" << endl;
                    cout << "4 - Accomplir une mission secrète" << endl;
                    cout << "Choisissez une option : ";
                    cin >> taskChoice;
                    
                    switch (taskChoice)
                    {
                        case 1:
                            cout << "Très bien, vous devez livrer un message important au roi." << endl;
                            if (livraison("chateau"))
                            {
                                cout << "Vous avez livré le message avec succès !" << endl;
                                myPlayer.argent_collecter += 10;
                                myPlayer.tache_effectuer += 1;
                                myPlayer.xp += 10;
                                myPlayer.enplacement = "Castle";
                            }

                            break;
                            
                        case 2:
                            cout << "D'accord, votre mission est de trouver un objet précieux pour le roi." << endl;
                            if (trouverObjet("un verre en or", myPlayer.hp, myPlayer.attack))
                            {
                                cout << "Vous avez trouvé l'objet précieux !" << endl;
                                myPlayer.argent_collecter += 10;
                                myPlayer.tache_effectuer += 1;
                                myPlayer.xp += 10;
                            }
                            else
                            {
                                cout << "Vous etes mort" << endl;
                                return -1;
                            }
                            break;
                            
                        case 3:
                            cout << "Entendu, vous devez récupérer des informations confidentielles pour le roi sur le marchand." << endl;
                            espionnage();
                            myPlayer.argent_collecter += 10;
                            myPlayer.tache_effectuer += 1;
                            myPlayer.xp += 10;
                            break;
                            
                        
                            
                        default:
                            cout << "Option invalide." << endl;
                            break;
                    }
                    break;

                default:
                    break;
            }


        } else if (myPlayer.origin == "Sans dessein")
        {
            //le personage
            string personage;

            //les choix generique
            cout << "que veux tu faire ?:" << endl;
            cout << "1-te deplacer\n";
            cout << "2-tuer un heritique\n";
            cout << "3-quiter la ville\n";
            
            //choix costum avec enplacement
            if (myPlayer.enplacement == "Churche")
            {
                cout << "4-aller voir le pretre\n";
                personage = "pretre";
            } else if (myPlayer.enplacement == "Bar")
            {
                cout << "4-aller voir le barman\n";
                personage = "barman";
            } else if (myPlayer.enplacement == "Market")
            {
                cout << "4-aller voir le marchand\n";
                personage = "marchand";
            } else if (myPlayer.enplacement == "Castle")
            {
                cout << "4-aller voir le roi\n";
                personage = "roi";                
            }

            cout << "> ";
            cin >> choice;    

            switch (choice)
            {
                case 1:
                    myPlayer.enplacement = move();
                    break;

                case 2:
                    myPlayer.hp = fight(myPlayer.hp, myPlayer.attack);
                    if (myPlayer.hp <= 0)
                    {
                        cout << "Vous êtes mort" << endl;
                        return 0;
                    }
                    break;
                
                case 3:
                    cout << "Vous avez quitter la ville" << endl;
                    return 0;
                    break;

                case 4:
                    int taskChoice;
                    cout << "Vous avez choisi d'aller voir le " << personage << endl;
                    cout << "Quelle tâche souhaitez-vous lui confier ?" << endl;
                    cout << "1 - Livrer un message important" << endl;
                    cout << "2 - Trouver un objet précieux" << endl;
                    cout << "3 - Récupérer des informations confidentielles" << endl;
                    cout << "4 - Accomplir une mission secrète" << endl;
                    cout << "Choisissez une option : ";
                    cin >> taskChoice;
                    
                    switch (taskChoice)
                    {
                        case 1:
                            cout << "Très bien, vous devez livrer un message important au roi." << endl;
                            if (livraison("chateau"))
                            {
                                cout << "Vous avez livré le message avec succès !" << endl;
                                myPlayer.argent_collecter += 10;
                                myPlayer.tache_effectuer += 1;
                                myPlayer.xp += 10;
                                myPlayer.enplacement = "Castle";
                            }

                            break;
                            
                        case 2:
                            cout << "D'accord, votre mission est de trouver un objet précieux pour le roi." << endl;
                            if (trouverObjet("un verre en or", myPlayer.hp, myPlayer.attack))
                            {
                                cout << "Vous avez trouvé l'objet précieux !" << endl;
                                myPlayer.argent_collecter += 10;
                                myPlayer.tache_effectuer += 1;
                                myPlayer.xp += 10;
                            }
                            else
                            {
                                cout << "Vous etes mort" << endl;
                                return -1;
                            }
                            break;
                            
                        case 3:
                            cout << "Entendu, vous devez récupérer des informations confidentielles pour le roi sur le marchand." << endl;
                            espionnage();
                            myPlayer.argent_collecter += 10;
                            myPlayer.tache_effectuer += 1;
                            myPlayer.xp += 10;
                            break;
                            
                        
                            
                        default:
                            cout << "Option invalide." << endl;
                            break;
                    }
                    break;
                default:
                    break;
            }
        } else if (myPlayer.origin == "Pieux")
        {
            //le personage
            string personage;

            //les choix generique
            cout << "que veux tu faire ?:" << endl;
            cout << "1-te deplacer\n";
            cout << "2-tuer un heritique\n";
            cout << "3-quiter la ville\n";
            
            //choix costum avec enplacement
            if (myPlayer.enplacement == "Churche")
            {
                cout << "4-aller voir le pretre\n";
                personage = "pretre";
            } else if (myPlayer.enplacement == "Bar")
            {
                cout << "4-aller voir le barman\n";
                personage = "barman";
            } else if (myPlayer.enplacement == "Market")
            {
                cout << "4-aller voir le marchand\n";
                personage = "marchand";
            } else if (myPlayer.enplacement == "Castle")
            {
                cout << "4-aller voir le roi\n";
                personage = "roi";                
            }

            cout << "> ";
            cin >> choice;

            switch (choice)
            {
                case 1:
                    myPlayer.enplacement = move();
                    break;

                case 2:
                    myPlayer.hp = fight(myPlayer.hp, myPlayer.attack);
                    if (myPlayer.hp <= 0)
                    {
                        cout << "Vous êtes mort" << endl;
                        return 0;
                    }
                    break;
                
                case 3:
                    cout << "Vous avez quitter la ville" << endl;
                    return 0;
                    break;

                case 4:
                    int taskChoice;
                    cout << "Vous avez choisi d'aller voir le " << personage << endl;
                    cout << "Quelle tâche souhaitez-vous lui confier ?" << endl;
                    cout << "1 - Livrer un message important" << endl;
                    cout << "2 - Trouver un objet précieux" << endl;
                    cout << "3 - Récupérer des informations confidentielles" << endl;
                    cout << "4 - Accomplir une mission secrète" << endl;
                    cout << "Choisissez une option : ";
                    cin >> taskChoice;
                    
                    switch (taskChoice)
                    {
                        case 1:
                            cout << "Très bien, vous devez livrer un message important au roi." << endl;
                            if (livraison("chateau"))
                            {
                                cout << "Vous avez livré le message avec succès !" << endl;
                                myPlayer.argent_collecter += 10;
                                myPlayer.tache_effectuer += 1;
                                myPlayer.xp += 10;
                                myPlayer.enplacement = "Castle";
                            }

                            break;
                            
                        case 2:
                            cout << "D'accord, votre mission est de trouver un objet précieux pour le roi." << endl;
                            if (trouverObjet("un verre en or", myPlayer.hp, myPlayer.attack))
                            {
                                cout << "Vous avez trouvé l'objet précieux !" << endl;
                                myPlayer.argent_collecter += 10;
                                myPlayer.tache_effectuer += 1;
                                myPlayer.xp += 10;
                            }
                            else
                            {
                                cout << "Vous etes mort" << endl;
                                return -1;
                            }
                            break;
                            
                        case 3:
                            cout << "Entendu, vous devez récupérer des informations confidentielles pour le roi sur le marchand." << endl;
                            espionnage();
                            myPlayer.argent_collecter += 10;
                            myPlayer.tache_effectuer += 1;
                            myPlayer.xp += 10;
                            break;
                            
                        
                            
                        default:
                            cout << "Option invalide." << endl;
                            break;
                    }
                    break;
                
                default:
                    break;
            }
        }
        myPlayer.level = level_up(myPlayer.xp, myPlayer.level);
    }

    bool win = fight(myPlayer.hp, myPlayer.attack);
    if (win)
    {
        myPlayer.xp += 10;
        cout << "You gained 10 XP!" << endl;
    }
    else
    {
        cout << "You gained 5 XP!" << endl;
        myPlayer.xp += 5;
    }
    return 0;
}