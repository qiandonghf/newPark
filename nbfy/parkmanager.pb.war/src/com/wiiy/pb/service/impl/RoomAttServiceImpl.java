package com.wiiy.pb.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.dao.RoomAttDao;
import com.wiiy.pb.entity.Room;
import com.wiiy.pb.entity.RoomAtt;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.service.RoomAttService;
import com.wiiy.pb.service.RoomService;

/**
 * @author my
 */
public class RoomAttServiceImpl implements RoomAttService{
	
	private RoomAttDao roomAttDao;
	private RoomService roomService;
	
	public void setRoomService(RoomService roomService) {
		this.roomService = roomService;
	}

	public void setRoomAttDao(RoomAttDao roomAttDao) {
		this.roomAttDao = roomAttDao;
	}

	@Override
	public Result<RoomAtt> save(RoomAtt t) {
		try {
			String img = "jpg gif jpeg png bmp";
			String att = "txt doc zip rar";
			String type = t.getType().getTitle();
			String name = t.getName();
			String suffixName = name.substring(name.lastIndexOf("."));
			suffixName = suffixName.substring(1,suffixName.length()).toLowerCase();
			int i = suffixName.length();
			int flag = 0;
			for(int a=0;a<img.length()-i;a++){
				if(img.regionMatches(0,suffixName,0,i)==true){
					flag = 1;
					break;
				}
			}
			for(int b=0;b<att.length()-i;b++){
				if(att.regionMatches(0,suffixName,0,i)==true){
					flag = 2;
					break;
				}
			}
			if(flag==1){
				if(!type.equals("图片")){
					return Result.failure("附件类型与上传文件类型不符");
				}
			}
			if(flag==2){
				if(!type.equals("附件")){
					return Result.failure("附件类型与上传文件类型不符");
				}
			}
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			roomAttDao.save(t);
			PbActivator.getOperationLogService().logLogout("添加房间附件/图片【"+t.getName()+"】");
			if(flag==1){
				Room room = roomService.getBeanById(t.getRoomId()).getValue();
				if(!room.getPhotos().contains(t.getNewName()+",")){
					String photos = room.getPhotos()+t.getNewName()+",";
					room.setPhotos(photos);
					roomService.update(room);
					PbActivator.getOperationLogService().logLogout("更新房间【"+room.getName()+"】");
				}
			}
			return Result.success(R.RoomAtt.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoomAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.RoomAtt.SAVE_FAILURE);
		}
	}

	@Override
	public Result<RoomAtt> delete(RoomAtt t) {
		try {
			String path = t.getNewName();
			PbActivator.getResourcesService().delete(path);
			PbActivator.getOperationLogService().logLogout("删除房间附件/图片【"+t.getName()+"】");
			roomAttDao.delete(t);
			return Result.success(R.RoomAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoomAtt> deleteById(Serializable id) {
		try {
			Result<RoomAtt> result = getBeanById(id);
			String path = result.getValue().getNewName();
			String reg = path+",";
			Room room = roomService.getBeanById(result.getValue().getRoomId()).getValue();
			String photos = room.getPhotos().replaceAll(reg,"");
			room.setPhotos(photos);
			roomService.update(room);
			PbActivator.getOperationLogService().logLogout("更新房间【"+room.getName()+"】");
			PbActivator.getResourcesService().delete(path);
			roomAttDao.deleteById(id);
			PbActivator.getOperationLogService().logLogout("删除房间附件/图片:id为【"+id+"】");
			return Result.success(R.RoomAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomAtt.DELETE_FAILURE);
		}
	}
	
	@Override
	public Result<RoomAtt> deleteByAttId(Serializable id) {
		try {
			Result<RoomAtt> result = getBeanById(id);
			String path = result.getValue().getNewName();
			PbActivator.getResourcesService().delete(path);
			roomAttDao.deleteById(id);
			PbActivator.getOperationLogService().logLogout("删除房间附件/图片:id为【"+id+"】");
			return Result.success(R.RoomAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomAtt.DELETE_FAILURE);
		}
	}


	@Override
	public Result<RoomAtt> deleteByIds(String ids) {
		try {
			List<Long> attIds = roomAttDao.getObjectListByHql("select r.id from RoomAtt r where r.id in ("+ids+")");
			if(attIds!=null){
				for(Long id:attIds){
					Result<RoomAtt> result = getBeanById(id);
					String path = result.getValue().getNewName();
					String reg = path+",";
					Room room = roomService.getBeanById(result.getValue().getRoomId()).getValue();
					String photos = room.getPhotos().replaceAll(reg,"");
					room.setPhotos(photos);
					roomService.update(room);
					PbActivator.getOperationLogService().logLogout("更新房间【"+room.getName()+"】");
				}
			}
			List<String> list = roomAttDao.getObjectListByHql("select r.newName from RoomAtt r where r.id in ("+ids+")");
			if(list!=null){
				for (String path : list) {
					PbActivator.getResourcesService().delete(path);
				}
			}
			roomAttDao.deleteByIds(ids);
			PbActivator.getOperationLogService().logLogout("删除房间附件/图片:ids为【"+ids+"】");
			return Result.success(R.RoomAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoomAtt> update(RoomAtt t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			roomAttDao.update(t);
			PbActivator.getOperationLogService().logLogout("更新房间附件/图片【"+t.getName()+"】");
			return Result.success(R.RoomAtt.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoomAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.RoomAtt.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<RoomAtt> getBeanById(Serializable id) {
		try {
			return Result.value(roomAttDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.RoomAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<RoomAtt> getBeanByFilter(Filter filter) {
		try {
			return Result.value(roomAttDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoomAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoomAtt>> getList() {
		try {
			return Result.value(roomAttDao.getList());
		} catch (Exception e) {
			return Result.failure(R.RoomAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoomAtt>> getListByFilter(Filter filter) {
		try {
			return Result.value(roomAttDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoomAtt.LOAD_FAILURE);
		}
	}


}
