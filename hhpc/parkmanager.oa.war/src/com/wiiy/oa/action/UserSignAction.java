package com.wiiy.oa.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.core.entity.User;
import com.wiiy.core.external.service.UserPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dto.DayDto;
import com.wiiy.oa.dto.MonthDto;
import com.wiiy.oa.dto.SignCountDto;
import com.wiiy.oa.entity.UserSign;
import com.wiiy.oa.entity.WorkClass;
import com.wiiy.oa.entity.WorkSchedule;
import com.wiiy.oa.preferences.enums.SignStatusEnum;
import com.wiiy.oa.preferences.enums.SignTypeEnum;
import com.wiiy.oa.service.UserSignService;
import com.wiiy.oa.service.WorkArrangeService;
import com.wiiy.oa.service.WorkClassService;
import com.wiiy.oa.service.WorkScheduleService;
import com.wiiy.oa.util.ScheduleUtil;

public class UserSignAction extends JqGridBaseAction<UserSign> {
	private UserSignService userSignService;
	private WorkClassService workClassService;
	private WorkArrangeService workArrangeService;
	private WorkScheduleService workScheduleService;
	private UserSign userSign;
	private Result result;
	private Long id;
	private String ids;
	private Long workClassId;// 班次外键
	private List<DayDto> dayDtoList;// 每月天数集合
	private List<MonthDto> monthDtoList;// 考勤统计月视图
	private Date preYearMonth;
	private Date nextYearMonth;
	private String myYearMonth = "";
	private Integer year;
	private Integer month;
	private List<UserSign> signInList;
	private List<UserSign> signOutList;
	private List<SignCountDto> signCountDtoList;
	private List<WorkClass> workClassList;
	private Date date;

