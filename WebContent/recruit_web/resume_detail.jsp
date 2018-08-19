<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf8">
<title>简历编辑——公众号招聘</title>
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">

<link href="assets/css/base.css" rel="stylesheet">
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/base.js"></script>
<script src="assets/js/jweixin-1.2.0.js"></script>
<script>
	$(function() {
		alert(window.location.href);
		dosomething();
	});
	/**
	 * 发送sendSignAjax
	 */
	function dosomething() {
		alert("你好");
	}
</script>
</head>

<body>

	<div class="header">
		<a class="btn-left"><i class="ico-back"></i></a>
		<h3 class="title">我的简历</h3>
		<a class="btn-right" href="javascript:;">保存</a>
	</div>
	<div class="content">
		<div class="resume-edit">
			<div class="uhead">
				<div class="img">
					<img src="assets/images/uhead.jpg">
				</div>
				<div class="name">张子欣</div>
			</div>
			<div class="formarea">
				<div class="frow">
					<label>联系方式：</label>
					<div class="det">13254869945</div>
				</div>
				<div class="frow">
					<label>学历：</label>
					<div class="det">本科</div>
				</div>
				<div class="frow">
					<label>毕业院校：</label>
					<div class="det">华中科技大学</div>
				</div>
				<div class="frow">
					<label>工作经验：</label>
					<div class="det">3年</div>
				</div>
			</div>
			<h4 class="title">项目经验</h4>
			<div class="edit-con">
				项目一：首届COCO桌面手机主题设计 2014/2--2014/4<br /> <br />
				项目描述：此次项目以“溢彩万象”为设计主题，设计出一款以相机镜头为原型适合广大摄影爱好者的手机主题桌面，希望在摄影的道路上可以给你创作灵感的帮助。<br />
				<br /> 项目二：“绿时光”闹钟APP 2014/3--2014/4<br /> <br />
				项目描述：这是一款健康工具类型的APP，帮助用户改善不良生活作息习惯，解决夜间来电影响睡眠质量和未关机状态下手机辐射对人身体健康的不良影响而设计的一款产品。<br />
				<br /> 主要职能：产品定位、用户目标分析、功能点梳理、交互原型、视觉设计、产品包装。<br /> <br />
				项目三：”爱奇艺”电视剧手机用户端APP 2014/4--2014/5<br /> <br />
				项目描述：“爱奇艺”网站的电视剧分类在移动端的移植。该项目专门为喜欢看电视剧、追电视剧的一族量身开发设计的。<br /> <br />
				主要职能：网站信息架构整理、交互原型、视觉设计、整体包装。<br /> 项目四: 奶爸计划 2014/3—2014.4

				项目描述：团队合作发开的一款专门给准备生孩子和孕期奶爸专用的知识类ios系统手机应用app，产品为奶爸们提供合理健康的安排计划让孕育出一个健康的宝宝。

				开发过程：产品定位、用户建模、用户目标分析、竞品分析、功能点梳理、交互原型、视觉设计、演示产品。

				项目角色：参与整个项目团队讨论，负责市场调研，用户分析和竞品分析，功能构架和思维导图的构建。
			</div>
		</div>
	</div>

	<script type="text/javascript">
		
	</script>
</body>
</html>
