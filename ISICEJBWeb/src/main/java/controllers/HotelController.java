package controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.IDaoLocale;
import entities.Hotel;
import entities.Ville;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.HotelService;

/**
 * Servlet implementation class hotelController
 */

@WebServlet("/HotelController")
public class HotelController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB(beanName = "rakineville")
	private IDaoLocale<Ville> ejbville;

	@EJB(beanName = "rakinehotel")
	private IDaoLocale<Hotel> ejbhotel;

	public HotelController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<Hotel> fieldList = ejbhotel.findAll();
		System.out.println("liste hotel : " + fieldList);
		request.setAttribute("hotels", fieldList);

		List<Ville> villeList = ejbville.findAll();
		System.out.println("liste ville : " + villeList);
		request.setAttribute("villes", villeList);

		String villeIdParam = request.getParameter("villeId");
		List<Hotel> filteredHotels;

		if (villeIdParam != null && !villeIdParam.isEmpty()) {
			int villeId = Integer.parseInt(villeIdParam);
			filteredHotels = ejbhotel.findHolelByVilleId(villeId);
		} else {
			filteredHotels = ejbhotel.findAll();
		}

		request.setAttribute("hotels", filteredHotels);

		request.getRequestDispatcher("/hotel.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if ("delete".equals(action)) {
			int fieldId = Integer.parseInt(request.getParameter("id"));
			ejbhotel.delete(ejbhotel.findById(fieldId));
			response.sendRedirect(request.getContextPath() + "/HotelController");
		}

		else if ("edit".equals(action)) {
			int id = Integer.parseInt(request.getParameter("id"));
			Hotel fieldToEdit = ejbhotel.findById(id);

			if (fieldToEdit != null) {
				String nom = request.getParameter("nom");
				String telephone = request.getParameter("telephone");
				String adresse = request.getParameter("adresse");


				int ville_id;
				Ville ville = null;
				String villeParam = request.getParameter("ville");
				if (villeParam != null && !villeParam.isEmpty()) {
					try {
						ville_id = Integer.parseInt(villeParam);
						ville = ejbville.findById(ville_id);
					} catch (NumberFormatException e) {

						e.printStackTrace(); 
					}
				}

				// Mettre à jour les champs modifiés
				if (nom != null && !nom.isEmpty()) {
					fieldToEdit.setNom(nom);
				}
				if (telephone != null && !telephone.isEmpty()) {
					fieldToEdit.setTelephone(telephone);
				}
				if (adresse != null && !adresse.isEmpty()) {
					fieldToEdit.setAdresse(adresse);
				}
				if (ville != null) {
					fieldToEdit.setVille(ville);
				}

				// Mettre à jour l'objet Hotel
				ejbhotel.update(fieldToEdit);
				response.sendRedirect(request.getContextPath() + "/HotelController");
			} else {
				
			}
		}

		else {
			String nom = request.getParameter("nom");
			String adresse = request.getParameter("adresse");
			String telephone = request.getParameter("telephone");
			int ville_idd = Integer.parseInt(request.getParameter("ville"));

			Ville villee = ejbville.findById(ville_idd);
			Hotel newField = new Hotel(nom, adresse, telephone, villee);

			Hotel creation = ejbhotel.create(newField);

			if (creation != null) {
				List<Hotel> Hotels = ejbhotel.findAll();
				System.out.println(ejbhotel.findAll());
				request.setAttribute("hotels", Hotels);
				request.getRequestDispatcher("/hotel.jsp").forward(request, response);
			} else {
				System.out.println("Erreuur , field non crée !!");
			}
		}
	}

}
