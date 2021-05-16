def Supermarket():
    
    X = input("Veuillez saisir le nom de l'article: \n")
    Y = int(input("Veuillez saisir le nombre de l'article commandé: \n"))
    Z = float(input("Veuillez saisir le prix unitaire de l'article: \n"))
    Test = input("Avez vous fini de saisir la commande? Tapez O pour oui et N pour non : \n")
    Som = Y * Z

    if Test == "N":
        print ("Vous n'avez pas encore fini la commande. Veuillez continuer la saisie.")
        X = input("Veuillez saisir le nom de l'article: \n")
        Y = int(input("Veuillez saisir le nombre de l'article commandé : \n"))
        Z = float(input("Veuillez saisir le prix unitaire de l'article : \n"))
        Test = input("Avez vous fini de saisir la commande? Tapez O pour oui et N pour non : \n")

        while Test == "N":
            continue
    else :
        print("Vous avez fini la saisie. \n")
        print("Le nom de l'article acheté est : \n", X)
        print("Son nombre est : \n", Y)
        print("Son prix unitaire est : \n", Z)
        print("La somme totale de la facture est : \n", Som)

    print("Merci d'avoir effectue vos achats !")    
