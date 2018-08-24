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
<title>stormfa测试号</title>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no">
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
	$(function() {
		sendSignAjax();
	});
	
	// 发送sendSignAjax
	function sendSignAjax() {
		var aj = $.ajax({
			url : "http://43.226.37.27/WeChatDevelop/WechatConfigServlet",
			data : {
				"url" : encodeURIComponent(location.href.split('#')[0])
			},
			// contentType : "application/x-www-form-urlencoded; charset=utf-8",
			type : 'get',//提交方式 
			dataType : 'json',
            // timeout: 15000,
			success : function(data) {
				// var last=data.toJSONString(); //将JSON对象转化为JSON字符
				// alert(JSON.stringify(data));
				wx.config({
					// debug : true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
					appId : data.appid, // 必填，公众号的唯一标识
					timestamp : data.timestamp, // 必填，生成签名的时间戳
					nonceStr : data.nonceStr, // 必填，生成签名的随机串
					signature : data.signature,// 必填，签名，见附录1
					jsApiList : [ 'checkJsApi', 'onMenuShareTimeline',
							'onMenuShareAppMessage', 'onMenuShareQQ',
							'onMenuShareWeibo', 'onMenuShareQZone',
							'hideMenuItems', 'showMenuItems',
							'hideAllNonBaseMenuItem',
							'showAllNonBaseMenuItem', 'translateVoice',
							'startRecord', 'stopRecord',
							'onVoiceRecordEnd', 'playVoice',
							'onVoicePlayEnd', 'pauseVoice',
							'stopVoice', 'uploadVoice',
							'downloadVoice', 'chooseImage',
							'previewImage', 'uploadImage',
							'downloadImage', 'getNetworkType',
							'openLocation', 'getLocation',
							'hideOptionMenu', 'showOptionMenu',
							'closeWindow', 'scanQRCode', 'chooseWXPay',
							'openProductSpecificView', 'addCard',
							'chooseCard', 'openCard' ]
							// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
				});

				wx.ready(function() {

				    // 判断当前版本是否支持指定 JS 接口，支持批量判断
				    document.querySelector('#checkJsApi').onclick = function () {
				        wx.checkJsApi({
				            jsApiList: [
				                'getNetworkType',
				                'previewImage'
				            ],
				            success: function (res) {
				                alert(JSON.stringify(res));
				            }
				        });
				    };
				    
				    // 智能接口
				    var voice = {
				        localId: '',
				        serverId: ''
				    };
				    
				    // 开始录音
				    document.querySelector('#startRecord').onclick = function () {
				        wx.startRecord({
				            cancel: function () {
				                alert('用户拒绝授权录音');
				            }
				        });
				    };

				    // 停止录音
				    document.querySelector('#stopRecord').onclick = function () {
				        wx.stopRecord({
				            success: function (res) {
				                voice.localId = res.localId;
				            },
				            fail: function (res) {
				                alert(JSON.stringify(res));
				            }
				        });
				    };

				    // 播放音频
				    document.querySelector('#playVoice').onclick = function () {
				        if (voice.localId == '') {
				            alert('请先使用 startRecord 接口录制一段声音');
				            return;
				        }
				        wx.playVoice({
				            localId: voice.localId
				        });
				    };

				    // 拍照、本地选图
				    var images = {
				        localId: [],
				        serverId: []
				    };
				    document.querySelector('#chooseImage').onclick = function () {
				        wx.chooseImage({
				            success: function (res) {
				                images.localId = res.localIds;
				                alert('已选择 ' + res.localIds.length + ' 张图片');
				            }
				        });
				    };

				    // 图片预览
				    document.querySelector('#previewImage').onclick = function () {
				        wx.previewImage({
				            current: 'https://raw.githubusercontent.com/victor-fa/Stored-Picture/master/weixin/stormfa%E5%85%AC%E4%BC%97%E5%8F%B7%E4%BA%8C%E7%BB%B4%E7%A0%81.png',
				            urls: [
				                'https://raw.githubusercontent.com/victor-fa/Stored-Picture/master/weixin/stormfa%E5%B0%8F%E7%A8%8B%E5%BA%8F%E4%BA%8C%E7%BB%B4%E7%A0%81.jpg',
				                'https://mp.weixin.qq.com/misc/getheadimg?token=812924465&fakeid=3248477798&r=493558',
				                'https://res.wx.qq.com/mpres/htmledition/weui-desktopSkin/svg/buildless/bg_logo_primary3e4a19.svg'
				            ]
				        });
				    };
				    
					// 获取当前网络状态
					document.querySelector('#getNetworkType').onclick = function() {
						wx.getNetworkType({
							success : function(res) { 
								// alert("设备信息"+res.networkType);
							},
							fail : function(res) {
								// alert("设备信息"+JSON.stringify(res));
							}
						});
					};

				    // 查看地理位置
				    document.querySelector('#openLocation').onclick = function () {
				        wx.openLocation({
				            latitude: 23.099994,
				            longitude: 113.324520,
				            name: 'TIT 创意园',
				            address: '广州市海珠区新港中路 397 号',
				            scale: 14,
				            infoUrl: 'http://weixin.qq.com'
				        });
				    };

				    // 获取当前地理位置
				    document.querySelector('#getLocation').onclick = function () {
				        wx.getLocation({
				            success: function (res) {
				                alert(JSON.stringify(res));
				            },
				            cancel: function (res) {
				                alert('用户拒绝授权获取地理位置');
				            }
				        });
				    };

					// 隐藏右上角菜单
				    document.querySelector('#hideOptionMenu').onclick = function () {
				        wx.hideOptionMenu();
				    };
				    
				    // 显示右上角菜单
				    document.querySelector('#showOptionMenu').onclick = function () {
				        wx.showOptionMenu();
				    };
				    
					// 关闭当前窗口
				    document.querySelector('#closeWindow').onclick = function () {
				        wx.closeWindow();
				    };
				    
					// 扫描二维码并执行
				    document.querySelector('#scanQRCode').onclick = function () {
				        wx.scanQRCode();
				    };
				    
					// 扫描二维码并返回结果
					document.querySelector('#getScanQRCode').onclick = function() {
						wx.scanQRCode({
							needResult: 0, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
							scanType: ["qrCode","barCode"], // 可以指定扫二维码还是一维码，默认二者都有
							success: function (res) {
								alert(res.resultStr); // 当needResult 为 1 时，扫码返回的结果
							}
						});
					};

				    // 监听“分享给朋友”，按钮点击、自定义分享内容及分享结果接口
				    document.querySelector('#onMenuShareAppMessage').onclick = function () {
				        wx.onMenuShareAppMessage({
				            title: '互联网之子',
				            desc: '在长大的过程中，我才慢慢发现，我身边的所有事，别人跟我说的所有事，那些所谓本来如此，注定如此的事，它们其实没有非得如此，事情是可以改变的。更重要的是，有些事既然错了，那就该做出改变。',
				            link: 'http://movie.douban.com/subject/25785114/',
				            imgUrl: 'http://demo.open.weixin.qq.com/jssdk/images/p2166127561.jpg',
				            trigger: function (res) {
				                // 不要尝试在trigger中使用ajax异步请求修改本次分享的内容，因为客户端分享操作是一个同步操作，这时候使用ajax的回包会还没有返回
				                alert('用户点击发送给朋友');
				            },
				            success: function (res) {
				                alert('已分享');
				            },
				            cancel: function (res) {
				                alert('已取消');
				            },
				            fail: function (res) {
				                alert(JSON.stringify(res));
				            }
				        });
				        alert('已注册获取“发送给朋友”状态事件');
				    };

				});
			},
			error : function(data) {
				alert("错误1:" + data);
			}
		});
	}

