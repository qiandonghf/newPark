package com.wiiy.core.entity;

import java.util.Set;

import org.apache.struts2.json.annotations.JSON;

import com.wiiy.commons.entity.BaseEntity;


/**
 * User: Lewis Wang
 * Date: 7/17/11
 * Time: 3:01 PM
 */
public class Org extends BaseEntity {


    private String name;

    private String memo;

    private Org parent;

    private int orderCode = 100;

    private int levelCode;

    private String pathCode;

    private int childrenCount;

    private Set<User> users;

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public Org getParent() {
        return parent;
    }

    public void setParent(Org parent) {
        this.parent = parent;
    }

    public int getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(int orderCode) {
        this.orderCode = orderCode;
    }

    public int getLevelCode() {
        return levelCode;
    }

    public void setLevelCode(int levelCode) {
        this.levelCode = levelCode;
    }

    public String getPathCode() {
        return pathCode;
    }

    public void setPathCode(String pathCode) {
        this.pathCode = pathCode;
    }

    public int getChildrenCount() {
        return childrenCount;
    }

    public void setChildrenCount(int childrenCount) {
        this.childrenCount = childrenCount;
    }

    public boolean isLeaf() {
        return childrenCount == 0;
    }

    public void addChild() {
        childrenCount++;
    }

    public void removeChild() {
        childrenCount--;
    }

    @JSON(serialize=false)
    public Set<User> getUsers() {
        return users;
    }

    public void setUsers(Set<User> users) {
        this.users = users;
    }
}
