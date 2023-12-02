package services;

import java.util.List;

import dao.IDaoLocale;
import dao.IDaoRemote;
import entities.Hotel;
import entities.Ville;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless(name = "rakineville")
public class VilleService implements IDaoRemote<Ville>, IDaoLocale<Ville> {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public Ville create(Ville o) {
		em.persist(o);
		return o;
	}

	@Override
	public boolean delete(Ville o) {
		  
	    Ville mergedVille = em.merge(o);
	    em.remove(mergedVille);
		return true;
	}

	@Override
	public Ville update(Ville o) {
		Ville mergedVille = em.merge(o);
		return mergedVille;
		
	}

	@Override
	public Ville findById(int id) {
		// TODO Auto-generated method stub
		return em.find(Ville.class, id);
	}

	@Override
	public List<Ville> findAll() {
		Query query = em.createQuery("select v from Ville v");
		return query.getResultList();
	}

	
	@Override
	public List<Ville> findHolelByVilleId (int villeId) {
	    // hadi rr bach n implementiiiiiw
	    return null;
	}

}