</script>
<style type="text/css"> 
body{
	-moz-user-select:none;
	-webkit-user-select:none;
	pointer-events:none;
    -webkit-pointer-events:none;
    /* -ms-pointer-events:none;
    -moz-pointer-events:none;
     touch-callout:none;
    -webkit-touch-callout:none;
    -ms-touch-callout:none;
    -moz-touch-callout:none; */
}
</style> 
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
			<a class="item" href="#" id="startRecord"><i class="ico-menu ico-menu-1"></i><span>开始录音</span></a>
			<a class="item" href="#" id="stopRecord"><i class="ico-menu ico-menu-2"></i><span>停止录音</span></a>
			<a class="item" href="#" id="playVoice"><i class="ico-menu ico-menu-3"></i><span>播放音频 </span></a>
			<a class="item" href="#"><i class="ico-menu ico-menu-4"></i><span>IOS</span></a>
			<a class="item" href="#"><i class="ico-menu ico-menu-5"></i><span>架构师</span></a>
			<a class="item" href="#"><i class="ico-menu ico-menu-6"></i><span>安卓</span></a>
			<a class="item" href="#"><i class="ico-menu ico-menu-7"></i><span>产品</span></a>
			<a class="item" href="#"><i class="ico-menu ico-menu-8"></i><span>UED</span></a>
			<a class="item" href="#" id="checkJsApi"><i class="ico-menu ico-menu-9"></i><span>运营</span></a>
		</div>
		<div class="line-divider"></div>
		<div class="layout">
			<h3 class="m-title">JSSDK信息</h3>
			<div class="list zp-list">
				<a class="item" id="chooseImage"> <span class="tit">选择相册</span> <span
					class="txt">拍照或从手机相册中选图借口</span>
				</a> <a class="item" id="previewImage"> <span class="tit">预览图片</span> <span
					class="txt">预览图片接口</span>
				</a> <a class="item" id="getNetworkType"> <span class="tit">设备信息</span> <span
					class="txt">获取网络状态接口</span>
				</a> <a class="item" id="openLocation"> <span class="tit">打开位置</span> <span
					class="txt">使用微信内置地图查看位置接口</span>
				</a> <a class="item" id="getLocation"> <span class="tit">获取位置</span> <span
					class="txt">获取地理位置接口</span>
				</a> <a class="item" id="hideOptionMenu"> <span class="tit">隐藏菜单</span> <span
					class="txt">隐藏右上角菜单接口</span>
				</a> <a class="item" id="showOptionMenu"> <span class="tit">显示菜单</span> <span
					class="txt">显示右上角菜单接口</span>
				</a> <a class="item" id="closeWindow"> <span class="tit">关闭窗口</span> <span
					class="txt">关闭当前网页窗口接口</span>
				</a> <a class="item" id="scanQRCode"> <span class="tit">扫一扫处理</span> <span
					class="txt">调起微信扫一扫接口处理信息</span>
				</a> <a class="item" id="getScanQRCode"> <span class="tit">扫一扫信息</span> <span
					class="txt">调起微信扫一扫接口获取信息</span>
				</a>
			</div>
		</div>
		<div class="line-divider"></div>
		<div class="layout">
			<h3 class="m-title">跳转 信息</h3>
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
