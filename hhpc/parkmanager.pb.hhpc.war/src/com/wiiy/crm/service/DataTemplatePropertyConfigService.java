package com.wiiy.crm.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.DataProperty;
import com.wiiy.crm.entity.DataTemplatePropertyConfig;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface DataTemplatePropertyConfigService extends IService<DataTemplatePropertyConfig> {

	Result<List<DataProperty>> getTemplatePropertys(Long templateId);
}
