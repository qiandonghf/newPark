package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.Contect;
import com.wiiy.crm.entity.Product;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.crm.service.ProductService;

/**
 * @author my
 */
public class ProductAction extends JqGridBaseAction<Product>{
	
	private ProductService productService;
	private CustomerService customerService;
	private Result result;
	private Product product;
	private Long id;
	private String ids;
	
	public String addByCustomerId(){
		result = customerService.getBeanById(id);
		return "addByCustomerId";
	}
	
	public String loadProductsByCustomerId(){
		result = productService.getListByFilter(new Filter(Product.class).include("id").include("name").eq("customerId", id));
		return JSON;
	}
	
	public String save(){
		result = productService.save(product);
		return JSON;
	}
	
	public String view(){
		result = productService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = productService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Product dbBean = productService.getBeanById(product.getId()).getValue();
		BeanUtil.copyProperties(product, dbBean);
		result = productService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = productService.deleteById(id);
		} else if(ids!=null){
			result = productService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(Product.class);
		filter.createAlias("customer", "customer");
		return refresh(filter);
	}
	
	
	@Override
	protected List<Product> getListByFilter(Filter fitler) {
		return productService.getListByFilter(fitler).getValue();
	}
	
	
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public void setProductService(ProductService productService) {
		this.productService = productService;
	}
	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}
	public Result getResult() {
		return result;
	}
}
