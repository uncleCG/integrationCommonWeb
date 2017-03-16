package com.qtzk.system.task;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class TestTask {

	private Logger logger = LoggerFactory.getLogger(TestTask.class);

	private int runTime = 1;

	@Scheduled(cron = "0 0/5 * * * ? ")
	public void TestTask1() {
		logger.info("TestTask 第 " + runTime + " 次执行");
		runTime++;
	}

}
