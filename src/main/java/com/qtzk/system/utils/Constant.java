package com.qtzk.system.utils;

/**
 * 项目名称：
 * @author: hp
 * 
*/
public class Constant {

	/**
	 * 验证码存在session的key值
	 */
	public static final String CHECKCODE_SESSION_KEY = "imageCheckCode";

	public static final String PAGE = "10"; //分页条数配置路径

	public static final String SAVE_SUCCESS = "保存成功";

	public static final String SAVE_FAIL = "保存失败";

	public static final String DEL_SUCCESS = "删除成功";

	public static final String DEL_FAIL = "删除失败";

	public static final String EXPORT_FAIL = "导入失败";

	public static final String UPLOAD_SUCCESS = "上传成功";

	public static final String UPLOAD_FAIL = "上传失败";

	public static final String ENCODING_UTF8 = "utf-8";

	/** 成功处理返回结果*/
	public static final int RESULT_ONE = 1;
	/** 处理异常返回结果*/
	public static final int RESULT_ZERO = 0;
	/** 修改后关联信息返回结果*/
	public static final int RESULT_TWO = 2;
	/** 不允许删除返回结果*/
	public static final int RESULT_THREE = 3;
	/** 重复处理返回结果*/
	public static final int RESULT_NEGATIVE_TWO = -2;

	/**
	 * hash 加密算法名称
	 */
	public static final String HASH_ALGORITHM = "SHA-1";
	/**
	 * hash 加密。。。（可能是长度吧）
	 */
	public static final int HASH_INTERATIONS = 1024;

	public static final String SUPER_ADMIN_NAME = "superadmin";

}
