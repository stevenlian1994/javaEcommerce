package com.codingdojo.mvc.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codingdojo.mvc.models.ClientOrder;
import com.codingdojo.mvc.models.OrderProduct;
import com.codingdojo.mvc.models.Product;
import com.codingdojo.mvc.models.User;
import com.codingdojo.mvc.services.ClientOrderService;
import com.codingdojo.mvc.services.OrderProductService;
import com.codingdojo.mvc.services.ProductService;
import com.codingdojo.mvc.services.UserService;
import com.codingdojo.mvc.validator.UserValidator;

@Controller
public class MainController {
	private final UserValidator userValidator;
	private final UserService userService;
	private final ProductService productService;
	private final ClientOrderService clientOrderService;
	private final OrderProductService orderProductService;

	
	public MainController(UserService userService, UserValidator userValidator, ProductService productService, ClientOrderService clientOrderService, OrderProductService orderProductService) {
		this.userService = userService;
		this.productService = productService;
		this.userValidator = userValidator;
		this.clientOrderService = clientOrderService;
		this.orderProductService = orderProductService;
	}
	
	
	
	@RequestMapping("/")
	public String loginAndRegistration(@ModelAttribute("user") User user) {
		return "loginAndRegistration.jsp";
	}
	@RequestMapping(value="/registration", method=RequestMethod.POST)
	public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
	    userValidator.validate(user, result);
	    if(result.hasErrors()) {
	        return "loginAndRegistration.jsp";
	    }
	    User u = userService.registerUser(user);
	    session.setAttribute("userId", u.getId());
	    
		List<ClientOrder> basket = clientOrderService.findActive();
		if(basket.size()>0 && basket.get(0).getUser() == u) {
			session.setAttribute("clientOrderId", basket.get(0).getId());
			System.out.println(basket.get(0));
		} else {
			return "redirect:/newBasket";
		}
	    
	    return "redirect:/dashboard";
	}
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, Model model, RedirectAttributes redirectAttributes, HttpSession session) {
	    // if the user is authenticated, save their user id in session
		if(userService.authenticateUser(email, password)) {
			User thisUser = userService.findByEmail(email);
			session.setAttribute("userId", thisUser.getId());
			
			List<ClientOrder> basket = clientOrderService.findActive();
			if(basket.size()>0 && basket.get(0).getUser() == thisUser) {
				session.setAttribute("clientOrderId", basket.get(0).getId());
				System.out.println(basket.get(0));
			} else {
				return "redirect:/newBasket";
			}
			
			
			return "redirect:/dashboard";
		} else {
			System.out.println("not authenticated here");
			redirectAttributes.addFlashAttribute("error", "Invalid login");
			return "redirect:/";
		}
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	
	@RequestMapping("/dashboard")
	public String showDashboard(HttpSession session, Model model, @ModelAttribute("product") Product product) {
		Long userId = (Long) session.getAttribute("userId");
		model.addAttribute("user", userService.findUserById(userId));
//		get all products
		List<Product> allProducts = productService.getAllProducts();
		model.addAttribute("allProducts", allProducts);
		return "main/dashboard.jsp";
	}
	
	@RequestMapping(value="/addProduct", method=RequestMethod.POST)
	public String addProduct(@ModelAttribute("product") Product product) {
		System.out.println(product.getName());
//		use service to add product to db
		productService.save(product);
		return "redirect:dashboard";
	}
	@RequestMapping("/new")
	public String showNew(@ModelAttribute("product") Product product) {
		return "main/new.jsp";
	}
	@RequestMapping("/products/{id}")
	public String showEdit(@PathVariable("id") long id, Model model) {
		Product thisProduct = productService.findById(id);
		model.addAttribute("product", thisProduct);
		return "main/edit.jsp";
	}
	@RequestMapping("/products/{id}/delete")
	public String delete(@PathVariable("id") long id) {
		productService.deleteProduct(id);
		return "redirect:/dashboard";
	}
	
	@RequestMapping("/newBasket")
	public String newBasket(HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		User user = userService.findUserById(userId);
		ClientOrder clientOrder = new ClientOrder();
		clientOrder.setUser(user);
		ClientOrder thisClientOrder = clientOrderService.save(clientOrder);
		session.setAttribute("clientOrderId", thisClientOrder.getId());
		return "redirect:/dashboard";
	}
	@RequestMapping(value="/addToBasket/{id}", method=RequestMethod.POST)
	public String addToBasket(@PathVariable("id") long id,HttpSession session,@ModelAttribute("orderProduct") OrderProduct orderProduct) {
//		find product with id
		OrderProduct newOrder = new OrderProduct();
		Product product = productService.findById(id);
//		get client order
		Long clientOrderId = (Long) session.getAttribute("clientOrderId");
		ClientOrder clientOrder = clientOrderService.findById(clientOrderId);
//		set client order and product to orderProduct and save
		newOrder.setClientOrder(clientOrder);
		newOrder.setProduct(product);
		newOrder.setQuantity(orderProduct.getQuantity());
		orderProductService.save(newOrder);
		return "redirect:/dashboard";
	}
	@RequestMapping("/removeFromBasket/{id}")
	public String removeFromBasket(@PathVariable("id") long id, HttpSession session) {
//		Delete Order Product
		orderProductService.deleteOrderProduct(id);
		
//		Long clientOrderId = (Long) session.getAttribute("clientOrderId");
//		ClientOrder clientOrder = clientOrderService.findById(clientOrderId);
		
		
		return "redirect:/basket";
	}
	
	@RequestMapping("/basket")
	public String checkBasket(HttpSession session, Model model) {
		Long clientOrderId = (Long) session.getAttribute("clientOrderId");
		if(clientOrderId != null) {			
			ClientOrder clientOrder = clientOrderService.findById(clientOrderId);
			model.addAttribute("clientOrder", clientOrder);
		}
		return "/main/basket.jsp";
	}
	@RequestMapping("/deleteBasket")
	public String deleteBasket(HttpSession session) {
		Long clientOrderId = (Long) session.getAttribute("clientOrderId");
		clientOrderService.deleteClientOrder(clientOrderId);
		return "redirect:/newBasket";
	}
	@RequestMapping("/allOrders")
	public String allOrders(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		User user = userService.findUserById(userId);
		List<ClientOrder> clientOrders = user.getClientOrders();
		model.addAttribute("clientOrders", clientOrders);
		return "/main/orderHistory.jsp";
	}
	@RequestMapping("/clientOrder/{id}")
	public String showClientOrder(@PathVariable("id") long id,Model model) {
		ClientOrder clientOrder = clientOrderService.findById(id);
		model.addAttribute("clientOrder", clientOrder);
		return "/main/show.jsp";
	}
	@RequestMapping("checkoutBasket")
	public String checkoutBasket(HttpSession session, RedirectAttributes attributes) {
		Long clientOrderId = (Long) session.getAttribute("clientOrderId");
		ClientOrder clientOrder = clientOrderService.findById(clientOrderId);
		
		if (clientOrder.getOrderProducts().size()<1) {
			attributes.addFlashAttribute("emptyMessage", "Cannot checkout an empty basket");
			return "redirect:/basket";
		} else {			
			clientOrder.setCheckedOut(true);
			clientOrderService.save(clientOrder);
			return "redirect:/newBasket";
		}
	}

}
