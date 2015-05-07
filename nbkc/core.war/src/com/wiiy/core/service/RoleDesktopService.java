package com.wiiy.core.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.core.entity.DesktopItem;
import com.wiiy.core.entity.RoleDesktop;

public interface RoleDesktopService extends IService<RoleDesktop>{

	List<DesktopItem> getUserDesktopItem(Long id);

}
