package com.codingdojo.mvc.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.codingdojo.mvc.models.Product;
import com.codingdojo.mvc.repositories.ProductRepository;
@Service
public class ProductService {
	private final ProductRepository productRepository;
    // productRepository constructor injection
	public ProductService(ProductRepository productRepository){
		this.productRepository = productRepository;
	}
	
//    @Override
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }
    public Product findById(long id){
        return productRepository.findById(id);
    }
//    @Override
//    public Product getProduct(long id) {
//        return productRepository
//          .findById(id)
//          .orElseThrow(() -> new ResourceNotFoundException("Product not found"));
//    }
// 
//    @Override
    public Product save(Product product) {
        return productRepository.save(product);
    }
    public void deleteProduct(long id) {
    	productRepository.deleteById(id);
    }
	
}
