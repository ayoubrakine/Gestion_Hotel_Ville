
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
<title>villes</title>
<style>
body {
	background-color: #D0F5FF; /* Changement de couleur de fond */
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
				<h1 class="display-4 font-weight-bold">Gestion des villes</h1>
			</div>

			<div class="d-flex justify-content-between align-items-center mb-4">
				<h1 class="display-4"></h1>
				<button type="button" class="btn btn-success add-btn">
					<i class="fas fa-plus-circle mr-2"></i>Ajouter une ville
				</button>

			</div>


			<div class="modal fade" id="villeModalCenter" tabindex="-1"
				role="dialog" aria-labelledby="villeModalCenterTitle"
				aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<form action="VilleController" method="post">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="villeModalCenterTitle">Ajouter
									une ville</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">

								<label class="custom-modal-label" for="Name">Nom</label> <input
									type="text" name="nom" class="form-control" required><br>
								<br>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Fermer</button>
								<input type="submit" class="btn btn-success" value="Enregistrer">
							</div>
						</div>
					</form>
				</div>
			</div>



			<table id="villeTable" class="table table-striped table-bordered">
				<thead class="thead-dark">
					<tr>
						<th>ID</th>
						<th class="text-center">Nom</th>
						<th class="text-center">Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${villes}" var="ville">
						<tr>
							<td class="align-middle">${ville.id}</td>
							<td class="text-center align-middle">${ville.nom}</td>
							<td class="text-center align-middle">
								<form action="VilleController" method="post" class="d-inline">
									<input type="hidden" name="action" value="delete"> <input
										type="hidden" name="id" value="${ville.id}">

									<button type="button" class="btn btn-danger delete-btn"
										data-id="${ville.id}" data-nom="${ville.nom}">
										<i class="fas fa-trash-alt"></i>
									</button>

								</form>
								<form action="VilleController" method="post" class="d-inline">
									<input type="hidden" name="action" value="modify"> <input
										type="hidden" name="id" value="${ville.id}">
									<button type="button"
										class="btn btn-primary edit-btn ml-2 text text-white"
										data-toggle="modal" data-target="#ModifyvilleModal"
										data-ville-id="${ville.id}" data-ville-name="${ville.nom}">
										<i class="fas fa-edit"></i>

									</button>
								</form>
							</td>

						</tr>
					</c:forEach>
				</tbody>
			</table>


			<div class="d-flex justify-content-between align-items-center mb-4">
				<a href=""></a>

			</div>
		</div>

	</div>


	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<script
		src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

	<!-- Initialisation de DataTables.js avec recherche -->
	<script>
    $(document).ready(function() {
        $('#villeTable').DataTable({
            "ordering": true, // Activer la fonctionnalité de tri
            "searching": true // Activer la fonctionnalité de recherche
        });
    });
</script>
	<script>
	  // redirecte to controller
	  if (window.location.href.indexOf('ville.jsp') > -1) {
	    window.location.href = 'VilleController';
	  }
	</script>

	<script>
    $(document).ready(function() {
        $('.delete-btn').on('click', function() {
            var villeId = $(this).data('id');
            var villeNom = $(this).data('nom');

            Swal.fire({
                title: 'Êtes-vous sûr(e) de vouloir supprimer ' + villeNom + '?',
                text: 'Cette action est irréversible!',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#dc3545',
                confirmButtonText: 'Oui, supprimer!',
                cancelButtonText: 'Annuler'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Si l'utilisateur confirme la suppression, soumettre le formulaire de suppression
                    var form = $('<form action="VilleController" method="post">' +
                        '<input type="hidden" name="action" value="delete">' +
                        '<input type="hidden" name="id" value="' + villeId + '">' +
                        '</form>');
                    $('body').append(form);
                    form.submit();
                }
            });
        });
    });
</script>


	<script>
    $(document).ready(function() {
        $('.add-btn').on('click', function() {
            Swal.fire({
                title: 'Ajouter une ville',
                html: '<form id="addVilleForm" action="VilleController" method="post">' +
                    '<div class="form-group">' +
                    '<label for="villeName">Nom</label>' +
                    '<input type="text" class="form-control" id="villeName" name="nom" required>' +
                    '</div>' +
                    '<input type="hidden" name="action">' +
                    '<button type="submit" class="btn btn-success mt-3">Enregistrer</button>' +
                    '</form>',
                showCancelButton: true,
                showConfirmButton: false,
                cancelButtonText: 'Annuler',
                cancelButtonColor: '#dc3545'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Intercepter la soumission du formulaire
                    $('#addVilleForm').submit(function(event) {
                        event.preventDefault(); // Empêcher l'envoi du formulaire par défaut

                        // Récupérer les données du formulaire
                        var formData = $(this).serialize();

                        // Envoyer les données au backend (exemple AJAX avec jQuery)
                        $.ajax({
                            type: 'POST',
                            url: 'VilleController', // URL de votre backend
                            data: formData,
                            success: function(response) {
                                // Gérer la réponse si nécessaire
                                Swal.fire('Succès', 'La ville a été ajoutée avec succès!', 'success');
                            },
                            error: function(err) {
                                // Gérer les erreurs si nécessaire
                                Swal.fire('Erreur', 'Une erreur est survenue lors de l\'ajout de la ville.', 'error');
                            }
                        });
                    });
                }
            });
        });
    });
</script>



	<script>
        $(document).ready(function() {
            $('.edit-btn').on('click', function() {
                var villeId = $(this).data('ville-id');
                var villeNom = $(this).data('ville-name');

                Swal.fire({
                    title: 'Modifier la ville',
                    html: '<form id="editVilleForm" action="VilleController" method="post">' +
                        '<div class="form-group">' +
                        '<label for="villeName">Nom</label>' +
                        '<input type="text" class="form-control" id="villeName" name="nom" value="' + villeNom + '" required>' +
                        '</div>' +
                        '<input type="hidden" name="action" value="edit">' +
                        '<input type="hidden" name="id" value="' + villeId + '">' +
                        '<button type="submit" class="btn btn-success mt-3">Enregistrer</button>' +
                        '</form>',
                    showCancelButton: true,
                    showConfirmButton: false,
                    cancelButtonText: 'Annuler',
                    cancelButtonColor: '#dc3545'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $('#editVilleForm').submit(function(event) {
                            event.preventDefault();

                            var formData = $(this).serialize();

                            $.ajax({
                                type: 'POST',
                                url: 'VilleController',
                                data: formData,
                                success: function(response) {
                                    Swal.fire('Succès', 'La ville a été modifiée avec succès!', 'success');
                                },
                                error: function(err) {
                                    Swal.fire('Erreur', 'Une erreur est survenue lors de la modification de la ville.', 'error');
                                }
                            });
                        });
                    }
                });
            });
        });
    </script>






</body>
</html>