<%@page import="entities.Ville"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
	integrity="..." crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<title>hotels</title>
<style>
body {
	background-color: #D0F5FF;
}

.container {
	margin-top: 20px;
}

.custom-modal-label {
	font-weight: bold;
}

.table {
	border-collapse: collapse;
	width: 100%;
}

th, td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ccc;
}

th {
	background-color: #007bff;
	color: #fff;
}

.btn {
	padding: 10px 20px;
	margin: 5px;
	cursor: pointer;
}

.btn-danger {
	background-color: #dc3545;
	color: #fff;
}

.btn-primary {
	background-color: #007bff;
	color: #446688;
}

.btn-success {
	background-color: #28a745;
	color: #fff;
}

.modal-content {
	background-color: #fff;
	border: 1px solid #ccc;
	border-radius: 5px;
	padding: 20px;
}

.modal-header {
	padding: 9px 15px;
	border-bottom: 1px solid #eee;
	background-color: #0480be;
}

.modal-header h3 {
	margin: 0;
	line-height: 30px
}

.modal-footer {
	background-color: #f8f9fa;
}

#ModifyvilleModalTitle {
	color: #4CAF50;
}
</style>
</head>
<body>

	<%@ include file="menu.jsp"%>
	<div class="main-content">

		<div class="container">
			<div class="d-flex justify-content-center">
				<h1 class="display-4 font-weight-bold">Gestion des hotels</h1>
			</div>

			<div class="d-flex justify-content-between align-items-center mb-4">
				<div class="form-group">
					<label for="selectVille"></label> <select id="selectVille"
						name="villechoisit" class="form-control">
						<option value="">Toutes les villes</option>
						<c:forEach items="${villes}" var="ville">
							<option value="${ville.id}">${ville.nom}</option>
						</c:forEach>
					</select>
				</div>
				<button type="button" class="btn btn-success add-btn">
					<i class="fas fa-plus-circle mr-2"></i>Ajouter un hotel
				</button>

			</div>


			<div id="table-container">
				<table class="table table-striped table-bordered" id="hotelTable">
					<thead class="thead-dark">
						<tr>
							<th>ID</th>
							<th class="text-center">Nom</th>
							<th class="text-center">Adresse</th>
							<th class="text-center">Telephone</th>
							<th class="text-center">Ville</th>

							<th class="text-center">Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${hotels}" var="hotel">
							<tr>
								<td class="align-middle">${hotel.id}</td>
								<td class="text-center align-middle">${hotel.nom}</td>
								<td class="text-center align-middle">${hotel.adresse}</td>
								<td class="text-center align-middle">${hotel.telephone}</td>
								<td class="text-center align-middle">${hotel.ville.nom}</td>

								<td class="text-center align-middle">
									<form action="HotelController" method="post" class="d-inline">
										<input type="hidden" name="action" value="delete"> <input
											type="hidden" name="id" value="${hotel.id}">
										<button type="button" class="btn btn-danger delete-btn"
											data-id="${hotel.id}" data-nom="${hotel.nom}">
											<i class="fas fa-trash-alt"></i>

										</button>
									</form>
									<form action="HotelController" method="post" class="d-inline">
										<input type="hidden" name="action" value="modify"> <input
											type="hidden" name="id" value="${hotel.id}">
										<button type="button"
											class="btn btn-primary edit-btn ml-2 text text-white "
											data-hotel-id="${hotel.id}" data-hotel-name="${hotel.nom}"
											data-hotel-adresse="${hotel.adresse}"
											data-hotel-telephone="${hotel.telephone}"
											data-hotel-ville="${hotel.ville.nom}">
											<i class="fas fa-edit"></i>

										</button>
									</form>
								</td>

							</tr>
						</c:forEach>
					</tbody>
				</table>

			</div>

			<div class="d-flex justify-content-between align-items-center mb-4">
				<a href=""></a>

			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<script
		src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

	<script>
		var hotelTable = $('#hotelTable').DataTable();
		
		if ($.fn.DataTable.isDataTable('#hotelTable')) {
		    hotelTable.destroy();
		}
		
		hotelTable = $('#hotelTable').DataTable({
		    "ordering": true, // Activer la fonctionnalité de tri
		    "searching": true // Activer la fonctionnalité de recherche
		});
	</script>


	<script>
	  // Redirection vers HotelController si l'URL contient "hotel.jsp"
	  if (window.location.href.indexOf('hotel.jsp') > -1) {
	    console.log('Redirection vers HotelController !');
	    window.location.href = 'HotelController';
	  } else {
	    console.log('Pas de redirection nécessaire.');
	  }
	</script>


	<script>
	
    function attachEventHandlers() {
    	 var hotelTable = $('#hotelTable').DataTable();

    	    if ($.fn.DataTable.isDataTable('#hotelTable')) {
    	        hotelTable.destroy();
    	    }

    	    hotelTable = $('#hotelTable').DataTable({
    	        "ordering": true, 
    	        "searching": true 
    	    });
    	
        $('.add-btn').on('click', function() {
            Swal.fire({
                title: 'Ajouter un hôtel',
                html: '<form id="addHotelForm" action="HotelController" method="post">' +
                    '<div class="form-group">' +
                    '<label for="hotelName">Nom</label>' +
                    '<input type="text" class="form-control" id="hotelName" name="nom" required>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label for="hotelAdresse">Adresse</label>' +
                    '<input type="text" class="form-control" id="hotelAdresse" name="adresse" required>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label for="hotelTelephone">Téléphone</label>' +
                    '<input type="text" class="form-control" id="hotelTelephone" name="telephone" required>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label for="hotelVille">Ville</label>' +
                    '<select name="ville" class="form-control" required>' +
                    '<option value="">Sélectionnez une ville</option>' +
                    '<c:forEach items="${villes}" var="ville">' +
                    '<option value="${ville.id}">${ville.nom}</option>' +
                    '</c:forEach>' +
                    '</select>' +
                    '</div>' +
                    '<input type="hidden" name="action" value="add">' +
                    '<button type="submit" class="btn btn-success mt-3">Enregistrer</button>' +
                    '</form>',
                showCancelButton: true,
                showConfirmButton: false,
                cancelButtonText: 'Annuler',
                cancelButtonColor: '#dc3545'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Intercepter la soumission du formulaire
                    $('#addHotelForm').submit(function(event) {
                        event.preventDefault(); // Empêcher l'envoi du formulaire par défaut
        
                        // Récupérer les données du formulaire
                        var formData = $(this).serialize();
        
                        // Envoyer les données au backend (exemple AJAX avec jQuery)
                        $.ajax({
                            type: 'POST',
                            url: 'HotelController', // URL de votre backend
                            data: formData,
                            success: function(response) {
                                // Mettre à jour la table des hôtels avec la nouvelle donnée (si nécessaire)
                                $('#table-container').html($(response).find('#table-container').html());

                                // Mettre à jour la liste des villes après l'ajout d'un nouvel hôtel réussi
                                $.ajax({
                                    type: 'GET',
                                    url: 'HotelController', // Endpoint pour récupérer la liste des villes
                                    success: function(villeResponse) {
                                        $('#selectVille').empty(); // Vider la liste actuelle des villes
                                        $(villeResponse).find('#selectVille option').each(function() {
                                            $('#selectVille').append($(this)); // Ajouter les options récupérées
                                        });
                                    },
                                    error: function(err) {
                                        console.error('Erreur lors de la récupération de la liste des villes:', err);
                                    }
                                });

                                
                            },
                            error: function(err) {
                               
                                console.error('Erreur lors de l\'ajout de l\'hôtel:', err);
                            }
                        });
                    });
                }
            });
        });
        
        $('.delete-btn').on('click', function() {
            var hotelId = $(this).data('id');
            var hotelNom = $(this).data('nom');

            // Confirmation de la suppression avec une boîte de dialogue
            Swal.fire({
                title: 'Êtes-vous sûr(e) de vouloir supprimer ' + hotelNom + '?',
                text: 'Cette action est irréversible!',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#dc3545',
                confirmButtonText: 'Oui, supprimer!',
                cancelButtonText: 'Annuler'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Soumission du formulaire pour la suppression
                    var form = $('<form action="HotelController" method="post">' +
                        '<input type="hidden" name="action" value="delete">' +
                        '<input type="hidden" name="id" value="' + hotelId + '">' +
                        '</form>');
                    $('body').append(form);
                    form.submit();
                }
            });
        });

        $('.edit-btn').on('click', function() {
            var hotelId = $(this).data('hotel-id');
            var hotelNom = $(this).data('hotel-name');
            var hotelAdresse = $(this).data('hotel-adresse'); 
            var hotelTelephone = $(this).data('hotel-telephone'); 
            var hotelVille = $(this).data('hotel-ville'); 

            Swal.fire({
                title: 'Modifier l\'hotel',
                html: '<form id="editHotelForm" action="HotelController" method="post">' +
                    '<div class="form-group">' +
                    '<label for="hotelName">Nom</label>' +
                    '<input type="text" class="form-control" id="hotelName" name="nom" value="' + hotelNom + '" required>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label for="hotelAdresse">Adresse</label>' +
                    '<input type="text" class="form-control" id="hotelAdresse" name="adresse" value="' + hotelAdresse + '" required>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label for="hotelTelephone">Téléphone</label>' +
                    '<input type="text" class="form-control" id="hotelTelephone" name="telephone" value="' + hotelTelephone + '" required>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label for="hotelVille">Ville</label>' +
                    '<select name="ville" class="form-control" required>' +
                    '<option value="' + hotelVille + '">' + hotelVille + '</option>' +
                    '<c:forEach items="${villes}" var="ville">' +
                    '<option value="${ville.id}">${ville.nom}</option>' +
                    '</c:forEach>' +
                    '</select>' +
                    '</div>' +
                    '<input type="hidden" name="action" value="edit">' +
                    '<input type="hidden" name="id" value="' + hotelId + '">' +
                    '<button type="submit" class="btn btn-success mt-3">Enregistrer</button>' +
                    '</form>',
                    showCancelButton: true,
                showConfirmButton: false,
                cancelButtonText: 'Annuler',
                cancelButtonColor: '#dc3545'
            }).then((result) => {
                if (result.isConfirmed) {
                    $('#editHotelForm').submit(function(event) {
                        event.preventDefault();

                        var formData = $(this).serialize();

                        $.ajax({
                            type: 'POST',
                            url: 'HotelController',
                            data: formData,
                            success: function(response) {
                                Swal.fire('Succès', 'L\'hotel a été modifiée avec succès!', 'success');
                            },
                            error: function(err) {
                                Swal.fire('Erreur', 'Une erreur est survenue lors de la modification de l\'hotel.', 'error');
                            }
                        });
                    });
                }
            });
        });
    }

    $(document).ready(function() {
       

        $('#selectVille').change(function() {
            var selectedVilleId = $(this).val();
            var url = 'HotelController'; 

            if (selectedVilleId !== '') {
                url += '?villeId=' + selectedVilleId;
            }

            $.ajax({
                type: 'GET',
                url: url,
                success: function(response) {
                    // Mettre à jour uniquement le contenu de la table des hôtels
                    $('#table-container').html($(response).find('#table-container').html());

                    
                    attachEventHandlers();
                },
                error: function(err) {
                    console.error('Erreur lors de la récupération des hôtels par ville:', err);
                }
            });
        });

      
        attachEventHandlers();
    });
</script>


</body>
</html>