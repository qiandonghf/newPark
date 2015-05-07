package com.wiiy.pb.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.crm.dto.TreeDto;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.dto.FacilityDto;
import com.wiiy.pb.dto.WeekDto;
import com.wiiy.pb.entity.Facility;
import com.wiiy.pb.entity.FacilityOrder;
import com.wiiy.pb.entity.Park;
import com.wiiy.pb.preferences.enums.FacilityTypeEnum;
import com.wiiy.pb.service.FacilityOrderService;
import com.wiiy.pb.service.FacilityService;
import com.wiiy.pb.service.ParkService;
import com.wiiy.pb.util.FacilityUtil;

/**
 * @author my
 */
public class FacilityAction extends JqGridBaseAction<Facility>{
	
	private FacilityService facilityService;
	private FacilityOrderService facilityOrderService;
	private ParkService parkService;
	private Result result;
	private Facility facility;
	private Long id;
	private String ids;
	private String typeId;
	private List<Park> parkList;
	private List<FacilityTypeEnum> typeList;
	private List<Facility> facilityList = new ArrayList<Facility>();
	private Long customerId;
	
	private WeekDto weekDto;//显示周视图
	private Integer index;
	private Integer week;
	private Long facilityId;
	private Integer day;
	private Date prevWeek;
	private Date nextWeek;
	private String year;
	
	private FacilityTypeEnum type;
	
	public String add(){
		parkList = parkService.getList().getValue();
		return "add";
	}
	
	public String save(){
		Park park = parkService.getBeanById(facility.getParkId()).getValue();
		facility.setParkName(park.getName());
		result = facilityService.save(facility);
		return JSON;
	}
	
	public String view(){
		result = facilityService.getBeanById(id);
		return VIEW;
	}
	public String serviceView(){
		customerId = PbActivator.getSessionUser().getCustomerDto().getId();
		result = facilityService.getBeanById(id);
		return "serviceView";
	}
	public String edit(){
		result = facilityService.getBeanById(id);
		parkList = parkService.getList().getValue();
		return EDIT;
	}
	
