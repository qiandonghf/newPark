package com.wiiy.oa.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.TaskDepart;

public interface TaskDepartService extends IService<TaskDepart>{

	Result<TaskDepart> relatedDepartments(Long id, Long orgId);

}
