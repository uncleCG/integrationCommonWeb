<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="../../common/taglib.jsp"%>
<script type="text/javascript" src="${ctx}/statics/lib/jquery/1.9.1/jquery.min.js"></script>
<!DOCTYPE HTML>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
		<style type="text/css">
			.main {padding: 5px 5px;}
			.icon_lists li{float: left;width: 100px;height: 100px;text-align: center}
			.icon_lists .Hui-iconfont{font-size: 24px;line-height: 24px;margin: 5px 0;color: #333;-webkit-transition: font-size 0.25s ease-out 0s;-moz-transition: font-size 0.25s ease-out 0s;transition: font-size 0.25s ease-out 0s}
			
		</style>
	</head>
<body>
<div class="main">
	<ul class="icon_lists cl">
		<li> <i class="icon Hui-iconfont">&#xe625;</i>
			<div class="name">home</div>
			<div class="code">&amp;#xe625;</div>
			<div class="fontclass">.Hui-iconfont-home</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe67f;</i>
			<div class="name">小箭头</div>
			<div class="code">&amp;#xe67f;</div>
			<div class="fontclass">.Hui-iconfont-home2</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe616;</i>
			<div class="name">cmstop新闻</div>
			<div class="code">&amp;#xe616;</div>
			<div class="fontclass">.Hui-iconfont-news</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe613;</i>
			<div class="name">图片</div>
			<div class="code">&amp;#xe613;</div>
			<div class="fontclass">.Hui-iconfont-tuku</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe60f;</i>
			<div class="name">音乐</div>
			<div class="code">&amp;#xe60f;</div>
			<div class="fontclass">.Hui-iconfont-music</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe64b;</i>
			<div class="name">标签</div>
			<div class="code">&amp;#xe64b;</div>
			<div class="fontclass">.Hui-iconfont-tags</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe66f;</i>
			<div class="name">语音</div>
			<div class="code">&amp;#xe66f;</div>
			<div class="fontclass">.Hui-iconfont-yuyin3</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe62e;</i>
			<div class="name">系统</div>
			<div class="code">&amp;#xe62e;</div>
			<div class="fontclass">.Hui-iconfont-system</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe633;</i>
			<div class="name">帮助</div>
			<div class="code">&amp;#xe633;</div>
			<div class="fontclass">.Hui-iconfont-help</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe634;</i>
			<div class="name">出库</div>
			<div class="code">&amp;#xe634;</div>
			<div class="fontclass">.Hui-iconfont-chuku</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe646;</i>
			<div class="name">图片</div>
			<div class="code">&amp;#xe646;</div>
			<div class="fontclass">.Hui-iconfont-picture</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe681;</i>
			<div class="name">分类</div>
			<div class="code">&amp;#xe681;</div>
			<div class="fontclass">.Hui-iconfont-fenlei</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe636;</i>
			<div class="name">合同管理</div>
			<div class="code">&amp;#xe636;</div>
			<div class="fontclass">.Hui-iconfont-hetong</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe687;</i>
			<div class="name">全部订单</div>
			<div class="code">&amp;#xe687;</div>
			<div class="fontclass">.Hui-iconfont-quanbudingdan</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe637;</i>
			<div class="name">任务管理</div>
			<div class="code">&amp;#xe637;</div>
			<div class="fontclass">.Hui-iconfont-renwu</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe691;</i>
			<div class="name">问题反馈</div>
			<div class="code">&amp;#xe691;</div>
			<div class="fontclass">.Hui-iconfont-feedback</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe692;</i>
			<div class="name">意见反馈</div>
			<div class="code">&amp;#xe692;</div>
			<div class="fontclass">.Hui-iconfont-feedback2</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe639;</i>
			<div class="name">合同</div>
			<div class="code">&amp;#xe639;</div>
			<div class="fontclass">.Hui-iconfont-dangan</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe623;</i>
			<div class="name">日志</div>
			<div class="code">&amp;#xe623;</div>
			<div class="fontclass">.Hui-iconfont-log</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe626;</i>
			<div class="name">列表页面</div>
			<div class="code">&amp;#xe626;</div>
			<div class="fontclass">.Hui-iconfont-pages</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe63e;</i>
			<div class="name">文件</div>
			<div class="code">&amp;#xe63e;</div>
			<div class="fontclass">.Hui-iconfont-file</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe63c;</i>
			<div class="name">管理</div>
			<div class="code">&amp;#xe63c;</div>
			<div class="fontclass">.Hui-iconfont-manage2</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe627;</i>
			<div class="name">订单</div>
			<div class="code">&amp;#xe627;</div>
			<div class="fontclass">.Hui-iconfont-order</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6a4;</i>
			<div class="name">语音</div>
			<div class="code">&amp;#xe6a4;</div>
			<div class="fontclass">.Hui-iconfont-yuyin2</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6a5;</i>
			<div class="name">语音</div>
			<div class="code">&amp;#xe6a5;</div>
			<div class="fontclass">.Hui-iconfont-yuyin</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe612;</i>
			<div class="name">图片</div>
			<div class="code">&amp;#xe612;</div>
			<div class="fontclass">.Hui-iconfont-picture1</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe685;</i>
			<div class="name">图文详情</div>
			<div class="code">&amp;#xe685;</div>
			<div class="fontclass">.Hui-iconfont-tuwenxiangqing</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe62c;</i>
			<div class="name">用户</div>
			<div class="code">&amp;#xe62c;</div>
			<div class="fontclass">.Hui-iconfont-user</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe60d;</i>
			<div class="name">用户</div>
			<div class="code">&amp;#xe60d;</div>
			<div class="fontclass">.Hui-iconfont-user2</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe60a;</i>
			<div class="name">用户头像</div>
			<div class="code">&amp;#xe60a;</div>
			<div class="fontclass">.Hui-iconfont-avatar</div>
		</li>
		<li>
        	<i class="icon Hui-iconfont">&#xe705;</i>
            <div class="name">个人中心</div>
            <div class="code">&amp;#xe705;</div>
            <div class="fontclass">.Hui-iconfont-avatar2</div>
        </li>
		<li> <i class="icon Hui-iconfont">&#xe607;</i>
			<div class="name">添加用户</div>
			<div class="code">&amp;#xe607;</div>
			<div class="fontclass">.Hui-iconfont-user-add</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe602;</i>
			<div class="name">用户ID</div>
			<div class="code">&amp;#xe602;</div>
			<div class="fontclass">.Hui-iconfont-userid</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe638;</i>
			<div class="name">证照管理</div>
			<div class="code">&amp;#xe638;</div>
			<div class="fontclass">.Hui-iconfont-zhizhao</div>
		</li>
		<li>
        	<i class="icon Hui-iconfont">&#xe70d;</i>
            <div class="name">执业证</div>
            <div class="code">&amp;#xe70d;</div>
            <div class="fontclass">.Hui-iconfont-practice</div>
        </li>
		<li> <i class="icon Hui-iconfont">&#xe62b;</i>
			<div class="name">群组</div>
			<div class="code">&amp;#xe62b;</div>
			<div class="fontclass">.Hui-iconfont-user-group</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe653;</i>
			<div class="name">站长</div>
			<div class="code">&amp;#xe653;</div>
			<div class="fontclass">.Hui-iconfont-user-zhanzhang</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe62d;</i>
			<div class="name">管理员</div>
			<div class="code">&amp;#xe62d;</div>
			<div class="fontclass">.Hui-iconfont-root</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe643;</i>
			<div class="name">公司</div>
			<div class="code">&amp;#xe643;</div>
			<div class="fontclass">.Hui-iconfont-gongsi</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6b4;</i>
			<div class="name">会员卡</div>
			<div class="code">&amp;#xe6b4;</div>
			<div class="fontclass">.Hui-iconfont-vip-card2</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6cc;</i>
			<div class="name">会员</div>
			<div class="code">&amp;#xe6cc;</div>
			<div class="fontclass">.Hui-iconfont-vip</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe611;</i>
			<div class="name">群组</div>
			<div class="code">&amp;#xe611;</div>
			<div class="fontclass">.Hui-iconfont-usergroup2</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6d0;</i>
			<div class="name">客服</div>
			<div class="code">&amp;#xe6d0;</div>
			<div class="fontclass">.Hui-iconfont-kefu</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe666;</i>
			<div class="name">分享</div>
			<div class="code">&amp;#xe666;</div>
			<div class="fontclass">.Hui-iconfont-share2</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6aa;</i>
			<div class="name">分享</div>
			<div class="code">&amp;#xe6aa;</div>
			<div class="fontclass">.Hui-iconfont-share</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6d8;</i>
			<div class="name">人人网</div>
			<div class="code">&amp;#xe6d8;</div>
			<div class="fontclass">.Hui-iconfont-share-renren</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6d9;</i>
			<div class="name">腾讯微博</div>
			<div class="code">&amp;#xe6d9;</div>
			<div class="fontclass">.Hui-iconfont-share-tweibo</div>
		</li>
		<li>
			<i class="icon Hui-iconfont">&#xe67c;</i>
			<div class="name">豆瓣</div>
			<div class="code">&amp;#xe67c;</div>
			<div class="fontclass">.Hui-iconfont-share-douban</div>
		</li>
		<li>
			<i class="icon Hui-iconfont">&#xe693;</i>
			<div class="name">朋友圈</div>
			<div class="code">&amp;#xe693;</div>
			<div class="fontclass">.Hui-iconfont-share-pengyouquan</div>
		</li>
		<li>
			<i class="icon Hui-iconfont">&#xe694;</i>
			<div class="name">微信</div>
			<div class="code">&amp;#xe694;</div>
			<div class="fontclass">.Hui-iconfont-share-weixin</div>
		</li>
		<li>
			<i class="icon Hui-iconfont">&#xe67b;</i>
			<div class="name">QQ</div>
			<div class="code">&amp;#xe67b;</div>
			<div class="fontclass">.Hui-iconfont-share-qq</div>
		</li>
		<li>
			<i class="icon Hui-iconfont">&#xe6c8;</i>
			<div class="name">QQ空间</div>
			<div class="code">&amp;#xe6c8;</div>
			<div class="fontclass">.Hui-iconfont-share-qzone</div>
		</li>
		<li>
			<i class="icon Hui-iconfont">&#xe6da;</i>
			<div class="name">微博</div>
			<div class="code">&amp;#xe6da;</div>
			<div class="fontclass">.Hui-iconfont-share-weibo</div>
		</li>
			<li> <i class="icon Hui-iconfont">&#xe689;</i>
			<div class="name">知乎</div>
			<div class="code">&amp;#xe689;</div>
			<div class="fontclass">.Hui-iconfont-share-zhihu</div>
		</li>
		<li>
			<i class="icon Hui-iconfont">&#xe715;</i>
			<div class="name">更多</div>
			<div class="code">&amp;#xe715;</div>
			<div class="fontclass">.Hui-iconfont-gengduo</div>
		</li>
		<li>
        	<i class="icon Hui-iconfont">&#xe716;</i>
            <div class="name">更多</div>
            <div class="code">&amp;#xe716;</div>
            <div class="fontclass">.Hui-iconfont-gengduo2</div>
        </li>
		<li>
        	<i class="icon Hui-iconfont">&#xe6f9;</i>
            <div class="name">更多</div>
            <div class="code">&amp;#xe6f9;</div>
            <div class="fontclass">.Hui-iconfont-engduo3</div>
        </li>
         <li>
        	<i class="icon Hui-iconfont">&#xe717;</i>
            <div class="name">更多</div>
            <div class="code">&amp;#xe717;</div>
            <div class="fontclass">.Hui-iconfont-gengduo4</div>
        </li>
		<li> <i class="icon Hui-iconfont">&#xe649;</i>
			<div class="name">喜欢</div>
			<div class="code">&amp;#xe649;</div>
			<div class="fontclass">.Hui-iconfont-like</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe648;</i>
			<div class="name">喜欢</div>
			<div class="code">&amp;#xe648;</div>
			<div class="fontclass">.Hui-iconfont-like2</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe680;</i>
			<div class="name">已关注</div>
			<div class="code">&amp;#xe680;</div>
			<div class="fontclass">.Hui-iconfont-yiguanzhu</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe622;</i>
			<div class="name">评论</div>
			<div class="code">&amp;#xe622;</div>
			<div class="fontclass">.Hui-iconfont-comment</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe686;</i>
			<div class="name">累计评价</div>
			<div class="code">&amp;#xe686;</div>
			<div class="fontclass">.Hui-iconfont-leijipingjia</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe68a;</i>
			<div class="name">消息</div>
			<div class="code">&amp;#xe68a;</div>
			<div class="fontclass">.Hui-iconfont-xiaoxi</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe61b;</i>
			<div class="name">收藏</div>
			<div class="code">&amp;#xe61b;</div>
			<div class="fontclass">.Hui-iconfont-cang</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe630;</i>
			<div class="name">收藏-选中</div>
			<div class="code">&amp;#xe630;</div>
			<div class="fontclass">.Hui-iconfont-cang-selected</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe69e;</i>
			<div class="name">收藏</div>
			<div class="code">&amp;#xe69e;</div>
			<div class="fontclass">.Hui-iconfont-cang2</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe69d;</i>
			<div class="name">收藏-选中</div>
			<div class="code">&amp;#xe69d;</div>
			<div class="fontclass">.Hui-iconfont-cang2-selected</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe68b;</i>
			<div class="name">关注-更多操作</div>
			<div class="code">&amp;#xe68b;</div>
			<div class="fontclass">.Hui-iconfont-more</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe66d;</i>
			<div class="name">赞扬</div>
			<div class="code">&amp;#xe66d;</div>
			<div class="fontclass">.Hui-iconfont-zan</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe66e;</i>
			<div class="name">批评</div>
			<div class="code">&amp;#xe66e;</div>
			<div class="fontclass">.Hui-iconfont-cai</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe697;</i>
			<div class="name">点赞</div>
			<div class="code">&amp;#xe697;</div>
			<div class="fontclass">.Hui-iconfont-zan2</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe62f;</i>
			<div class="name">通知</div>
			<div class="code">&amp;#xe62f;</div>
			<div class="fontclass">.Hui-iconfont-msg</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe63b;</i>
			<div class="name">消息管理</div>
			<div class="code">&amp;#xe63b;</div>
			<div class="fontclass">.Hui-iconfont-email</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6a9;</i>
			<div class="name">已关注店铺</div>
			<div class="code">&amp;#xe6a9;</div>
			<div class="fontclass">.Hui-iconfont-yiguanzhu1</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6ab;</i>
			<div class="name">转发</div>
			<div class="code">&amp;#xe6ab;</div>
			<div class="fontclass">.Hui-iconfont-zhuanfa</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6b3;</i>
			<div class="name">待评价</div>
			<div class="code">&amp;#xe6b3;</div>
			<div class="fontclass">.Hui-iconfont-daipingjia</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6b5;</i>
			<div class="name">积分</div>
			<div class="code">&amp;#xe6b5;</div>
			<div class="fontclass">.Hui-iconfont-jifen</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6c5;</i>
			<div class="name">消息</div>
			<div class="code">&amp;#xe6c5;</div>
			<div class="fontclass">.Hui-iconfont-xiaoxi1</div>
		</li>
		<li>
        	<i class="icon Hui-iconfont">&#xe70b;</i>
            <div class="name">已读</div>
            <div class="code">&amp;#xe70b;</div>
            <div class="fontclass">.Hui-iconfont-read</div>
        </li>
    
        <li>
        	<i class="icon Hui-iconfont">&#xe70c;</i>
            <div class="name">用户反馈</div>
            <div class="code">&amp;#xe70c;</div>
            <div class="fontclass">.Hui-iconfont-feedback1</div>
        </li>
		<li> <i class="icon Hui-iconfont">&#xe6ce;</i>
			<div class="name">订阅</div>
			<div class="code">&amp;#xe6ce;</div>
			<div class="fontclass">.Hui-iconfont-dingyue</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6cd;</i>
			<div class="name">提示</div>
			<div class="code">&amp;#xe6cd;</div>
			<div class="fontclass">.Hui-iconfont-tishi</div>
		</li>
		<li>
			<i class="icon Hui-iconfont">&#xe702;</i>
            <div class="name">star-o</div>
            <div class="code">&amp;#xe702;</div>
            <div class="fontclass">.Hui-iconfont-star-o</div>
        </li>
		<li>
			<i class="icon Hui-iconfont">&#xe6ff;</i>
            <div class="name">star</div>
            <div class="code">&amp;#xe6ff;</div>
            <div class="fontclass">.Hui-iconfont-star</div>
        </li>
        <li>
			<i class="icon Hui-iconfont">&#xe700;</i>
            <div class="name">star-half</div>
            <div class="code">&amp;#xe700;</div>
            <div class="fontclass">.Hui-iconfont-star-half</div>
        </li>
        <li>
			<i class="icon Hui-iconfont">&#xe701;</i>
            <div class="name">star-half-empty</div>
            <div class="code">&amp;#xe701;</div>
            <div class="fontclass">.Hui-iconfont-star-halfempty</div>
        </li>
        <li>
        	<i class="icon Hui-iconfont">&#xe70a;</i>
            <div class="name">我的评价</div>
            <div class="code">&amp;#xe70a;</div>
            <div class="fontclass">.Hui-iconfont-comment1</div>
        </li>
        <li> <i class="icon Hui-iconfont">&#xe669;</i>
			<div class="name">物流</div>
			<div class="code">&amp;#xe669;</div>
			<div class="fontclass">.Hui-iconfont-wuliu</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe66a;</i>
			<div class="name">店铺</div>
			<div class="code">&amp;#xe66a;</div>
			<div class="fontclass">.Hui-iconfont-dianpu</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe670;</i>
			<div class="name">购物车</div>
			<div class="code">&amp;#xe670;</div>
			<div class="fontclass">.Hui-iconfont-cart2-selected</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe672;</i>
			<div class="name">购物车满</div>
			<div class="code">&amp;#xe672;</div>
			<div class="fontclass">.Hui-iconfont-cart2-man</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe673;</i>
			<div class="name">购物车空</div>
			<div class="code">&amp;#xe673;</div>
			<div class="fontclass">.Hui-iconfont-card2-kong</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6b8;</i>
			<div class="name">购物车-选中</div>
			<div class="code">&amp;#xe6b8;</div>
			<div class="fontclass">.Hui-iconfont-cart-selected</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6b9;</i>
			<div class="name">购物车</div>
			<div class="code">&amp;#xe6b9;</div>
			<div class="fontclass">.Hui-iconfont-cart-kong</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6ba;</i>
			<div class="name">降价</div>
			<div class="code">&amp;#xe6ba;</div>
			<div class="fontclass">.Hui-iconfont-jiangjia</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe628;</i>
			<div class="name">信用卡还款</div>
			<div class="code">&amp;#xe628;</div>
			<div class="fontclass">.Hui-iconfont-bank</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6bb;</i>
			<div class="name">礼物</div>
			<div class="code">&amp;#xe6bb;</div>
			<div class="fontclass">.Hui-iconfont-liwu</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6b6;</i>
			<div class="name">优惠券</div>
			<div class="code">&amp;#xe6b6;</div>
			<div class="fontclass">.Hui-iconfont-youhuiquan</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6b7;</i>
			<div class="name">红包</div>
			<div class="code">&amp;#xe6b7;</div>
			<div class="fontclass">.Hui-iconfont-hongbao</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6ca;</i>
			<div class="name">优惠券</div>
			<div class="code">&amp;#xe6ca;</div>
			<div class="fontclass">.Hui-iconfont-hongbao2</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe63a;</i>
			<div class="name">资金</div>
			<div class="code">&amp;#xe63a;</div>
			<div class="fontclass">.Hui-iconfont-money</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe620;</i>
			<div class="name">商品</div>
			<div class="code">&amp;#xe620;</div>
			<div class="fontclass">.Hui-iconfont-goods</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe621;</i>
			<div class="name">数据统计</div>
			<div class="code">&amp;#xe621;</div>
			<div class="fontclass">.Hui-iconfont-tongji-bing</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe635;</i>
			<div class="name">统计管理</div>
			<div class="code">&amp;#xe635;</div>
			<div class="fontclass">.Hui-iconfont-ad</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe61e;</i>
			<div class="name">数据统计</div>
			<div class="code">&amp;#xe61e;</div>
			<div class="fontclass">.Hui-iconfont-shujutongji</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe61a;</i>
			<div class="name">统计</div>
			<div class="code">&amp;#xe61a;</div>
			<div class="fontclass">.Hui-iconfont-tongji</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe618;</i>
			<div class="name">柱状统计</div>
			<div class="code">&amp;#xe618;</div>
			<div class="fontclass">.Hui-iconfont-tongji-zhu</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe61c;</i>
			<div class="name">线状统计</div>
			<div class="code">&amp;#xe61c;</div>
			<div class="fontclass">.Hui-iconfont-tongji-xian</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6cf;</i>
			<div class="name">排行榜</div>
			<div class="code">&amp;#xe6cf;</div>
			<div class="fontclass">.Hui-iconfont-paixingbang</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6c7;</i>
			<div class="name">电话</div>
			<div class="code">&amp;#xe6c7;</div>
			<div class="fontclass">.Hui-iconfont-tel</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6a3;</i>
			<div class="name">电话</div>
			<div class="code">&amp;#xe6a3;</div>
			<div class="fontclass">.Hui-iconfont-tel2</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe696;</i>
			<div class="name">iphone手机</div>
			<div class="code">&amp;#xe696;</div>
			<div class="fontclass">.Hui-iconfont-phone</div>
		</li>
		<li>
        	<i class="icon Hui-iconfont">&#xe708;</i>
            <div class="name">安卓手机</div>
            <div class="code">&amp;#xe708;</div>
            <div class="fontclass">.Hui-iconfont-phone-android</div>
        </li>
		<li> <i class="icon Hui-iconfont">&#xe64c;</i>
			<div class="name">平板电脑</div>
			<div class="code">&amp;#xe64c;</div>
			<div class="fontclass">.Hui-iconfont-pad</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe64f;</i>
			<div class="name">PC</div>
			<div class="code">&amp;#xe64f;</div>
			<div class="fontclass">.Hui-iconfont-xianshiqi</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe650;</i>
			<div class="name">照相机</div>
			<div class="code">&amp;#xe650;</div>
			<div class="fontclass">.Hui-iconfont-zhaoxiangji</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe651;</i>
			<div class="name">单反相机</div>
			<div class="code">&amp;#xe651;</div>
			<div class="fontclass">.Hui-iconfont-danfanxiangji</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe652;</i>
			<div class="name">打印机</div>
			<div class="code">&amp;#xe652;</div>
			<div class="fontclass">.Hui-iconfont-dayinji</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe64d;</i>
			<div class="name">轮胎</div>
			<div class="code">&amp;#xe64d;</div>
			<div class="fontclass">.Hui-iconfont-lunzi</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe654;</i>
			<div class="name">插件</div>
			<div class="code">&amp;#xe654;</div>
			<div class="fontclass">.Hui-iconfont-chajian</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe655;</i>
			<div class="name">节日</div>
			<div class="code">&amp;#xe655;</div>
			<div class="fontclass">.Hui-iconfont-jieri</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe675;</i>
			<div class="name">排序</div>
			<div class="code">&amp;#xe675;</div>
			<div class="fontclass">.Hui-iconfont-paixu</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe624;</i>
			<div class="name">匿名</div>
			<div class="code">&amp;#xe624;</div>
			<div class="fontclass">.Hui-iconfont-niming</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe62a;</i>
			<div class="name">换肤</div>
			<div class="code">&amp;#xe62a;</div>
			<div class="fontclass">.Hui-iconfont-pifu</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6cb;</i>
			<div class="name">二维码</div>
			<div class="code">&amp;#xe6cb;</div>
			<div class="fontclass">.Hui-iconfont-2code</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe682;</i>
			<div class="name">扫一扫</div>
			<div class="code">&amp;#xe682;</div>
			<div class="fontclass">.Hui-iconfont-saoyisao</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe683;</i>
			<div class="name">搜索</div>
			<div class="code">&amp;#xe683;</div>
			<div class="fontclass">.Hui-iconfont-search</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe68c;</i>
			<div class="name">中图模式</div>
			<div class="code">&amp;#xe68c;</div>
			<div class="fontclass">.Hui-iconfont-zhongtumoshi</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe68d;</i>
			<div class="name">大图模式</div>
			<div class="code">&amp;#xe68d;</div>
			<div class="fontclass">.Hui-iconfont-datumoshi</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6be;</i>
			<div class="name">大图模式</div>
			<div class="code">&amp;#xe6be;</div>
			<div class="fontclass">.Hui-iconfont-bigpic</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6c0;</i>
			<div class="name">中图模式</div>
			<div class="code">&amp;#xe6c0;</div>
			<div class="fontclass">.Hui-iconfont-middle</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6bf;</i>
			<div class="name">列表模式</div>
			<div class="code">&amp;#xe6bf;</div>
			<div class="fontclass">.Hui-iconfont-list</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe690;</i>
			<div class="name">时间</div>
			<div class="code">&amp;#xe690;</div>
			<div class="fontclass">.Hui-iconfont-shijian</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe69c;</i>
			<div class="name">更多</div>
			<div class="code">&amp;#xe69c;</div>
			<div class="fontclass">.Hui-iconfont-more2</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe629;</i>
			<div class="name">SIM卡</div>
			<div class="code">&amp;#xe629;</div>
			<div class="fontclass">.Hui-iconfont-sim</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6c1;</i>
			<div class="name">火热</div>
			<div class="code">&amp;#xe6c1;</div>
			<div class="fontclass">.Hui-iconfont-hot</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6c2;</i>
			<div class="name">拍摄</div>
			<div class="code">&amp;#xe6c2;</div>
			<div class="fontclass">.Hui-iconfont-paishe</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6c3;</i>
			<div class="name">热销</div>
			<div class="code">&amp;#xe6c3;</div>
			<div class="fontclass">.Hui-iconfont-hot1</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6c4;</i>
			<div class="name">上新</div>
			<div class="code">&amp;#xe6c4;</div>
			<div class="fontclass">.Hui-iconfont-new</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6c6;</i>
			<div class="name">产品参数</div>
			<div class="code">&amp;#xe6c6;</div>
			<div class="fontclass">.Hui-iconfont-canshu</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6c9;</i>
			<div class="name">定位</div>
			<div class="code">&amp;#xe6c9;</div>
			<div class="fontclass">.Hui-iconfont-dingwei</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe671;</i>
			<div class="name">定位</div>
			<div class="code">&amp;#xe671;</div>
			<div class="fontclass">.Hui-iconfont-weizhi</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe69f;</i>
			<div class="name">HTML</div>
			<div class="code">&amp;#xe69f;</div>
			<div class="fontclass">.Hui-iconfont-html</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6a0;</i>
			<div class="name">CSS</div>
			<div class="code">&amp;#xe6a0;</div>
			<div class="fontclass">.Hui-iconfont-css</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe64a;</i>
			<div class="name">苹果</div>
			<div class="code">&amp;#xe64a;</div>
			<div class="fontclass">.Hui-iconfont-apple</div>
		</li>
		<li> <i class="icon Hui-iconfont">&#xe6a2;</i>
			<div class="name">android</div>
			<div class="code">&amp;#xe6a2;</div>
			<div class="fontclass">.Hui-iconfont-android</div>
		</li>
	</ul>
</div>
<script>
$(document).ready(function() {
	
	 $("ul li").find('div').each(function() {
		 if($(this).attr("class")!="name"){
			 $(this).hide();
		 }
	 });
	
	
    $("ul li").click(function(){
		var divContent = '';
		$(this).find('div').each(function() {
			if($(this).attr("class")=="code"){
				divContent = $(this).text();
			 }
		});
		
		$("#classId",window.parent.document).val(divContent);
		
		var index = parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
	})
});
</script>
</body>
</html>
