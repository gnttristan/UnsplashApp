AnswersTP2_Unslpash

Expliquez ce qu’est LazyVGrid et pourquoi on l’utilise.

On utilise un LazyVGrid car ce composant permet d’iterer sur une variable et de l’afficher en VGrid (grille verticale) de manière dynamique, sans connaître le nombre d’éléments à itérer.

Il existe deux types : flexible et fixed, ici, on utilise flexible car cela permet à la colonne de s’adapter à la taille du container.

On a mis qu’une seule colonne et on utilise .fill sur tout le contenu flexible ds colonnes.

Cette fonction est une extension du type Images qui permet de lui ajouter un modifier générique.

GeometryReader permet d’accéder aux paramètres de géométrie de l’image, on accèdes aux attributs avec geo.
Ensuite on l’utilise pour définir la taille de l’image en fonction de la taille de cet attribut geo : 
.frame(width: geo.size.width, height: geo.size.height)

Au début, on indique qu’on peut modifier les attributs de taille de l’image avec .resizable()
scaledToFill permet d’augmenter l’échelle de l’image quitte à l’élargir, pour remplir tout l’espace qu’elle peut contenir, lui meme défini par la colonne.
clipped() permet de cacher les parties de l’images qui sortent de la frame définie dans la ligne .frame(width: geo.size.width, height: geo.size.height)

Exercice 2 :
Nous avons besoin des attributs url.raw de chaque image

Async et await est la manière la plus simple d’utiliser l’asynchrone, async permet de lancer plusieurs fonctions et await d’attendre le résultat.
Combine permet également de traiter plusieurs taches en même temps, il se base sur des publishers, qui sont des variables qui délivrent des valeurs en envoyant des suscriptions aux Subsribers lorsque ces derniers le demandent
Le CompletionHandler utilise le Dispatcher ave l’annotation completion pour décider de manière plus complexe et détaillée la temporalité de chaque opération

