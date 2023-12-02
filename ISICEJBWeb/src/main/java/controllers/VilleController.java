package controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.IDaoLocale;
import entities.Hotel;
import entities.Ville;

/**
 * Servlet implementation class VilleController
 */
@WebServlet("/VilleController")
public class VilleController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB(beanName = "rakineville")
	private IDaoLocale<Ville> ejb;
	
	
	@EJB(beanName = "rakinehotel")
	private IDaoLocale<Hotel> ejbhotel;
	
	
    public VilleController() {
        super();
       
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		List<Ville> fieldList = ejb.findAll();	
		System.out.println("liste : "+fieldList);
		request.setAttribute("villes", fieldList);
		request.getRequestDispatcher("/ville.jsp").forward(request, response);

	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 
		String action = request.getParameter("action");
		
        if ("delete".equals(action)) {
            int fieldId = Integer.parseInt(request.getParameter("id"));
            ejb.delete(ejb.findById(fieldId));
            System.out.print("ville deleted");
            response.sendRedirect(request.getContextPath() + "/VilleController");
		}

		else if ("edit".equals(action)) {
			
		    int id = Integer.parseInt(request.getParameter("id"));
		    String nom = request.getParameter("nom");
		    Ville fieldToEdit = ejb.findById(id);
		    fieldToEdit.setNom(nom);
		    ejb.update(fieldToEdit);
		    response.sendRedirect(request.getContextPath() + "/VilleController");
		}

		else if("showform".equals(action)) {
			try {
				showEditForm(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	
		else {
	    String nom = request.getParameter("nom");
	  
	    Ville newField = new Ville(nom);
	    Ville creation = ejb.create(newField);
	    if (creation != null) {
		        List<Ville> Villes = ejb.findAll();
	            System.out.println(ejb.findAll());
		        request.setAttribute("villes", Villes);
		        request.getRequestDispatcher("/ville.jsp").forward(request, response);
		    } else {
		    	System.out.println("Erreur , field non crée");
		    }
	    }
	}
	
	
	
	private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Ville existingField = ejb.findById(id);
		RequestDispatcher dispatcher = request.getRequestDispatcher("editField.jsp");
		request.setAttribute("field", existingField);
		dispatcher.forward(request, response);
	
	}
		


}