	public String update(){
		Facility dbBean = facilityService.getBeanById(facility.getId()).getValue();
		BeanUtil.copyProperties(facility, dbBean);
		result = facilityService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = facilityService.deleteById(id);
		} else if(ids!=null){
			result = facilityService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String loadType(){
		List<TreeDto> dtoList = new ArrayList<TreeDto>();
		for (FacilityTypeEnum type : FacilityTypeEnum.values()) {
			TreeDto dto = new TreeDto();
			dto.setSid(type.name());
			dto.setText(type.getTitle()+"<input type='hidden' value='"+type.name()+"'><input type='hidden' value='"+type.getTitle()+"'>");
			dto.setState(TreeDto.CLOSED);
			dtoList.add(dto);
		}
		result = Result.value(dtoList);
		return "rvalue";
	}
	
	public String loadFacilityByType(){
		facilityList = facilityService.getListByFilter(new Filter(Facility.class).eq("type", type)).getValue();
		List<TreeDto> dtoList = new ArrayList<TreeDto>();
		for (Facility facility : facilityList) {
			TreeDto dto = new TreeDto();
			dto.setId(facility.getId());
			dto.setText(facility.getName()+"<input type='hidden' value='"+facility.getId()+"'>");
			dto.setState(TreeDto.OPEN);
			dtoList.add(dto);
		}
		result = Result.value(dtoList);
		return "rvalue";
	}
	
	public String loadFacilityByTypeId(){
		result = facilityService.getListByFilter(new Filter(Facility.class).eq("typeId", typeId));
		return JSON;
	}
	
	public String list(){
		//typeList = PbActivator.getDataDictInitService().getDataDictByParentId("pb.0009");
		typeList = new ArrayList<FacilityTypeEnum>();
		for(FacilityTypeEnum fte : FacilityTypeEnum.values()){
			typeList.add(fte);
		}
		facilityList = facilityService.getList().getValue();
		return LIST;
	}
	public String serviceList(){
		typeList = Arrays.asList(FacilityTypeEnum.values());
		for(FacilityTypeEnum type:typeList){
			List<Facility> list = facilityService.getListByFilter(new Filter(Facility.class).eq("type", type)).getValue();
			for(Facility facility:list){
				facilityList.add(facility);
			}
		}
		return "serviceList";
	}
	
	public String facilityWeekInfo(){
		facilityId = id;
		if(index==null){
			weekDto = FacilityUtil.generateWeekList(new Date(),0);//默认 0 为当前周
			prevWeek = CalendarUtil.add(new Date(), Calendar.WEEK_OF_YEAR, -1).getTime();
			nextWeek = CalendarUtil.add(new Date(), Calendar.WEEK_OF_YEAR, 1).getTime();
		}else{
			try {
				Date dateYear = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(year);
				prevWeek = CalendarUtil.add(dateYear, Calendar.WEEK_OF_YEAR, -1).getTime();
				nextWeek = CalendarUtil.add(dateYear, Calendar.WEEK_OF_YEAR, 1).getTime();
				weekDto = FacilityUtil.generateWeekList(dateYear,index);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		List<FacilityOrder>  facilityOrderList = facilityOrderService.getListByFilter(new Filter(FacilityOrder.class).eq("facilityId", facilityId)).getValue();
		Map<Date,List<FacilityOrder>> facilityOrderMap = new HashMap<Date, List<FacilityOrder>>();
		for(Date date : weekDto.getDateList()){
			List<FacilityOrder> newList = new ArrayList<FacilityOrder>();
			if(facilityOrderList.size()>0 && facilityOrderList!=null){
				for(FacilityOrder fo : facilityOrderList){
					Date d = DateUtil.parse(DateUtil.format(date,"yyyy-MM-dd"));
					Date startDate = DateUtil.parse(DateUtil.format(fo.getStartTime(),"yyyy-MM-dd"));	
					Date endDate = DateUtil.parse(DateUtil.format(fo.getEndTime(),"yyyy-MM-dd"));	
					if(d.getTime()<=endDate.getTime() && d.getTime()>=startDate.getTime()){
						newList.add(fo);
					}
				}
			}
			facilityOrderMap.put(date, newList);
		}
		day = Calendar.getInstance().get(Calendar.DAY_OF_WEEK)-2;
		List<FacilityDto> facilityDtoList = new ArrayList<FacilityDto>();
		for(Date date : weekDto.getDateList()){
			FacilityDto dto = new FacilityDto();
			List<FacilityOrder> list = facilityOrderMap.get(date);
			dto.setDate(date);
			dto.setFacilityOrderList(list);
			facilityDtoList.add(dto);
		}
		weekDto.setFacilityDtoList(facilityDtoList);
		return "weekInfoView";
	}
	
	@Override
	protected List<Facility> getListByFilter(Filter fitler) {
		return facilityService.getListByFilter(fitler).getValue();
	}
	
	public Facility getFacility() {
		return facility;
	}

	public void setFacility(Facility facility) {
		this.facility = facility;
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

	public void setFacilityService(FacilityService facilityService) {
		this.facilityService = facilityService;
	}
	
	public Result getResult() {
		return result;
	}

	public String getTypeId() {
		return typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}

	public void setParkService(ParkService parkService) {
		this.parkService = parkService;
	}

	public List<Park> getParkList() {
		return parkList;
	}

	public List<Facility> getFacilityList() {
		return facilityList;
	}

	public void setFacilityList(List<Facility> facilityList) {
		this.facilityList = facilityList;
	}
	public Long getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}

	public WeekDto getWeekDto() {
		return weekDto;
	}

	public void setWeekDto(WeekDto weekDto) {
		this.weekDto = weekDto;
	}

	public Integer getIndex() {
		return index;
	}

	public void setIndex(Integer index) {
		this.index = index;
	}

	public Integer getWeek() {
		return week;
	}

	public void setWeek(Integer week) {
		this.week = week;
	}

	public Long getFacilityId() {
		return facilityId;
	}

	public void setFacilityId(Long facilityId) {
		this.facilityId = facilityId;
	}

	public void setFacilityOrderService(FacilityOrderService facilityOrderService) {
		this.facilityOrderService = facilityOrderService;
	}

	public FacilityTypeEnum getType() {
		return type;
	}

	public void setType(FacilityTypeEnum type) {
		this.type = type;
	}

	public Integer getDay() {
		return day;
	}

	public void setDay(Integer day) {
		this.day = day;
	}

	public List<FacilityTypeEnum> getTypeList() {
		return typeList;
	}

	public void setTypeList(List<FacilityTypeEnum> typeList) {
		this.typeList = typeList;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public Date getPrevWeek() {
		return prevWeek;
	}

	public void setPrevWeek(Date prevWeek) {
		this.prevWeek = prevWeek;
	}

	public Date getNextWeek() {
		return nextWeek;
	}

	public void setNextWeek(Date nextWeek) {
		this.nextWeek = nextWeek;
	}
	
}
