package com.codingdojo.mvc.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.mvc.models.OrderProduct;

@Repository
public interface OrderProductRepository extends CrudRepository<OrderProduct, Long> {
	OrderProduct findById(long id);
}
