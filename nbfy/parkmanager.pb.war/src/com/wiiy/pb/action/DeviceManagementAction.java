package com.wiiy.pb.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.DeviceMaintenance;
import com.wiiy.pb.entity.DeviceManagement;
import com.wiiy.pb.entity.DevicePatrol;
import com.wiiy.pb.entity.DeviceWorkOrder;
import com.wiiy.pb.entity.DeviceYearly;
import com.wiiy.pb.preferences.enums.PatrolIntervalEnum;
import com.wiiy.pb.service.DeviceManagementService;

/**
 * @author zhf
 */
public class DeviceManagementAction extends JqGridBaseAction<DeviceManagement>{
	
	private DeviceManagementService deviceManagementService;
	private Result<DeviceManagement> result;
	private DeviceManagement deviceManagement;//设备管理
	private DeviceMaintenance deviceMaintenance;//设备维护
	private DevicePatrol devicePatrol;//设备巡检
	private DeviceYearly deviceYearly;//设备年检
	private DeviceWorkOrder deviceWorkOrder;//维修派工单
	private Long id;
	private String ids;
	private Integer totalCount = 0;
	private List<DeviceManagement> deviceList;
	private List<String> checkType;
	private Boolean report = false;
	
	
	public String loadDeviceCount() {
		listDesktop();
		totalCount = deviceList.size();
		return JSON;
	}
	
	
	public String listDesktop(){
		//TODO
		deviceList = new ArrayList<DeviceManagement>();
		checkType = new ArrayList<String>();
		Filter filter = new Filter(DeviceManagement.class);
		List<DeviceManagement> devices = getListByFilter(filter);
		
		for (DeviceManagement device : devices) {
			if (device.getPatrolInterval() == null &&
					device.getPatrolTime() == null && 
					device.getYearlyTime() == null&&
					device.getLastPatrolTime() == null&&
					device.getLastYearlyTime() == null) {
				continue;
			}
			
			/**
			 * 巡检
			 */
			patrol(device);
			
			/**
			 * 年检 按照设置的年检日期进行检查
			 */
			yearly(device);
			
		}
		root = deviceList;
		if (root != null && root.size() > 0) {
			for (int i = 0; i < root.size(); i++) {
				deviceManagement = root.get(i);
				String type = null;
				if (deviceManagement.getPatrolIntervalType() != null) {
					type = deviceManagement.getPatrolInterval()+" "+
							deviceManagement.getPatrolIntervalType().getTitle();
				}
				deviceManagement.setPatrolInterval(type);
			}
		}
		return JSON;
	}
	
	//年检判断
	private void yearly(DeviceManagement device) {
		int day = getDays(PatrolIntervalEnum.Year,0);
		Date nDate = new Date();
		Date yDate = device.getYearlyTime();
		Date lDate = device.getLastYearlyTime();
		if (lDate != null) {
			//如果上次年检存在
			if (yDate != null) {
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(yDate);
				calendar.add(Calendar.YEAR, -1);
				if (lDate.getTime() <= calendar.getTimeInMillis()) {
					addReport(yDate, nDate, day, device,"年检");
				}else {
					calendar.setTime(lDate);
					calendar.add(Calendar.YEAR, 1);
					addReport(calendar.getTime(), nDate, day, device,"年检");
				}
			}else {
				addReportYearly(lDate, nDate, day, device);
			}
		}else {
			//如果上次年检不存在
			if (yDate != null) {
				addReport(yDate, nDate, day, device,"年检");
			}
		}
	}
	
	//巡检判断
	private void patrol(DeviceManagement device) {
		int day = 0;
		Date nDate = new Date();
		Date patrolDate = device.getPatrolTime();
		Date lastPatrolDate = device.getLastPatrolTime();
		if (device.getPatrolInterval() != null 
				&& device.getPatrolInterval().trim().length() > 0 ) {
			//如果提醒间隔存在
			day = getDays(device.getPatrolIntervalType(), 
					Integer.parseInt(device.getPatrolInterval()));
		}else {
			//如果提醒间隔不存在,使用默认天数
			day = 15;
		}
		if (lastPatrolDate == null && patrolDate !=null) {
			device.setReportPatrol(patrolDate);
			addReport(patrolDate,nDate, day, device,"巡检");
		}else if (lastPatrolDate != null) {
			Calendar calendar = Calendar.getInstance();
			if (patrolDate != null) {
				calendar.setTime(patrolDate);
				calendar.add(Calendar.DAY_OF_YEAR, 0-day);
				if (lastPatrolDate.getTime() < calendar.getTimeInMillis()) {
					device.setReportPatrol(patrolDate);
					addReport(patrolDate, nDate, day, device,"巡检");
				}
			}else{
				calendar.setTime(lastPatrolDate);
				calendar.add(Calendar.DAY_OF_YEAR, day);
				device.setReportPatrol(calendar.getTime());
				addReport(lastPatrolDate, nDate, day, device,"巡检");
			}
		}
	}
	
