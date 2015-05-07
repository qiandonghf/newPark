package com.wiiy.core.service.impl;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.BundleException;
import org.springframework.osgi.context.BundleContextAware;

import com.wiiy.commons.activator.APPMessageManager;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.core.dto.AppDto;
import com.wiiy.core.preferences.R;
import com.wiiy.core.service.AppService;
import com.wiiy.hibernate.Result;

public class AppServiceImpl implements AppService, BundleContextAware {

	
	public static final String APP_CONFIG_NAME = "ParkManagement-AppName";

	public static final String APP_SIMPLE_NAME = "ParkManagement-SimpleName";

	protected BundleContext bundleContext;
	
	private List<AppDto> appDtoList;
	
	public void setBundleContext(BundleContext bundleContext) {
		this.bundleContext = bundleContext;
		appDtoList = new ArrayList<AppDto>();
		Bundle[] bundles = bundleContext.getBundles();
		for (Bundle bundle : bundles) {
			if (bundle.getHeaders().get(APP_CONFIG_NAME) != null) {
				appDtoList.add(populate(bundle));
			}
		}
	}

	@Override
	public Result<List<AppDto>> getAppList() {
		return Result.value(appDtoList);
	}
	
	public static String decodeUnicode(String theString) {
		char aChar;
		int len = theString.length();
		StringBuffer outBuffer = new StringBuffer(len);
		for (int x = 0; x < len;) {
			aChar = theString.charAt(x++);
			if (aChar == '\\') {
				aChar = theString.charAt(x++);
				if (aChar == 'u') {
					int value = 0;
					for (int i = 0; i < 4; i++) {
						aChar = theString.charAt(x++);
						switch (aChar) {
						case '0':
						case '1':
						case '2':
						case '3':
						case '4':
						case '5':
						case '6':
						case '7':
						case '8':
						case '9':
							value = (value << 4) + aChar - '0';
							break;
						case 'a':
						case 'b':
						case 'c':
						case 'd':
						case 'e':
						case 'f':
							value = (value << 4) + 10 + aChar - 'a';
							break;
						case 'A':
						case 'B':
						case 'C':
						case 'D':
						case 'E':
						case 'F':
							value = (value << 4) + 10 + aChar - 'A';
							break;
						default:
							throw new IllegalArgumentException(
									"Malformed      encoding.");
						}

					}
					outBuffer.append((char) value);
				} else {
					if (aChar == 't') {
						aChar = '\t';
					} else if (aChar == 'r') {
						aChar = '\r';
					} else if (aChar == 'n') {
						aChar = '\n';
					} else if (aChar == 'f') {
						aChar = '\f';
					}
					outBuffer.append(aChar);
				}
			} else {
				outBuffer.append(aChar);
			}

		}
		return outBuffer.toString();

	}


	
	@Override
	public Result<AppDto> getApp(Long bundleId) {
		AppDto appDto = getAppByBundleId(bundleId);
		if (appDto != null) {
			appDto.setMsg(APPMessageManager.getMessage(bundleId));
			
			
			
			return Result.value(appDto);
		} else {
			return Result.failure(R.App.LOAD_FAILURE);
		}
	}
	
	private AppDto populate(Bundle bundle) {
		AppDto appDto = new AppDto();
		appDto.setName(bundle.getHeaders().get(APP_CONFIG_NAME));
		String s=bundle.getHeaders().get(APP_CONFIG_NAME);
		s=decodeUnicode(s);
		appDto.setName(s);
		
		appDto.setSimpleName(bundle.getHeaders().get(APP_SIMPLE_NAME));
		appDto.setBundleId(bundle.getBundleId());
		appDto.setAppId(bundle.getSymbolicName());
		appDto.setVersion(
				bundle.getVersion().getMajor() + "." + 
						bundle.getVersion().getMinor() + "." + bundle.getVersion().getMicro());
		appDto.setLastChangeStatus(new Date());

		if (bundle.getState() == Bundle.ACTIVE) {
			appDto.setStatus(EntityStatus.NORMAL);
		} else {
			appDto.setStatus(EntityStatus.LOCKED);
		}
		appDto.setMsg(APPMessageManager.getMessage(bundle.getBundleId()));
		return appDto;
	}

	@Override
	public Result<AppDto> start(Long bundleId) {
		Bundle bundle = bundleContext.getBundle(bundleId);
		try {
			if (bundle.getState() != Bundle.ACTIVE) {
				bundle.start();
			}
			AppDto appDto = getAppByBundleId(bundleId);
			appDto.setLastChangeStatus(new Date());
			appDto.setStatus(EntityStatus.NORMAL);
			appDto.setMsg(APPMessageManager.getMessage(bundleId));
			return Result.value(appDto);
		} catch (BundleException e) {
			return Result.failure(R.App.LOAD_FAILURE);
		}
	}

	@Override
	public Result<AppDto> stop(Long bundleId) {
		Bundle bundle = bundleContext.getBundle(bundleId);
		try {
			AppDto appDto = getAppByBundleId(bundleId);
			if (appDto.getIsPlugin() == BooleanEnum.NO) {
				return Result.failure(R.App.CORE_CANT_UNLOAD);
			}
			
			if (bundle.getState() == Bundle.ACTIVE) {
				bundle.stop();
			}
			appDto.setLastChangeStatus(new Date());
			appDto.setStatus(EntityStatus.LOCKED);
			appDto.setMsg(APPMessageManager.getMessage(bundleId));
			return Result.value(appDto);
		} catch (BundleException e) {
			return Result.failure(R.App.UNLOAD_FAILURE);
		}
	}
	
	private AppDto getAppByBundleId(Long bundleId) {
		for (AppDto appDto : appDtoList) {
			if (bundleId.equals(appDto.getBundleId())) {
				return appDto;
			}
		}
		return null;
	}
}
