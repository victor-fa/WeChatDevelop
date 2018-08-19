<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basepath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("path", path);
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basepath%>recruit_web/">
<base src="<%=basepath%>recruit_web/">
<meta charset="utf8">
<title>公众号招聘</title>
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">

<link href="assets/css/swiper.min.css" rel="stylesheet">
<link href="assets/css/base.css" rel="stylesheet">
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/swiper.min.js"></script>
<script src="assets/js/base.js"></script>
<script src="assets/js/jweixin-1.2.0.js"></script>
<script>
	// 使用 $(function(){}) 相当于 onload="某个方法"
	/**$(function(){
	 // 这里写你要执行的代码吧
	 })**/
	$(function() {
		alert(window.location.href);
		sendSignAjax();
	});
	/**
	 * 发送sendSignAjax
	 */
	function sendSignAjax() {
		//	alert("你好");
		var aj = $
				.ajax({
					url : "sign.html",// 跳转到 action  
					data : {
						"url" : window.location.href
					},
					type : 'post',//提交方式 
					cache : false,
					dataType : 'json',
					async : true,
					success : function(data) {
						//			var last=data.toJSONString(); //将JSON对象转化为JSON字符
						alert("成功:" + data.signature);

						wx.config({
							debug : true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
							appId : data.appId, // 必填，公众号的唯一标识
							timestamp : data.timestamp, // 必填，生成签名的时间戳
							nonceStr : data.nonceStr, // 必填，生成签名的随机串
							signature : data.signature,// 必填，签名，见附录1
							jsApiList : [ 'checkJsApi', 'openLocation',
									'getLocation', 'onMenuShareTimeline',
									'onMenuShareAppMessage' ]  // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
						});
						wx.ready(function() {
									/***wx.checkJsApi({
									    jsApiList: [
									        'getLocation',
									        'onMenuShareTimeline',
									        'onMenuShareAppMessage'
									    ],
									    success: function (res) {
									        alert(JSON.stringify(res));
									    }
									});**/

									wx.onMenuShareTimeline({
												title : '微信分享', // 分享标题
												link : "http://www.cnblogs.com/txw1958/p/weixin-development-best-practice.html", // 分享链接
												imgUrl : "http://images.cnitblog.com/i/340216/201404/301756448922305.jpg", // 分享图标
												success : function() {
													// 用户确认分享后执行的回调函数
													alert("分享成功");
												},
												cancel : function() {
													// 用户取消分享后执行的回调函数
													alert("分享取消");
												}
											});
								});
					},
					error : function(data) {
						// view("异常！");  
						alert("错误:" + data);
					}
				});
	}

	function callOnMenuShareTimeline() {
		wx.onMenuShareTimeline({
					title : '微信分享', // 分享标题
					link : "http://www.cnblogs.com/txw1958/p/weixin-development-best-practice.html", // 分享链接
					imgUrl : "http://images.cnitblog.com/i/340216/201404/301756448922305.jpg", // 分享图标
					success : function() {
						// 用户确认分享后执行的回调函数
						alert("分享成功");
					},
					cancel : function() {
						// 用户取消分享后执行的回调函数
						alert("分享取消");
					}
				});
	}
</script>


</head>

