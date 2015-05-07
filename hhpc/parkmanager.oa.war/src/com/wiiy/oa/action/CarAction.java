package com.wiiy.oa.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.Car;
import com.wiiy.oa.service.CarService;

public class CarAction extends JqGridBaseAction<Car>{
	private CarService carService;
	private Car car;
	private Long id;
	private String ids;
	private Result result;
	private List<Car> carList;
	
	public String list(){
		Filter filter = new Filter(Car.class);
		return refresh(filter);
	}
	
	public String save(){
		result = carService.save(car);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = carService.deleteById(id);
		}
		if(ids!=null){
			result = carService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		result = carService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		result = carService.update(car);
		return JSON;
	}
	
	public String view(){
		result = carService.getBeanById(id);
		return VIEW;
	}
	
	public String carSelect(){
		carList = carService.getListByFilter(new Filter(Car.class)).getValue();
		return "carSelect";
	}
	
	
	public Car getCar() {
		return car;
	}
	public void setCar(Car car) {
		this.car = car;
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
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
	}
	public void setCarService(CarService carService) {
		this.carService = carService;
	}
	@Override
	protected List<Car> getListByFilter(Filter fitler) {
		return carService.getListByFilter(fitler).getValue();
	}

	public List<Car> getCarList() {
		return carList;
	}

	public void setCarList(List<Car> carList) {
		this.carList = carList;
	}

}