	//添加检查提示
	private void addReport(Date fDate,Date nDate,int day,DeviceManagement device,String name){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(fDate);
		calendar.add(Calendar.DAY_OF_YEAR, 0-day);
		/**
		 * 如果当前日期已经超过了提醒检查的日期
		 */
		if (nDate.getTime() >= calendar.getTimeInMillis()) {
			if("年检".equals(name)){
				device.setReportYearly(fDate);
			}
			if(device.getReportType() == null){
				device.setReportType(name);
			}else {
				if ("年检".equals(name)) {
					device.setReportType(device.getReportType()+"/"+name);
					if (report) {
						return;
					}
				}
			}
			deviceList.add(device);
			checkType.add(name);
		}
	}
	

	//添加年检检查提示
	private void addReportYearly(Date fDate,Date nDate,int day,DeviceManagement device){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(fDate);
		calendar.add(Calendar.YEAR,1);
		calendar.add(Calendar.DAY_OF_YEAR, 0-day);
		/**
		 * 如果当前日期已经超过了提醒检查的日期
		 */
		if (nDate.getTime() >= calendar.getTimeInMillis()) {
			device.setReportYearly(fDate);
			if(device.getReportType() == null){
				device.setReportType("年检");
			}else {
				device.setReportType(device.getReportType()+"/年检");
				if (report) {
					return;
				}
			}
			deviceList.add(device);
			checkType.add("年检");
		}
	}
	
	//获取间隔天数
	private int getDays(PatrolIntervalEnum intervalEnum,Integer days){
		if (intervalEnum == PatrolIntervalEnum.Day) {
			return (int)Math.ceil(days/2.0);
		}else if (intervalEnum == PatrolIntervalEnum.Month) {
			return 15;
		}else if (intervalEnum == PatrolIntervalEnum.Year) {
			return 15;
		}
		return 0;
	}
	
	
	public String saveOrUpdate(){
		result = deviceManagementService.saveOrUpdate(deviceManagement);
		return JSON;
	}
	
	public String view(){
		result = deviceManagementService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = deviceManagementService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		DeviceManagement dbBean = deviceManagementService.getBeanById(deviceManagement.getId()).getValue();
		if (deviceManagement.getIsImported() == null) {
			dbBean.setIsImported(null);
		}
		if (deviceManagement.getIsCNC() == null) {
			dbBean.setIsCNC(null);
		}
		if (deviceManagement.getStatus() == null) {
			dbBean.setStatus(null);
		}
		if (deviceManagement.getPatrolIntervalType() == null) {
			dbBean.setPatrolIntervalType(null);
		}
		BeanUtil.copyProperties(deviceManagement, dbBean);
		result = deviceManagementService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = deviceManagementService.deleteById(id);
		} else if(ids!=null){
			result = deviceManagementService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		refresh(new Filter(DeviceManagement.class));
		if (root != null && root.size() > 0) {
			for (int i = 0; i < root.size(); i++) {
				deviceManagement = root.get(i);
				String type = null;
				if (deviceManagement.getPatrolIntervalType() != null) {
					type = deviceManagement.getPatrolInterval()+" "+
							deviceManagement.getPatrolIntervalType().getTitle();
				}
				deviceManagement.setPatrolInterval(type);
			}
		}
		return JSON;
	}
	
	@Override
	protected List<DeviceManagement> getListByFilter(Filter fitler) {
		return deviceManagementService.getListByFilter(fitler).getValue();
	}
	
	
	public DeviceManagement getDeviceManagement() {
		return deviceManagement;
	}

	public void setDeviceManagement(DeviceManagement deviceManagement) {
		this.deviceManagement = deviceManagement;
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

	public void setDeviceManagementService(DeviceManagementService deviceManagementService) {
		this.deviceManagementService = deviceManagementService;
	}
	public Result<DeviceManagement> getResult() {
		return result;
	}

	public DeviceMaintenance getDeviceMaintenance() {
		return deviceMaintenance;
	}

	public void setDeviceMaintenance(DeviceMaintenance deviceMaintenance) {
		this.deviceMaintenance = deviceMaintenance;
	}

	public DevicePatrol getDevicePatrol() {
		return devicePatrol;
	}

	public void setDevicePatrol(DevicePatrol devicePatrol) {
		this.devicePatrol = devicePatrol;
	}

	public DeviceYearly getDeviceYearly() {
		return deviceYearly;
	}

	public void setDeviceYearly(DeviceYearly deviceYearly) {
		this.deviceYearly = deviceYearly;
	}

	public DeviceWorkOrder getDeviceWorkOrder() {
		return deviceWorkOrder;
	}

	public void setDeviceWorkOrder(DeviceWorkOrder deviceWorkOrder) {
		this.deviceWorkOrder = deviceWorkOrder;
	}

	public Integer getTotalCount() {
		return totalCount;
	}


	public List<DeviceManagement> getDeviceList() {
		return deviceList;
	}


	public List<String> getCheckType() {
		return checkType;
	}


	public void setReport(Boolean report) {
		this.report = report;
	}

}
