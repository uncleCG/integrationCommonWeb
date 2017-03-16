package com.qtzk.system.utils;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.qtzk.system.bean.Right;

/**
 * 把一个list集合,里面的bean含有 parentId 转为树形式
 *    
 * @author JHONNY
 * @date 2016年5月29日下午6:57:56
 */
public class TreeUtil {

	/**
	 * 根据父节点的ID获取所有子节点
	 * @param rightList 分类表
	 * @param typeId 传入的父节点ID
	 * @return String
	 */
	public List<Right> getChildRights(List<Right> rightList, int parentId) {
		List<Right> returnList = new ArrayList<Right>();
		for (Right right : rightList) {
			// 一、根据传入的某个父节点ID,遍历该父节点的所有子节点
			if (right.getParentId() == parentId) {
				recursionFn(rightList, right);
				returnList.add(right);
			}
		}
		return returnList;
	}

	/**
	 * 递归列表
	 * @param list
	 * @param Right
	 */
	private void recursionFn(List<Right> list, Right t) {
		List<Right> childList = getChildList(list, t);// 得到子节点列表
		t.setChildren(childList);
		for (Right tChild : childList) {
			if (hasChild(list, tChild)) {// 判断是否有子节点
				//returnList.add(Permission);
				Iterator<Right> it = childList.iterator();
				while (it.hasNext()) {
					Right n = (Right) it.next();
					recursionFn(list, n);
				}
			}
		}
	}

	// 得到子节点列表
	private List<Right> getChildList(List<Right> list, Right t) {

		List<Right> tlist = new ArrayList<Right>();
		Iterator<Right> it = list.iterator();
		while (it.hasNext()) {
			Right n = (Right) it.next();
			if (n.getParentId() == t.getId()) {
				tlist.add(n);
			}
		}
		return tlist;
	}

	List<Right> returnList = new ArrayList<Right>();

	/**
	 * 根据父节点的ID获取所有子节点
	 * @param list 分类表
	 * @param typeId 传入的父节点ID
	 * @param prefix 子节点前缀
	 */
	public List<Right> getChildRights(List<Right> list, int typeId, String prefix) {
		if (list == null)
			return null;
		for (Iterator<Right> iterator = list.iterator(); iterator.hasNext();) {
			Right node = (Right) iterator.next();
			// 一、根据传入的某个父节点ID,遍历该父节点的所有子节点
			if (node.getParentId() == typeId) {
				recursionFn(list, node, prefix);
			}
			// 二、遍历所有的父节点下的所有子节点
			/*if (node.getParentId()==0) {
			    recursionFn(list, node);
			}*/
		}
		return returnList;
	}

	private void recursionFn(List<Right> list, Right node, String p) {
		List<Right> childList = getChildList(list, node);// 得到子节点列表
		if (hasChild(list, node)) {// 判断是否有子节点
			returnList.add(node);
			Iterator<Right> it = childList.iterator();
			while (it.hasNext()) {
				Right n = (Right) it.next();
				n.setName(p + n.getName());
				recursionFn(list, n, p + p);
			}
		} else {
			returnList.add(node);
		}
	}

	// 判断是否有子节点
	private boolean hasChild(List<Right> list, Right t) {
		return getChildList(list, t).size() > 0 ? true : false;
	}

	// 本地模拟数据测试
	public void main(String[] args) {
		/*
		long start = System.currentTimeMillis();
		List<Permission> PermissionList = new ArrayList<Permission>();
		
		PermissionUtil mt = new PermissionUtil();
		List<Permission> ns=mt.getChildPermissions(PermissionList,0);
		for (Permission m : ns) {
			logger.debug(m.getName());
			logger.debug(m.getChildren());
		}
		long end = System.currentTimeMillis();
		logger.debug("用时:" + (end - start) + "ms");
		*/
	}

}
