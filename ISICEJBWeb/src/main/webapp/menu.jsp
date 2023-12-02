<!DOCTYPE html>
<html>
<head>
    <style>
        .sidebar {
      height: 100%;
      width: 190px; /* Largeur de la sidebar */
      position: fixed;
      top: 0;
      left: 0;
      background-color: #34ABD8; /* Nouvelle couleur de fond de la sidebar */
      padding-top: 60px; /* Espace pour le titre */
      display: flex;
      flex-direction: column;
      justify-content: center; /* Centrer verticalement */
      align-items: center; /* Centrer horizontalement */
      border-right: 2px solid black; /* Ajout d'une bordure droite noire */
    }

    .sidebar a {
      padding: 10px 15px;
      text-decoration: none;
      font-size: 18px;
      color: white;
      display: flex;
      align-items: center;
      transition: all 0.3s;
      margin-top: 20px;
    }

    .sidebar a:hover {
  background-color: #348DE6; /* Nouvelle couleur de fond au survol */
  border-radius: 5px; /* Arrondir légèrement les coins */
}


    .sidebar a i {
      margin-right: 10px; /* Espace entre l'icône et le texte */
      
    }

    .main-content {
      margin-left: 190px; /* Ajoute une marge à droite pour laisser de la place à la sidebar */
      
    }
    </style>
</head>
<body>
    <div class="sidebar">
        <a href="/ISICEJBWeb/ville.jsp">
            <i class="fas fa-city"></i>Ville
        </a>
        <a href="/ISICEJBWeb/hotel.jsp">
            <i class="fas fa-hotel"></i>Hôtel
        </a>
        
    </div>
</body>
</html>