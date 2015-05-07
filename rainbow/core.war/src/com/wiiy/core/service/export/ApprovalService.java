package com.wiiy.core.service.export;

import java.util.List;

import com.wiiy.core.entity.Approval;
import com.wiiy.core.preferences.enums.ApprovalTypeEnum;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public interface ApprovalService {
	
	List<Approval> getApprovalList(Long groupId,ApprovalTypeEnum type);
	
	Approval getApproval(Long groupId,ApprovalTypeEnum type,Long userId);
	
	Result<Approval> delete(Approval t);

	Result<List<Approval>> getListByFilter(Filter filter);

}