<body>
	<div class="header">
		<a class="btn-left" id="city"><i class="ico-posi"></i></a>
		<h3 class="title">
			<div class="top-search">
				<input class="txt" type="text" placeholder="输入职位或公司名"> <input
					class="btn" type="submit" value="">
			</div>
		</h3>
		<a class="btn-right" href="javascript:;" id="topuser"><i
			class="ico-user"></i></a>
		<div class="top-menu">
			<ul>
				<li><a href="javascript:;">${nickname}</a></li>
				<li class="divider"></li>
				<li><a href="resume_detail.jsp"><i class="ico-resume"></i><span>我的简历</span></a></li>
				<li><a href="#"><i class="ico-exit"></i><span>退出</span></a></li>
			</ul>
		</div>
	</div>
	<div class="content">
		<div class="swiper-container index-slider">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<img src="assets/images/banner.jpg">
				</div>
				<div class="swiper-slide">
					<img src="assets/images/banner.jpg">
				</div>
				<div class="swiper-slide">
					<img src="assets/images/banner.jpg">
				</div>
			</div>
			<!-- Add Pagination -->
			<div class="swiper-pagination"></div>
		</div>
		<div class="menu-list clearfix">
			<a class="item" href="#"><i class="ico-menu ico-menu-1"></i><span>UI设计</span></a>
			<a class="item" href="#"><i class="ico-menu ico-menu-2"></i><span>PHP</span></a>
			<a class="item" href="#"><i class="ico-menu ico-menu-3"></i><span>JAVA</span></a>
			<a class="item" href="#"><i class="ico-menu ico-menu-4"></i><span>IOS</span></a>
			<a class="item" href="#"><i class="ico-menu ico-menu-5"></i><span>架构师</span></a>
			<a class="item" href="#"><i class="ico-menu ico-menu-6"></i><span>安卓</span></a>
			<a class="item" href="#"><i class="ico-menu ico-menu-7"></i><span>产品</span></a>
			<a class="item" href="#"><i class="ico-menu ico-menu-8"></i><span>UED</span></a>
			<a class="item" href="#"><i class="ico-menu ico-menu-9"></i><span>运营</span></a>
		</div>
		<div class="line-divider"></div>
		<div class="layout">
			<h3 class="m-title">操作信息</h3>
			<div class="list zp-list">
				<a class="item" href="企业注册.jsp"> <span class="tit">企业注册</span> <span
					class="txt">XXOOXXOOXXOO</span>
				</a> <a class="item" href="身份激活.jsp"> <span class="tit">身份激活</span>
					<span class="txt">XXOOXXOOXXOO</span>
				</a> <a class="item" href="新建职位.jsp"> <span class="tit">新建职位</span>
					<span class="txt">XXOOXXOOXXOO</span>
				</a> <a class="item" href="job_list.jsp"> <span class="tit">职位列表</span>
					<span class="txt">XXOOXXOOXXOO</span>
				</a> <a class="item" href="job_detail.jsp"> <span class="tit">职位详情</span>
					<span class="txt">XXOOXXOOXXOO</span>
				</a>
			</div>
		</div>
		<div class="line-divider"></div>
		<div class="layout">
			<h3 class="m-title">招聘信息</h3>
			<div class="list zp-list">
				<a class="item"> <span class="tit">UI设计师</span> <span
					class="txt">武汉市美约极客教育机构</span>
				</a> <a class="item"> <span class="tit">UI设计师</span> <span
					class="txt">武汉市美约极客教育机构</span>
				</a> <a class="item"> <span class="tit">UI设计师</span> <span
					class="txt">武汉市美约极客教育机构</span>
				</a> <a class="item"> <span class="tit">UI设计师</span> <span
					class="txt">武汉市美约极客教育机构</span>
				</a> <a class="item"> <span class="tit">UI设计师</span> <span
					class="txt">武汉市美约极客教育机构</span>
				</a> <a class="item"> <span class="tit">UI设计师</span> <span
					class="txt">武汉市美约极客教育机构</span>
				</a> <a class="item"> <span class="tit">UI设计师</span> <span
					class="txt">武汉市美约极客教育机构</span>
				</a> <a class="item"> <span class="tit">UI设计师</span> <span
					class="txt">武汉市美约极客教育机构</span>
				</a> <a class="item"> <span class="tit">UI设计师</span> <span
					class="txt">武汉市美约极客教育机构</span>
				</a>
			</div>
		</div>
	</div>

	<!-- 返回顶部 -->
	<a href="javascript:" target="_parent" class="gotop"></a>

	<script type="text/javascript" src="assets/js/city-select.js"></script>
	<script type="text/javascript">
		//loading.show();
		setTimeout(function() {
			//loading.hide();
		}, 2000)

		var swiper = new Swiper('.index-slider', {
			pagination : '.swiper-pagination',
			autoplay : 3000,
			paginationClickable : true,
			onInit : function(swiper) {
				$('.index-slider')
						.height($('.index-slider img').eq(0).height());
			}

		});

		$(function() {
			$('#city').click(function() {
				$.city().then(function(city) {
					console.log(city);
				})
			})
		})
	</script>
</body>
</html>