	public String viewSignInfo() {
		monthDtoList = new ArrayList<MonthDto>();
		if (myYearMonth != "") {
			try {
				Date dateYearMonth = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
						.parse(myYearMonth);
				monthDtoList = ScheduleUtil.workSignList(dateYearMonth);
				preYearMonth = CalendarUtil.add(dateYearMonth, Calendar.MONTH,
						-1).getTime();
				nextYearMonth = CalendarUtil.add(dateYearMonth, Calendar.MONTH,
						1).getTime();
				year = Integer.parseInt(DateUtil.format(dateYearMonth, "yyyy"));
				month = Integer.parseInt(DateUtil.format(dateYearMonth, "MM"));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else {
			Date date = new Date();
			monthDtoList = ScheduleUtil.workSignList(date);
			preYearMonth = CalendarUtil.add(date, Calendar.MONTH, -1).getTime();
			nextYearMonth = CalendarUtil.add(date, Calendar.MONTH, 1).getTime();
			year = Integer.parseInt(DateUtil.format(date, "yyyy"));
			month = Integer.parseInt(DateUtil.format(date, "MM"));
		}
		UserPubService userPubService = OaActivator
				.getService(UserPubService.class);
		List<User> centerUserList = userPubService.getCenterUserList();
		/*
		 * //找到所有人的排班，将每个人对应的排班放入workArrangeMap中 List<WorkArrange>
		 * workArrayArrangeList = workArrangeService.getList().getValue();
		 * Map<Long,WorkArrange> workArrangeMap = new HashMap<Long,
		 * WorkArrange>(); if(workArrayArrangeList.size()>0 &&
		 * workArrayArrangeList!=null){ for(User user : centerUserList){
		 * for(WorkArrange workArrange : workArrayArrangeList){
		 * if(workArrange.getWorkerId().equals(user.getId())){
		 * workArrangeMap.put(user.getId(), workArrange); } } } }
		 */

		/*
		 * //找到每个人的班制 Map<Long,WorkSchedule> workScheduleMap = new HashMap<Long,
		 * WorkSchedule>(); for(User user : centerUserList){ WorkArrange
		 * workArrange = workArrangeMap.get(user.getId()); WorkSchedule
		 * workSchedule = new WorkSchedule(); if(workArrange!=null){
		 * workSchedule = workScheduleService.getBeanByFilter(new
		 * Filter(WorkSchedule.class).eq("id",
		 * workArrange.getScheduleId())).getValue(); }else{ workSchedule =
		 * workScheduleService.getBeanByFilter(new
		 * Filter(WorkSchedule.class).eq(
		 * "isDefault",BooleanEnum.YES)).getValue(); }
		 * workScheduleMap.put(user.getId(), workSchedule); }
		 */

		List<UserSign> userSignList = userSignService.getList().getValue();
		Map<Long, Map<String, List<UserSign>>> userSignInMap = new HashMap<Long, Map<String, List<UserSign>>>();
		Map<Long, Map<String, List<UserSign>>> userSignOutMap = new HashMap<Long, Map<String, List<UserSign>>>();
		if (userSignList.size() > 0 && userSignList != null) {
			for (User user : centerUserList) {
				if(user.getAdmin() == BooleanEnum.YES){
					continue;
				}
				Map<String, List<UserSign>> childUserInMap = new HashMap<String, List<UserSign>>();
				Map<String, List<UserSign>> childUserOutMap = new HashMap<String, List<UserSign>>();
				for (MonthDto monthDto : monthDtoList) {
					if (monthDto.getMonth().equals(month)) {
						for (DayDto dayDto : monthDto.getDayDtoList()) {
							Date date = dayDto.getDate();
							String strDate = user.getId() + "|" + date;// 将用户id和日期拼接作为查询的标识符(具有唯一性)
							String dateStr = DateUtil
									.format(date, "yyyy-MM-dd");
							List<UserSign> userSignInList = new ArrayList<UserSign>();
							List<UserSign> userSignOutList = new ArrayList<UserSign>();
							for (UserSign userSign : userSignList) {
								Date userSignDate = userSign.getSignTime();
								String userSignDateStr = DateUtil.format(
										userSignDate, "yyyy-MM-dd");
								if (userSign.getSignType().equals(
										SignTypeEnum.IN)
										&& dateStr.equals(userSignDateStr)
										&& userSign.getUserId().equals(
												user.getId())) {
									userSignInList.add(userSign);
								}
								if (userSign.getSignType().equals(
										SignTypeEnum.OUT)
										&& dateStr.equals(userSignDateStr)
										&& userSign.getUserId().equals(
												user.getId())) {
									userSignOutList.add(userSign);
								}
							}
							if (userSignInList.size() > 0
									&& userSignInList != null) {
								childUserInMap.put(strDate, userSignInList);
							} else {
								userSignInList = new ArrayList<UserSign>();
								childUserInMap.put(strDate, userSignInList);
							}
							if (userSignOutList.size() > 0
									&& userSignOutList != null) {
								childUserOutMap.put(strDate, userSignOutList);
							} else {
								userSignOutList = new ArrayList<UserSign>();
								childUserOutMap.put(strDate, userSignOutList);
							}
						}
					}
				}
				userSignInMap.put(user.getId(), childUserInMap);
				userSignOutMap.put(user.getId(), childUserOutMap);
			}
		}

		signCountDtoList = new ArrayList<SignCountDto>();
		for (User user : centerUserList) {
			if(user.getAdmin() == BooleanEnum.YES){
				continue;
			}
			SignCountDto signCountDto = new SignCountDto();
			signCountDto.setId(user.getId());
			signCountDto.setUsername(user.getRealName());
			List<MonthDto> myMonthDtoList = new ArrayList<MonthDto>();
			for (MonthDto monthDto : monthDtoList) {
				if (monthDto.getMonth().equals(month)) {
					MonthDto myMonthDto = new MonthDto();
					myMonthDto.setMonth(monthDto.getMonth());
					myMonthDto.setYear(monthDto.getYear());
					List<DayDto> dayDtoList = new ArrayList<DayDto>();
					int normalSignInNumPerMonth = 0;// 每月签到情况正常数
					int lateSignInNumPerMonth = 0;// 每月签到情况迟到数
					int normalSignOutNumPerMonth = 0;// 每月签退情况正常数
					int leaveEarlyNumPerMonth = 0;// 每月签退情况早退数
					for (DayDto dayDto : monthDto.getDayDtoList()) {
						int normalSignInNum = 0;// 每日签到情况正常数
						int lateSignInNum = 0;// 每日签到情况迟到数
						int normalSignOutNum = 0;// 每日签退情况正常数
						int leaveEarlyNum = 0;// 每日签退情况早退数
						DayDto myDayDto = new DayDto();
						myDayDto.setDaySign(dayDto.getDaySign());
						Date cDate = dayDto.getDate();
						String curDateStr = user.getId() + "|" + cDate;
						/*
						 * String curDateStr =
						 * DateUtil.format(curDate,"yyyy-MM-dd");//指定时间的字符串形式
						 * String weekDay =
						 * gainDayOfWeek(curDate);//获得指定时间是一个礼拜的第几天 WorkSchedule
						 * workSchedule =
						 * workScheduleMap.get(user.getId());//获得指定用户的班制
						 * List<WorkClass> workClassList =
						 * gainWorkClass(weekDay,workSchedule);//获得指定用户这一天的班次
						 */

						if (userSignInMap.size() > 0 && userSignInMap != null) {
							Map<String, List<UserSign>> childUserSignInMap = userSignInMap
									.get(user.getId());
							signInList = childUserSignInMap.get(curDateStr);

							Map<String, List<UserSign>> childUserSignOutMap = userSignOutMap
									.get(user.getId());
							signOutList = childUserSignOutMap.get(curDateStr);

							if (signInList.size() > 0 && signInList != null) {// 指定时间是否有签到记录
								for (UserSign userSign : signInList) {
									// 若不是签到正常，那就是迟到，至于签到缺勤，是无法确认的(因为要与班次进行比较，而班次就是可能变化的)
									if (userSign.getSignStatus().equals(
											SignStatusEnum.NORMAL)) {
										normalSignInNum++;
									}
									if (userSign.getSignStatus().equals(
											SignStatusEnum.LATE)) {
										lateSignInNum++;
									}
								}
							}

							if (signOutList.size() > 0 && signOutList != null) {// 指定日期是否有签退记录
								for (UserSign userSign : signOutList) {
									// 若不是签退正常，那就是早退，至于签退缺勤，是无法确认的(因为要与班次进行比较，而班次就是可能变化的)
									if (userSign.getSignStatus().equals(
											SignStatusEnum.NORMAL)) {
										normalSignOutNum++;
									}
									if (userSign.getSignStatus().equals(
											SignStatusEnum.LEAVEEARLY)) {
										leaveEarlyNum++;
									}
								}
							}
						}

						myDayDto.setNormalSignInNum(normalSignInNum);
						myDayDto.setNormalSignOutNum(normalSignOutNum);
						myDayDto.setLateSignInNum(lateSignInNum);
						myDayDto.setLeaveEarlyNum(leaveEarlyNum);
						dayDtoList.add(myDayDto);

						normalSignInNumPerMonth += normalSignInNum;
						lateSignInNumPerMonth += lateSignInNum;
						normalSignOutNumPerMonth += normalSignOutNum;
						leaveEarlyNumPerMonth += leaveEarlyNum;
					}
					myMonthDto.setDayDtoList(dayDtoList);
					myMonthDto
							.setNormalSignInNumPerMonth(normalSignInNumPerMonth);
					myMonthDto
							.setNormalSignOutNumPerMonth(normalSignOutNumPerMonth);
					myMonthDto.setLateSignInNumPerMonth(lateSignInNumPerMonth);
					myMonthDto.setLeaveEarlyNumPerMonth(leaveEarlyNumPerMonth);
					myMonthDtoList.add(myMonthDto);
				}
			}
			signCountDto.setMonthDtoList(myMonthDtoList);
			signCountDtoList.add(signCountDto);
		}
		myYearMonth = "";
		return "viewInfo";
	}

	public List<WorkClass> gainWorkClass(String weekDay,
			WorkSchedule workSchedule) {
		List<WorkClass> workClasseList = new ArrayList<WorkClass>();
		String[] dayWorkClassId = new String[24];
		if (weekDay == "day7") {
			dayWorkClassId = workSchedule.getDay7().split(",");
		}
		if (weekDay == "day1") {
			dayWorkClassId = workSchedule.getDay1().split(",");
		}
		if (weekDay == "day2") {
			dayWorkClassId = workSchedule.getDay2().split(",");
		}
		if (weekDay == "day3") {
			dayWorkClassId = workSchedule.getDay3().split(",");
		}
		if (weekDay == "day4") {
			dayWorkClassId = workSchedule.getDay4().split(",");
		}
		if (weekDay == "day5") {
			dayWorkClassId = workSchedule.getDay5().split(",");
		}
		if (weekDay == "day6") {
			dayWorkClassId = workSchedule.getDay6().split(",");
		}
		for (String idStr : dayWorkClassId) {
			if (!idStr.equals("")) {
				WorkClass workClass = workClassService.getBeanById(
						Long.parseLong(idStr)).getValue();
				workClasseList.add(workClass);
			}
		}
		return workClasseList;
	}

	public String gainDayOfWeek(Date receiveDate) {
		Calendar c = Calendar.getInstance();
		c.setTime(receiveDate);
		int num = c.get(Calendar.DAY_OF_WEEK);
		String weekDay = "";
		if (num == 1) {
			weekDay = "day7";
		}
		if (num == 2) {
			weekDay = "day1";
		}
		if (num == 3) {
			weekDay = "day2";
		}
		if (num == 4) {
			weekDay = "day3";
		}
		if (num == 5) {
			weekDay = "day4";
		}
		if (num == 6) {
			weekDay = "day5";
		}
		if (num == 7) {
			weekDay = "day6";
		}
		return weekDay;
	}

	public int gainSignTime(Date date) {// 当前时间的总秒数
		SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
		String currentTime = formatter.format(date);
		String[] array = currentTime.split(":");
		int signTime = Integer.valueOf(array[0]) * 3600
				+ Integer.valueOf(array[1]) * 60;
		return signTime;
	}

	public int gainStartWorkTime(Long workClassId) {// 获得上班时间的总秒数
		WorkClass workClass = new WorkClass();
		workClass = workClassService.getBeanById(workClassId).getValue();
		String startTime = workClass.getStartTime();
		String[] array = startTime.split(":");
		int startWorkTime = Integer.valueOf(array[0]) * 3600
				+ Integer.valueOf(array[1]) * 60;
		return startWorkTime;
	}

	public int gainEndWorkTime(Long workClassId) {// 获得下班时间的总秒数
		WorkClass workClass = new WorkClass();
		workClass = workClassService.getBeanById(workClassId).getValue();
		String endTime = workClass.getEndTime();
		String[] array = endTime.split(":");
		int endWorkTime = Integer.valueOf(array[0]) * 3600
				+ Integer.valueOf(array[1]) * 60;
		return endWorkTime;
	}

	public int gainSignInStartTime(Long workClassId) {// 获得签到开始时间的总秒数
		WorkClass workClass = new WorkClass();
		workClass = workClassService.getBeanById(workClassId).getValue();
		String signInStartTime = workClass.getSignInStartTime();
		String[] array = signInStartTime.split(":");
		int startTime = Integer.valueOf(array[0]) * 3600
				+ Integer.valueOf(array[1]) * 60;
		return startTime;
	}

	public int gainSignInEndTime(Long workClassId) {// 获得签到结束时间的总秒数
		WorkClass workClass = new WorkClass();
		workClass = workClassService.getBeanById(workClassId).getValue();
		String signInEndTime = workClass.getSignInEndTime();
		String[] array = signInEndTime.split(":");
		int endTime = Integer.valueOf(array[0]) * 3600
				+ Integer.valueOf(array[1]) * 60;
		return endTime;
	}

	public int gainSignOutStartTime(Long workClassId) {// 获得签退开始时间的总秒数
		WorkClass workClass = new WorkClass();
		workClass = workClassService.getBeanById(workClassId).getValue();
		String signOutStartTime = workClass.getSignOutStartTime();
		String[] array = signOutStartTime.split(":");
		int startTime = Integer.valueOf(array[0]) * 3600
				+ Integer.valueOf(array[1]) * 60;
		return startTime;
	}

	public int gainSignOutEndTime(Long workClassId) {// 获得签退结束时间的总秒数
		WorkClass workClass = new WorkClass();
		workClass = workClassService.getBeanById(workClassId).getValue();
		String signOutEndTime = workClass.getSignOutEndTime();
		String[] array = signOutEndTime.split(":");
		int endTime = Integer.valueOf(array[0]) * 3600
				+ Integer.valueOf(array[1]) * 60;
		return endTime;
	}

	public String signIn() {
		Date date = new Date();
		UserSign userSign = new UserSign();
		String signTimeStr = DateUtil.format(date, "yyyy-MM-dd");
		Long userId = OaActivator.getSessionUser().getId();
		List<UserSign> userSignList = userSignService.getListByFilter(
				new Filter(UserSign.class).eq("userId", userId).eq(
						"workClassId", workClassId)).getValue();
		if (userSignList.size() > 0 && userSignList != null) {// 判断同一人同一天同一班次是否已经有签到记录
			for (UserSign userSignOld : userSignList) {
				String signTimeInDb = DateUtil.format(
						userSignOld.getSignTime(), "yyyy-MM-dd");
				if (signTimeStr.equals(signTimeInDb)
						&& userSignOld.getSignType().equals(SignTypeEnum.IN)) {
					result = Result.failure("已经签到了，不需要重复操作");
					return JSON;
				}
			}
		}
		int signInStartTime = gainSignInStartTime(workClassId);// 签到开始时间
		int signInEndTime = gainSignInEndTime(workClassId);// 签到结束时间
		int startWorkTime = gainStartWorkTime(workClassId);// 上班时间
		int signInTime = gainSignTime(date);// 打卡时间(当前时间)
		if (signInTime < signInStartTime) {
			result = Result.failure("签到开始时间未到");
			return JSON;
		}
		if (signInTime > signInEndTime) {
			result = Result.failure("签到时间已过，请去补签");
			return JSON;
		}
		if (signInTime <= startWorkTime) {// 在签到开始时间和上班时间签到，属于正常状态
			userSign.setSignStatus(SignStatusEnum.NORMAL);
		}
		if (signInTime > startWorkTime && signInTime <= signInEndTime) {// 在上班时间和签到结束时间之间，算作迟到，属于非正常状态
			userSign.setSignStatus(SignStatusEnum.LATE);
			Long minute = (long) ((signInTime - startWorkTime) / 60);
			userSign.setMinute(minute);
		}
		userSign.setUserId(OaActivator.getSessionUser().getId());
		userSign.setWorkClassId(workClassId);
		userSign.setSignTime(date);
		userSign.setSignType(SignTypeEnum.IN);
		result = userSignService.save(userSign);
		return JSON;
	}

	public String signOut() {
		Date date = new Date();
		UserSign userSign = new UserSign();
		String signTimeStr = DateUtil.format(date, "yyyy-MM-dd");
		Long userId = OaActivator.getSessionUser().getId();
		List<UserSign> userSignList = userSignService.getListByFilter(
				new Filter(UserSign.class).eq("userId", userId).eq(
						"workClassId", workClassId)).getValue();
		if (userSignList.size() > 0 && userSignList != null) {// 判断同一人同一天同一班次是否已经有签退记录
			for (UserSign userSignOld : userSignList) {
				String signTimeInDb = DateUtil.format(
						userSignOld.getSignTime(), "yyyy-MM-dd");
				if (signTimeStr.equals(signTimeInDb)
						&& userSignOld.getSignType().equals(SignTypeEnum.OUT)) {
					result = Result.failure("已经签退了，不需要重复操作");
					return JSON;
				}
			}
		}
		int signOutStartTime = gainSignOutStartTime(workClassId);// 签退开始时间
		int signOutEndTime = gainSignOutEndTime(workClassId);// 签退结束时间
		int endWorkTime = gainEndWorkTime(workClassId);// 下班时间
		int signOutTime = gainSignTime(date);// 打卡时间(当前时间)
		if (signOutTime < signOutStartTime) {
			result = Result.failure("签退开始时间未到");
			return JSON;
		}
		if (signOutTime > signOutEndTime) {
			result = Result.failure("签退时间已过，请去补签");
			return JSON;
		}
		if (signOutTime < endWorkTime) {// 在签退开始时间和下班时间之间，算作早退，属于非正常状态
			userSign.setSignStatus(SignStatusEnum.LEAVEEARLY);
			Long minute = (long) ((endWorkTime - signOutTime) / 60);
			userSign.setMinute(minute);
		}
		if (signOutTime >= endWorkTime) {// 在下班时间和签退结束时间之间，属于正常状态
			userSign.setSignStatus(SignStatusEnum.NORMAL);
		}
		userSign.setUserId(OaActivator.getSessionUser().getId());
		userSign.setWorkClassId(workClassId);
		userSign.setSignTime(date);
		userSign.setSignType(SignTypeEnum.OUT);
		result = userSignService.save(userSign);
		return JSON;
	}

	public String list() {
		Filter filter = new Filter(UserSign.class).orderBy("user.realName",
				Filter.DESC).orderBy("signTime", Filter.DESC);
		filter.createAlias("user", "user");// 取别名,因为user的数据是从User表中取出的
		return refresh(filter);
	}

	public String save() {
		Date signTime = userSign.getSignTime();
		String signTimeStr = DateUtil.format(signTime, "yyyy-MM-dd");
		Long userId = userSign.getUserId();
		Long workClassId = userSign.getWorkClassId();
		SignTypeEnum signTypeNew = userSign.getSignType();
		List<UserSign> userSignList = userSignService.getListByFilter(
				new Filter(UserSign.class).eq("userId", userId).eq(
						"workClassId", workClassId)).getValue();
		if (userSignList.size() > 0 && userSignList != null) {// 判断同一人同一天同一班次是否已经有签到签退记录
			for (UserSign userSignOld : userSignList) {
				String signTimeInDb = DateUtil.format(
						userSignOld.getSignTime(), "yyyy-MM-dd");
				if (signTimeStr.equals(signTimeInDb)
						&& signTypeNew.equals(userSignOld.getSignType())) {
					result = Result.failure("该员工同一天同一班次已经有签到签退记录");
					return JSON;
				}
			}
		}

		if (userSign.getSignType().equals(SignTypeEnum.IN)) {
			int signInStartTime = gainSignInStartTime(userSign.getWorkClassId());// 签到开始时间
			int signInEndTime = gainSignInEndTime(userSign.getWorkClassId());// 签到结束时间
			int startWorkTime = gainStartWorkTime(userSign.getWorkClassId());// 上班时间
			int signInTime = gainSignTime(userSign.getSignTime());// 打卡时间(当前时间)
			/*if (signInTime < signInStartTime) {
				result = Result.failure("登记时间不在签到时间范围内");
				return JSON;
			}
			if (signInTime > signInEndTime) {
				result = Result.failure("登记时间不在签到时间范围内");
				return JSON;
			}*/
			if (signInTime <= startWorkTime) {// 在签到开始时间和上班时间签到，属于正常状态
				userSign.setSignStatus(SignStatusEnum.NORMAL);
				userSign.setMinute(0l);
			}
			if (signInTime > startWorkTime && signInTime <= signInEndTime) {// 在上班时间和签到结束时间之间，算作迟到，属于非正常状态
				userSign.setSignStatus(SignStatusEnum.LATE);
				Long minute = (long) ((signInTime - startWorkTime) / 60);
				userSign.setMinute(minute);
			}
		} else {
			int signOutStartTime = gainSignOutStartTime(userSign
					.getWorkClassId());// 签退开始时间
			int signOutEndTime = gainSignOutEndTime(userSign.getWorkClassId());// 签退结束时间
			int endWorkTime = gainEndWorkTime(userSign.getWorkClassId());// 下班时间
			int signOutTime = gainSignTime(userSign.getSignTime());// 打卡时间(当前时间)
			if (signOutTime < signOutStartTime) {
				result = Result.failure("登记时间不在签退时间范围内");
				return JSON;
			}
			if (signOutTime > signOutEndTime) {
				result = Result.failure("登记时间不在签退时间范围内");
				return JSON;
			}
			if (signOutTime < endWorkTime) {// 在签退开始时间和下班时间之间，算作早退，属于非正常状态
				userSign.setSignStatus(SignStatusEnum.LEAVEEARLY);
				Long minute = (long) ((endWorkTime - signOutTime) / 60);
				userSign.setMinute(minute);
			}
			if (signOutTime >= endWorkTime) {// 在下班时间和签退结束时间之间，属于正常状态
				userSign.setSignStatus(SignStatusEnum.NORMAL);
				userSign.setMinute(0l);
			}
		}
		result = userSignService.save(userSign);
		return JSON;
	}

	public String add() {
		workClassList = workClassService.getList().getValue();
		return "add";
	}

	public String delete() {
		if (id != null) {
			result = userSignService.deleteById(id);
		}
		if (ids != null) {
			result = userSignService.deleteByIds(ids);
		}
		return JSON;
	}

	public String view() {
		workClassList = workClassService.getList().getValue();
		result = userSignService.getBeanById(id);
		return VIEW;
	}
	public String edit() {
		workClassList = workClassService.getList().getValue();
		result = userSignService.getBeanById(id);
		return EDIT;
	}

	public String update() {
		UserSign dbBean = userSignService.getBeanById(userSign.getId())
				.getValue();
		BeanUtil.copyProperties(userSign, dbBean);
		result = userSignService.update(dbBean);
		return JSON;
	}

	@Override
	protected List<UserSign> getListByFilter(Filter fitler) {
		return userSignService.getListByFilter(fitler).getValue();
	}

	public UserSign getUserSign() {
		return userSign;
	}

	public void setUserSign(UserSign userSign) {
		this.userSign = userSign;
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
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

	public void setUserSignService(UserSignService userSignService) {
		this.userSignService = userSignService;
	}

	public Long getWorkClassId() {
		return workClassId;
	}

	public void setWorkClassId(Long workClassId) {
		this.workClassId = workClassId;
	}

	public void setWorkClassService(WorkClassService workClassService) {
		this.workClassService = workClassService;
	}

	public List<MonthDto> getMonthDtoList() {
		return monthDtoList;
	}

	public void setMonthDtoList(List<MonthDto> monthDtoList) {
		this.monthDtoList = monthDtoList;
	}

	public List<DayDto> getDayDtoList() {
		return dayDtoList;
	}

	public void setDayDtoList(List<DayDto> dayDtoList) {
		this.dayDtoList = dayDtoList;
	}

	public String getMyYearMonth() {
		return myYearMonth;
	}

	public void setMyYearMonth(String myYearMonth) {
		this.myYearMonth = myYearMonth;
	}

	public Date getPreYearMonth() {
		return preYearMonth;
	}

	public void setPreYearMonth(Date preYearMonth) {
		this.preYearMonth = preYearMonth;
	}

	public Date getNextYearMonth() {
		return nextYearMonth;
	}

	public void setNextYearMonth(Date nextYearMonth) {
		this.nextYearMonth = nextYearMonth;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public Integer getMonth() {
		return month;
	}

	public void setMonth(Integer month) {
		this.month = month;
	}

	public List<UserSign> getSignInList() {
		return signInList;
	}

	public void setSignInList(List<UserSign> signInList) {
		this.signInList = signInList;
	}

	public List<UserSign> getSignOutList() {
		return signOutList;
	}

	public void setSignOutList(List<UserSign> signOutList) {
		this.signOutList = signOutList;
	}

	public List<SignCountDto> getSignCountDtoList() {
		return signCountDtoList;
	}

	public void setSignCountDtoList(List<SignCountDto> signCountDtoList) {
		this.signCountDtoList = signCountDtoList;
	}

	public void setWorkArrangeService(WorkArrangeService workArrangeService) {
		this.workArrangeService = workArrangeService;
	}

	public void setWorkScheduleService(WorkScheduleService workScheduleService) {
		this.workScheduleService = workScheduleService;
	}

	public List<WorkClass> getWorkClassList() {
		return workClassList;
	}

	public void setWorkClassList(List<WorkClass> workClassList) {
		this.workClassList = workClassList;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

}
