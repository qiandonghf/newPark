package com.wiiy.core.service;

import java.util.List;

import com.wiiy.core.dto.AppDto;
import com.wiiy.hibernate.Result;

public interface AppService {

	Result<List<AppDto>> getAppList();

	Result<AppDto> getApp(Long bundleId);

	Result<AppDto> start(Long bundleId);

	Result<AppDto> stop(Long bundleId);
}
