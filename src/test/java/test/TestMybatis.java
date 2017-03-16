package test;

import java.io.Serializable;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.service.UserService;

//RunWith 注解是高版本Junit新增的注解
@RunWith(value = SpringJUnit4ClassRunner.class)
//通过注解指定spring的配置文件
@ContextConfiguration(locations = { "classpath:/config/spring/spring-config.xml" })
public class TestMybatis {

	@Resource(name = "userService")
	private UserService userService;
	
	@Autowired
	private RedisTemplate<Serializable, Serializable> redisTemplate;

	@Test
	public void testGetByNickname() {
		JSONObject userJo = userService.getuserByNickname("jhonny");
		System.out.println(userJo);
	}
	
	public void testRedis(){
//		redisTemplate.setS
	}
}