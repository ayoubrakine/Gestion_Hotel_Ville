package services;

import java.util.List;

import dao.IDaoLocale;
import dao.IDaoRemote;
import entities.Hotel;
import jakarta.ejb.Stateful;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless(name = "rakinehotel")


public class HotelService implements IDaoRemote<Hotel>, IDaoLocale<Hotel> {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public Hotel create(Hotel o) {
		em.persist(o);
		return o;
	}

	@Override
	public boolean delete(Hotel o) {
		//em.merge(o) pour obtenir une référence à l'entité persistante et la retourne
		Hotel mergedHotel = em.merge(o);
	    em.remove(mergedHotel);
		return true;
	}

	@Override
	public Hotel update(Hotel o) {
		Hotel mergedHotel = em.merge(o);
		return mergedHotel;
		
	}

	@Override
	public Hotel findById(int id) {
		return em.find(Hotel.class, id);
	}

	@Override
	public List<Hotel> findAll() {
		Query query = em.createQuery("select h from Hotel h");
		return query.getResultList();
	}
	
	
	@Override
	public List<Hotel> findHolelByVilleId (int villeId) {
	    Query query = em.createQuery("select vh from Hotel vh where vh.ville.id = :id");
	    query.setParameter("id", villeId);
	    List<Hotel> resultList = query.getResultList();
	    return resultList.isEmpty() ? null : resultList;
	}
	
		
}
