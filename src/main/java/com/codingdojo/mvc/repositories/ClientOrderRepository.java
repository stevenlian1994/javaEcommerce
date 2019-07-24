package com.codingdojo.mvc.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.mvc.models.ClientOrder;

@Repository
public interface ClientOrderRepository extends CrudRepository<ClientOrder, Long>  {
	ClientOrder findById(long id);
	List<ClientOrder> findByCheckedOut(boolean checkedOUt);
}
