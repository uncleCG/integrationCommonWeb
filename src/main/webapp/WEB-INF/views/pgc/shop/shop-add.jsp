<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<script type="text/javascript" src="${ctx}/statics/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/statics/js/checkidcard.js"></script>
<!DOCTYPE HTML>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
	</head>
	<style>
	.check-box, .radio-box{padding-right:10px;}
	</style>
<body>
<div class="pd-20">
	<form action="" method="post" class="form form-horizontal" id="form-shop-save">
		<div id="tab-system">
			<div class="tabCon">
				<div class="row cl">
					<label class="form-label col-3">商户编号：</label>
					<div class="formControls col-6">
						M053215014001
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3"><span class="c-red">*</span>商户名称：</label>
					<div class="formControls col-6">
						<input type="text" id="shop_name" name="name" placeholder="请输入商户名称" value="${shopPd.name}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3" id="provinceDiv">地理区域：</label>
					<span class="select-box inline">
		 				<select id="s_province" name="province" class="select"></select>  
						<select id="s_city" name="city" class="select"></select>  
						<select id="s_county" name="district" class="select"></select>
		 			</span>
				</div>
				<div class="row cl">
					<label class="form-label col-3">商户地址：</label>
					<div class="formControls col-6">
						<input type="text" id="address" name="address" placeholder="请输入商户地址" value="${shopPd.address}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3">经度：</label>
					<div class="formControls col-6">
						<input type="text" id="longitude" name="longitude" placeholder="经度" value="${shopPd.longitude}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3">纬度：</label>
					<div class="formControls col-6">
						<input type="text" id="latitude" name="latitude" placeholder="纬度" value="${shopPd.latitude}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3">联系人：</label>
					<div class="formControls col-6">
						<input type="text" id="linkman" name="linkman" placeholder="联系人姓名" value="${shopPd.linkman}" class="input-text">
					</div>
				</div>
				<div class="row cl" id="firstLinkTel">
					<label class="form-label col-3">联系电话：</label>
					<div class="formControls col-6">
						<input type="text" name="showLinkTel" id="firstLinkTelInput" placeholder="联系电话" class="input-text" value="${shopPd.firstLinkTel}" maxlength="12"/>
					</div>
				</div>
				<c:forEach items="${shopPd.otherLinkTels}" var="otherLinkTel">
					<div class='row cl'>
						<label class='form-label col-3'></label>
						<div class='formControls col-7'>
							<div class='col-9'><input type='text' name='showLinkTel'placeholder='联系电话' class='input-text' value="${otherLinkTel}" maxlength="12"/></div>
							<div class='col-3'>
								<a class='btn btn-danger radius ml-10' onclick='removeLinkTel(this)' href='javascript:void(0)'><i class='Hui-iconfont'>&#xe609;</i></a>
							</div>
						</div>
					</div>
				</c:forEach>
				<div class="row cl" id="addTelBtn">
					<label class="form-label col-3"></label>
					<div class="formControls col-6">
						<a class="btn btn-primary radius" onclick="addLinkTel()" href="javascript:void(0);"><i class="Hui-iconfont">&#xe600;</i>添加电话</a>
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3" id="serviceTypeDiv">服务类型：</label>
					<div class="formControls col-9"><!-- 整体 -->
						<div class="col-5" style="border-right:1px solid #333;margin-left:10px;"><!-- 左边 -->
							<div class="col-12"><!-- 单个循环 -->
								<c:forEach items="${oneServiceTypeList}" var="tmpOneServiceType" varStatus="indexId">
									<c:if test="${indexId.index != 0 && (indexId.index + 1) % 2 != 0}"><br/></c:if>
									<c:if test="${(indexId.index + 1) % 2 != 0}">
										<p class="pt-10 clear"><strong>${tmpOneServiceType.name}</strong><input type="checkbox" name="oneServiceType" id="checkbox${tmpOneServiceType.id}" value="${tmpOneServiceType.id}" style="display: none;" <c:forEach items="${shopPd.oneServiceTypeIds}" var="oneServiceTypeId"><c:if test="${oneServiceTypeId==tmpOneServiceType.id}">checked="checked"</c:if></c:forEach>></p>
										<div id="div${tmpOneServiceType.id}">
											<c:forEach items="${twoServiceTypeMap}" var="tmpTwoServiceTypeMap">
												<c:if test="${tmpTwoServiceTypeMap.key == tmpOneServiceType.id}">
													<c:forEach items="${tmpTwoServiceTypeMap.value}" var="tmpTwoServiceType">
														<div class="formControls col-4 skin-minimal">
															<div class="check-box">
																<input type="checkbox" id="checkbox${tmpOneServiceType.id}-${tmpTwoServiceType.id}"  name="twoServiceType" value="${tmpTwoServiceType.id}" onclick="checkOneServiceType(this,${tmpOneServiceType.id},'${tmpTwoServiceType.name}')" <c:forEach items="${shopPd.twoServiceTypeIds}" var="twoServiceTypeId"><c:if test="${twoServiceTypeId==tmpTwoServiceType.id}">checked="checked"</c:if></c:forEach>>
																<label for="checkbox${tmpOneServiceType.id}-${tmpTwoServiceType.id}">${tmpTwoServiceType.name}</label>
															</div>
														</div>
													</c:forEach>
												</c:if>
											</c:forEach>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
						<div class="col-5" style="margin-left:10px;"><!-- 右边 -->
							<div class="col-12"><!-- 单个循环 -->
								<c:forEach items="${oneServiceTypeList}" var="tmpOneServiceType" varStatus="indexId">
									<c:if test="${indexId.index != 1 && (indexId.index + 1) % 2 == 0}"><br/></c:if>
									<c:if test="${(indexId.index + 1) % 2 == 0}">
										<p class="pt-10 clear"><strong>${tmpOneServiceType.name}</strong><input type="checkbox" name="oneServiceType" id="checkbox${tmpOneServiceType.id}" value="${tmpOneServiceType.id}" style="display: none;" <c:forEach items="${shopPd.oneServiceTypeIds}" var="oneServiceTypeId"><c:if test="${oneServiceTypeId==tmpOneServiceType.id}">checked="checked"</c:if></c:forEach>></p>
										<div id="div${tmpOneServiceType.id}">
											<c:forEach items="${twoServiceTypeMap}" var="tmpTwoServiceTypeMap">
												<c:if test="${tmpTwoServiceTypeMap.key == tmpOneServiceType.id}">
													<c:forEach items="${tmpTwoServiceTypeMap.value}" var="tmpTwoServiceType">
														<div class="formControls col-4 skin-minimal">
															<div class="check-box">
																<input type="checkbox" id="checkbox${tmpOneServiceType.id}-${tmpTwoServiceType.id}"   name="twoServiceType" value="${tmpTwoServiceType.id}" onclick="checkOneServiceType(this,${tmpOneServiceType.id},'${tmpTwoServiceType.name}')" <c:forEach items="${shopPd.twoServiceTypeIds}" var="twoServiceTypeId"><c:if test="${twoServiceTypeId==tmpTwoServiceType.id}">checked="checked"</c:if></c:forEach>>
																<label for="checkbox${tmpOneServiceType.id}-${tmpTwoServiceType.id}">${tmpTwoServiceType.name}</label>
															</div>
														</div>
													</c:forEach>
												</c:if>
											</c:forEach>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3">开户名：</label>
					<div class="formControls col-9">
						<input type="text" id="bank_card_name" name="bank_card_name" placeholder="开户名" value="${shopPd.bank_card_name}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3">开户行：</label>
					<div class="formControls col-9">
						<input type="text" id="bank_name" name="bank_name" placeholder="开户行" value="${shopPd.bank_name}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3">账号：</label>
					<div class="formControls col-9">
						<input type="text" id="bank_card_code" name="bank_card_code" placeholder="账号" value="${shopPd.bank_card_code}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3">账户性质：</label>
					<div class="formControls col-9">
						<div class="radio-box">
							<input type="radio" id="bank_card_type1" name="bank_card_type" value="1" <c:if test="${shopPd.bank_card_type == 1}">checked="checked"</c:if>/>
							<label for="bank_card_type1">对公账户</label>
						</div>
						<div class="radio-box">
							<input type="radio" id="bank_card_type2" name="bank_card_type" value="2" <c:if test="${shopPd.bank_card_type == 2}">checked="checked"</c:if>/>
							<label for="bank_card_type2">对私，法定代表人</label>
						</div>
						<div class="radio-box">
							<input type="radio" id="bank_card_type3" name="bank_card_type" value="3" <c:if test="${shopPd.bank_card_type == 3}">checked="checked"</c:if>/>
							<label for="bank_card_type3">对私，非法定代表人</label>
						</div>
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3">营业执照注册名称：</label>
					<div class="formControls col-9">
						<input type="text" id="reg_name" name="reg_name" placeholder="营业执照注册名称" value="${shopPd.reg_name}" class="input-text">
					</div>
				</div>
				<!-- 营业执照开始 -->
				<div class="row cl">
					<label class="form-label col-3">营业执照照片：</label>
					<div class="formControls col-9">
						&nbsp;
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3"></label>
					<div class="formControls col-9">
						<c:if test="${empty shopPd.reg_img}">
							<img src="" width="160" height="120" id="regImg"/>
						</c:if>
						<c:if test="${!empty shopPd.reg_img}">
							<img src="${ImgPath}/atlas/statics/shopImg/${shopPd.reg_img}" width="160" height="120" id="regImg"/>
						</c:if>
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3">&nbsp;</label>
					<div class="formControls col-9">
						<button class="btn btn-primary radius mt-10" onclick="showUploadImagePage('上传营业执照','${ctx}/uploadImgController/preUploadImg?uploadPathKey=upload.shopImg','1200','700',4)" type="button">
							<div id="regImgDiv">添加图片</div>
						</button>
					</div>
				</div>
				<!-- 营业执照结束 -->
				
				<div class="row cl">
					<label class="form-label col-3">管理人：</label>
					<div class="formControls col-9 ">
						<div class="radio-box">
							<input type="radio" id="shopkeeperType1" name="shopkeeperType" value="1"/>
							<label for="shopkeeperType1">新建管理人</label>
						</div>
						<div class="radio-box">
							<input type="radio" id="shopkeeperType2" name="shopkeeperType" value="2"/>
							<label for="shopkeeperType2">关联已有管理人</label>
						</div>
					</div>
				</div>
				<!-- 新建管理人 -->
				<div class="new shopkeeperType1">
					<div class="row cl">
						<label class="form-label col-3">管理人姓名：</label>
						<div class="formControls col-9">
							<input type="text" id="shopkeeper_name" name="shopkeeper_name" placeholder="管理人姓名" value="${shopkeeperPd.name}" class="input-text">
						</div>
					</div>
					<div class="row cl">
						<label class="form-label col-3">管理人手机号：</label>
						<div class="formControls col-9">
							<input type="text" id="shopkeeper_mobile" name="shopkeeper_mobile" placeholder="管理人手机号" value="${shopkeeperPd.mobile}" class="input-text">
						</div>
					</div>
					<div class="row cl">
						<label class="form-label col-3">管理人身份证号：</label>
						<div class="formControls col-9">
							<input type="text" id="shopkeeper_idcard" name="shopkeeper_idcard" placeholder="管理人身份证号" value="${shopkeeperPd.idcard}" class="input-text">
						</div>
					</div>
					<!-- 身份证 -->
					<div class="row cl">
						<label class="form-label col-3">管理人身份证照片：</label>
						<div class="formControls col-9">
							&nbsp;
						</div>
					</div>
					<div class="row cl">
						<label class="form-label col-3" id="idcardImgLable"></label>
						<div class="formControls col-3">
							<c:choose>
								<c:when test="${shopPd.id == shopkeeperPd.shop_id && !empty shopkeeperPd.idcard_img1}">
									<img src="${ImgPath}/atlas/statics/shopImg/${shopkeeperPd.idcard_img1}" width="160" height="120" id="idcardImg1"/>
								</c:when>
								<c:otherwise>
									<img src="" width="160" height="120" id="idcardImg1"/>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="formControls col-3">
							<c:choose>
								<c:when test="${shopPd.id == shopkeeperPd.shop_id && !empty shopkeeperPd.idcard_img2}">
									<img src="${ImgPath}/atlas/statics/shopImg/${shopkeeperPd.idcard_img2}" width="160" height="120" id="idcardImg2"/>
								</c:when>
								<c:otherwise>
									<img src="" width="160" height="120" id="idcardImg2"/>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="row cl mb-10">
						<label class="form-label col-3"></label>
						<div class="formControls col-3">
							<button class="btn btn-primary radius mt-10" onclick="showUploadImagePage('上传身份证照片','${ctx}/uploadImgController/preUploadImg?uploadPathKey=upload.shopImg','1200','700',2)" type="button">
								<div id="idcardImg1Div">添加图片</div>
							</button>
						</div>
						<div class="formControls col-3">
							<button class="btn btn-primary radius mt-10" onclick="showUploadImagePage('上传身份证照片','${ctx}/uploadImgController/preUploadImg?uploadPathKey=upload.shopImg','1200','700',3)" type="button">
								<div id="idcardImg2Div">添加图片</div>
							</button>
						</div>
					</div>
					<!-- 身份证结束 -->
				</div>
				<!-- 关联已有管理人 -->
				<div class="old shopkeeperType2">
					<div class="row cl">
						<label class="form-label col-3">管理人关联：</label>
						<div class="formControls col-9">
							<input type="button" value="管理人关联" class="btn btn-primary radius" id="chooseShopkeeper" onclick="showConfirm('关联商户管理人','shopController/chooseShopkeeper','','700')"/>
						</div>
					</div>
					<div class="row cl shopkeeperShow">
						<label class="form-label col-3">管理人姓名：</label>
						<div class="formControls col-9" id="shopkeeperShowName"></div>
					</div>
					<div class="row cl shopkeeperShow">
						<label class="form-label col-3">管理人手机号：</label>
						<div class="formControls col-9" id="shopkeeperShowMobile"></div>
					</div>
					<div class="row cl shopkeeperShow">
						<label class="form-label col-3">管理人身份证号：</label>
						<div class="formControls col-9" id="shopkeeperShowIdcard"></div>
					</div>
					<div class="row cl shopkeeperShow">
						<label class="form-label col-3">管理人身份证照片：</label>
						<div class="formControls col-9" id="shopkeeperShowIdcardImg"></div>
					</div>
					<div class="row cl shopkeeperShow">
						<label class="form-label col-3">名下商户：</label>
						<div class="formControls col-9" id="shopkeeperShowOther"></div>
					</div>
				</div>
				
				
				<div class="row cl">
					<label class="form-label col-3">商户返利：</label>
					<div class="formControls col-9">
						<input type="text" id="total_rebate_percent" name="total_rebate_percent" placeholder="例：若商户合同中返点为3%则填写0.03" value="${shopPd.total_rebate_percent}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3">充值需确认到账金额：</label>
					<div class="formControls col-9">
						<input type="text" id="confirm_money" name="confirm_money" placeholder="" value="${shopPd.confirm_money}" class="input-text">
					</div>
				</div>
				<!-- 合同照片开始 -->
				<div class="row cl">
					<label class="form-label col-3">合同照片：</label>
					<div class="formControls col-9">
						&nbsp;
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3"></label>
					<div class="formControls col-9">
						<c:if test="${empty shopPd.contract_img}">
							<img src="" width="160" height="120" id="contractImg"/>
						</c:if>
						<c:if test="${!empty shopPd.contract_img}">
							<img src="${ImgPath}/atlas/statics/shopImg/${shopPd.contract_img}" width="160" height="120" id="contractImg"/>
						</c:if>
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3"></label>
					<div class="formControls col-9">
						<button class="btn btn-primary radius mt-10" onclick="showUploadImagePage('商户合同图片','${ctx}/uploadImgController/preUploadImg?uploadPathKey=upload.shopImg','1200','700',1)" type="button">
							<div id="contractImgDiv">添加图片</div>
						</button>
					</div>
				</div>
				<!-- 合同照片结束 -->
				<div class="row cl">
					<label class="form-label col-3">合同有效期：</label>
					<div class="formControls col-9">
						<input type="text" onfocus="WdatePicker()" id="contract_begin_time" class="input-text Wdate" style="width:120px;" name="contract_begin_time" value="${shopPd.contract_begin_time}">
						-
						<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'contract_begin_time\')}'})" id="contract_end_time" class="input-text Wdate" style="width:120px;" name="contract_end_time" value="${shopPd.contract_end_time}">
					</div>
				</div>
				<div class="row cl">
		 			<label class="form-label col-3">签约人：</label>
		 			<div class="formControls col-3">
		 				<c:if test="${empty shopPd.sign_daq_id}">
							<select name="signDaqId" class="select" style="min-width:100px" id="signDaqId">
							 	<option value="-1" selected="selected">请选择</option>
							 	<c:forEach items="${signDaqList}" var="signDaqPd">
							 		<option value="${signDaqPd.id}"<c:if test="${shopPd.sign_daq_id==signDaqPd.id}">selected="selected"</c:if>>${signDaqPd.name}</option>
							 	</c:forEach>
							</select>
		 				</c:if>
		 				<c:if test="${!empty shopPd.sign_daq_id}">
						 	<c:forEach items="${signDaqList}" var="signDaqPd">
						 		<c:if test="${shopPd.sign_daq_id==signDaqPd.id}">${signDaqPd.name}</c:if>
						 	</c:forEach>
		 				</c:if>
					</div>
				</div>
			</div>
		</div>
		<div class="row cl">
			<div class="col-9 col-offset-2">
				<input type="hidden" name="shopId" value="${shopPd.id}">
				<input type="hidden" id="shopkeeper_id" name="shopkeeper_id" value="${shopPd.shopkeeper_id}"/>
				<input type="hidden" id="linkTel" name="link_tel" class="textStyle" value="${shopPd.linkTel}" hidden="hidden"/>
				<input type="hidden" name="contract_img" id="contract_img">
				<input type="hidden" name="idcard_img1" id="idcard_img1">
				<input type="hidden" name="idcard_img2" id="idcard_img2">
				<input type="hidden" name="reg_img" id="reg_img">
				<input type="hidden" name="oldShopkeeperId" id="oldShopkeeperId">
				<button onclick="layer_close();" class="btn btn-default radius" type="button">&nbsp;返&nbsp;&nbsp;&nbsp;&nbsp;回&nbsp;</button>
				<button onclick="submitForm();" class="btn btn-primary radius" type="button">&nbsp;提&nbsp;&nbsp;&nbsp;&nbsp;交&nbsp;</button>
			</div>
		</div>
	</form>
</div>
<%@ include file="../../common/_footer.jsp" %>
<script type="text/javascript" src="${ctx}/statics/js/area.js"></script>
<script type="text/javascript">
	$(function(){
		$('.skin-minimal input').iCheck({
			checkboxClass: 'icheckbox-blue',
			radioClass: 'iradio-blue',
			increaseArea: '20%'
		});
		$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	
		//#初始化地址下拉列表
		_init_area();
		var province = "${shopPd.province}";
		var city = "${shopPd.city}";
		var district = "${shopPd.district}";
		if(province != ""){
			var provinces = $("#s_province").children("option");
			for(var i = 0; i < provinces.length; i++){
				if($(provinces[i]).html() == province){
					$(provinces[i]).attr("selected",true);
					$("#s_province").change();
				}
			}
			var citys = $("#s_city").children("option");
			for(var i = 0; i < citys.length; i++){
				if($(citys[i]).html() == city){
					$(citys[i]).attr("selected",true);
					$("#s_city").change();
				}
			}
			var countys = $("#s_county").children("option");
			for(var i = 0; i < countys.length; i++){
				if($(countys[i]).html() == district){
					$(countys[i]).attr("selected",true);
					$("#s_county").change();
				}
			}		
		}
	
		//页面加载后执行脚本 Begin
		if("${shopPd.contract_img}" != ''){
			$("#contractImgDiv").html("编辑图片");
		}
		if("${shopPd.reg_img}" != ''){
			$("#regImgDiv").html("编辑图片");
		}
		if("${shopkeeperPd.idcard_img1}" != ''){
			$("#idcardImg1Div").html("编辑图片");
		}
		if("${shopkeeperPd.idcard_img2}" != ''){
			$("#idcardImg2Div").html("编辑图片");
		}
		$(".shopkeeperType1").hide();
		$(".shopkeeperType2").hide();
		$(".shopkeeperShow").hide();//隐藏关联管理人信息
		
		//回显商户管理人类型
		if("${shopPd.id}"=="${shopkeeperPd.shop_id}"){//新建
			$("#shopkeeperType1").prop("checked",true).parent().addClass("checked");
			$(".shopkeeperType1").show();
		}else{//关联已有
			$("#shopkeeperType2").prop("checked",true).parent().addClass("checked");
			$(".shopkeeperType2").show();
			if("${shopPd.shopkeeper_id}" != "" && "${shopPd.shopkeeper_id}" != undefined && "${shopPd.shopkeeper_id}" != null){//已有关联管理人时才显示管理人信息
				$("#shopkeeperShowName").html("${shopkeeperPd.name}");
				$("#shopkeeperShowMobile").html("${shopkeeperPd.mobile}");
				$("#shopkeeperShowIdcard").html("${shopkeeperPd.idcard}");
				var managerIdcardImg = "";
				if("${shopkeeperPd.idcard_img1}" != null && "${shopkeeperPd.idcard_img1}" != undefined && "${shopkeeperPd.idcard_img1}" != ""){
					managerIdcardImg = managerIdcardImg + "<img src='${ImgPath}/atlas/statics/shopImg/${shopkeeperPd.idcard_img1}' style='width: 160px;height: 120px;'>";
				}
				if("${shopkeeperPd.idcard_img2}" != null && "${shopkeeperPd.idcard_img2}" != undefined && "${shopkeeperPd.idcard_img2}" != ""){
					managerIdcardImg = managerIdcardImg + "<img src='${ImgPath}/atlas/statics/shopImg/${shopkeeperPd.idcard_img2}' style='width: 160px;height: 120px;'>";
				}
				$("#shopkeeperShowIdcardImg").html(managerIdcardImg);
				$("#shopkeeperShowOther").html("${shopkeeperPd.shopNum}个&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（首次签约店铺：${shopkeeperPd.firstShopName}）");
				$(".shopkeeperShow").show();
			}
		}
		
		//绑定事件
		$("input[name='shopkeeperType']").click(function(){//商户管理人绑定类型
			if($(this).val() == 1){
				$(".shopkeeperType1").show();
				$(".shopkeeperType2").hide();
				if("${shopPd.id}" == ""){
					//新增商户
					if(chooseShopkeeperId != ''){
						$("#shopkeeper_id").val("");
						$("#shopkeeper_name").val("");
						$("#shopkeeper_mobile").val("");
						$("#shopkeeper_idcard").val("");					
					}
				}else{
					//修改商户
					if("${shopPd.id}"=="${shopkeeperPd.shop_id}"){
						//新建
						$("#shopkeeper_id").val("${shopPd.shopkeeper_id}");
						$("#shopkeeper_name").val("${shopkeeperPd.name}");
						$("#shopkeeper_mobile").val("${shopkeeperPd.mobile}");
						$("#shopkeeper_idcard").val("${shopkeeperPd.idcard}");
					}else{
						//关联
						$("#shopkeeper_id").val("");
						$("#shopkeeper_name").val("");
						$("#shopkeeper_mobile").val("");
						$("#shopkeeper_idcard").val("");					
					}
				}
			}else{
				$(".shopkeeperType1").hide();
				$(".shopkeeperType2").show();
				if(chooseShopkeeperId != ''){
					$("#shopkeeper_id").val(chooseShopkeeperId);
					$("#shopkeeper_name").val(chooseShopkeeperName);
					$("#shopkeeper_mobile").val(chooseShopkeeperMobile);
					$("#shopkeeper_idcard").val(chooseShopkeeperIdcard);
				}
			}
		});
		
		//页面加载后执行脚本 End
		
		
		var statusVal = "${success}";
		if(statusVal != "" && statusVal != undefined && statusVal != null){
			if(statusVal==1){
				layer.msg("操作成功，请回列表页刷新显示最新数据",{icon: 6,time:2000});
			}else{
				layer.msg("操作失败",{icon: 5,time:2000});
			}
		}
		
	});
	
	/*判断是否选中一级服务*/
	function checkOneServiceType(obj,parentId,name){
		if($("#div"+parentId).find("input[type='checkbox']:checked").length > 0){
			$("#checkbox"+parentId).prop("checked",true);
		}else{
			$("#checkbox"+parentId).prop("checked",false);
		}
	}

	//添加联系电话
	function addLinkTel(){
		var linkTelObjs = $("input[name='showLinkTel']");
		var linkTelReg = /^0\d{2,3}-?\d{7,8}$/;//座机正则
		var mobileReg = /^1\d{10}$/;//手机正则
		var addFlag = true;
		$.each(linkTelObjs,function(i){
			var linkTelVal = $(this).val();
			if(!linkTelReg.test(linkTelVal) && !mobileReg.test(linkTelVal)){
				addFlag = false;
				layer.alert("请填写合法的联系电话");
				return false;
			}
		});
		if(addFlag){
			var newTrHtml = "<div class='row cl'><label class='form-label col-3'></label><div class='formControls col-7'><div class='col-9'><input type='text' name='showLinkTel'placeholder='联系电话' class='input-text' maxlength='12'/></div><div class='col-3'><a class='btn btn-danger radius ml-10' onclick='removeLinkTel(this)' href='javascript:void(0)'><i class='Hui-iconfont'>&#xe609;</i></a></div></div></div>";
			$("#addTelBtn").before(newTrHtml);
		}
	}
	//移除当前添加的联系电话
	function removeLinkTel(obj){
		$(obj).parent().parent().parent().remove();
	}
	
	
	/*显示关联管理人操作框*/
	function showConfirm(title,url,w,h){
		layer_show(title,url,w,h);
	}

	var typeVal = "";//记录操作图片类型：1、合同图片；2、身份证图片1；3、身份证图片2；4、营业执照注册图片；
	/**
	 * 显示文件上传页
	 * beforeId：显示拼接html的控件id
	 */
	function showUploadImagePage(title,url,w,h,type){
		typeVal = type;
		layer_show(title,url,w,h);
	}

	/*上传图片后的回调函数*/
	function ajaxModifyImgCallBack(newImgName){
		if(typeVal != "" && typeVal != undefined && typeVal != null){
			$("#div"+typeVal).html("修改图片");
			switch (typeVal) {
			case 1:
				$("#contractImg").attr("src","${ImgPath}/atlas/statics/shopImg/"+newImgName);
				$("#contract_img").val(newImgName);
				break;
			case 2:
				$("#idcardImg1").attr("src","${ImgPath}/atlas/statics/shopImg/"+newImgName);
				$("#idcard_img1").val(newImgName);
				break;
			case 3:
				$("#idcardImg2").attr("src","${ImgPath}/atlas/statics/shopImg/"+newImgName);
				$("#idcard_img2").val(newImgName);
				break;
			case 4:
				$("#regImg").attr("src","${ImgPath}/atlas/statics/shopImg/"+newImgName);
				$("#reg_img").val(newImgName);
				break;
			default:
				break;
			}
		}
	}


	//记录上次选择的管理人id，用于关闭选择窗口后再次打开时回显使用
	var chooseShopkeeperId = "${shopPd.shopkeeper_id}";
	var chooseShopkeeperName = "${shopkeeperPd.name}";
	var chooseShopkeeperMobile = "${shopkeeperPd.mobile}";
	var chooseShopkeeperIdcard = "${shopkeeperPd.idcard}";
	/*选中商户关联管理人后回显信息的脚本*/
	function showRelateShopkeeperInfo(shopkeeperId,shopkeeperName,shopkeeperMobile,shopkeeperIdcard,shopkeeperIdcardImg1,shopkeeperIdcardImg2,shopNum,firstShopName){
		chooseShopkeeperId = shopkeeperId;
		chooseShopkeeperName = shopkeeperName;
		chooseShopkeeperMobile = shopkeeperMobile;
		chooseShopkeeperIdcard = shopkeeperIdcard;
		/*选择管理人后拼接显示管理人信息*/
		$("#shopkeeperShowName").html(shopkeeperName);
		$("#shopkeeperShowMobile").html(shopkeeperMobile);
		$("#shopkeeperShowIdcard").html(shopkeeperIdcard);
		var shopkeeperIdcardImg = "";
		if(shopkeeperIdcardImg1 != null && shopkeeperIdcardImg1 != undefined && shopkeeperIdcardImg1 != ""){
			shopkeeperIdcardImg = shopkeeperIdcardImg + "<img src='${ImgPath}/atlas/statics/shopImg/"+shopkeeperIdcardImg1+"' style='width: 160px;height: 120px;'>";
		}
		if(shopkeeperIdcardImg2 != null && shopkeeperIdcardImg2 != undefined && shopkeeperIdcardImg2 != ""){
			shopkeeperIdcardImg = shopkeeperIdcardImg + "<img src='${ImgPath}/atlas/statics/shopImg/"+shopkeeperIdcardImg2+"' style='width: 160px;height: 120px;'>";
		}
		$("#shopkeeperShowIdcardImg").html(shopkeeperIdcardImg);
		$("#shopkeeperShowOther").html(shopNum+"个&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（首次签约店铺："+firstShopName+"）");
		$(".shopkeeperShow").show();
		//为管理人隐藏域赋值
		$("#shopkeeper_id").val(shopkeeperId);
		$("#shopkeeper_name").val(shopkeeperName);
		$("#shopkeeper_mobile").val(shopkeeperMobile);
		$("#shopkeeper_idcard").val(shopkeeperIdcard);
	}
	

	var isNameOk = false;//标记商户名称是否可用
	/*校验商户名称是否可用*/
	function checkShopName(nameVal){
		$.ajax({
	        type:"POST",
	        async:false,
	        url : "${ctx}/shopController/checkShopName",
	        data :{
	        	"shopName":nameVal
	        },
	        cache : false,
	        dataType : "json",
	        beforeSend : function() {
	        },
	        success : function(data, textStatus) {
	            if(data.status == 1){//成功
	            	isNameOk = true;
	            }else{//
	            	isNameOk = false;
	            	layer.alert(nameVal + " 已存在，不能添加");
	            }
	        },
	        error : function() {
	        	isNameOk = false;
	        	layer.alert("商户名称唯一性校验失败，请稍候重试");
	        },
	        complete : function() {

	        }
	    });
	}

	/*校验新建管理人手机号唯一性*/
	var managerMobileOk = false;
	function checkManagerMobile(nowManagerMobile,managerTypeVal){
		var checkFlag = false;
	    if("${shopPd.id}" != ''){//修改
	        var oldManagerMobile = "${shopkeeperPd.mobile}";
	        if(managerTypeVal == 1 && oldManagerMobile != ""){// 修改
	            if(oldManagerMobile != nowManagerMobile){
	                checkFlag = true;
	            }
	        }
	    }else{//新增
	        if(managerTypeVal == 1 && nowManagerMobile != ""){//
	            checkFlag = true;
	        }
	    }
	    if(checkFlag){
	        $.ajax({
	            type:"POST",
	            async:false,
	            url : "${ctx}/shopController/checkShopkeeperMobile",
	            data : {
	                "nowMobile" : nowManagerMobile
	            },
	            cache : false,
	            dataType : "json",
	            beforeSend : function() {
	            },
	            success : function(data, textStatus) {
	                if(data.status == 1){//成功
	                	managerMobileOk = true;
	                }else{//
	                	managerMobileOk = false;
	                	layer.alert("管理人手机号重复，请于关联已有管理人进行添加！");
	                }
	            },
	            error : function() {
	            	managerMobileOk = false;
	            	layer.alert("管理人手机号唯一性校验失败，请稍候重试");
	            },
	            complete : function() {

	            }
	        });
	    }else{//不用校验
	    	managerMobileOk = true;
	    }
	}
	
	function submitForm(){
		//===================校验开始===================
		var name = $.trim($("#shop_name").val());
		if(name == "" || name == undefined){
			layer.alert("请填写商户名称");
			return false;
		}else{
			var oldNameVal = "${shopPd.name}";
			if(name != oldNameVal){
				checkShopName(name);
			}else{
				isNameOk = true;
			}
			if(!isNameOk){
				return false;
			}
		}
		/*
		var provinceVal = $("#s_province").val();
		var cityVal = $("#s_city").val();
		var countyVal = $("#s_county").val();
		if("省份" == provinceVal){
			layer.alert("请完善地理区域");
			return false;
		}
		if("地级市" == cityVal){
			layer.alert("请完善地理区域");
			return false;
		}
		if("市、县级市" == countyVal){
			layer.alert("请完善地理区域");
			return false;
		}
		var addressVal = $.trim($("#address").val());
		if(addressVal == ""){
			layer.alert("请完商户地址");
			return false;
		}
		var longitudeVal = $.trim($("#longitude").val()); 
		$("#longitude").val(longitudeVal);
		if(longitudeVal == ""){
			layer.alert("请完善经度信息");
			return false;
		}
		var latitudeVal = $.trim($("#latitude").val()); 
		$("#latitude").val(latitudeVal);
		if(latitudeVal == ""){
			layer.alert("请完善纬度信息");
			return false;
		}
		var service = $("input[name='twoServiceType']:checked").length;
		if(!service){
			layer.alert("请选择服务类型");
			return false;
		}
		*/
		var linkTelObjs = $("input[name='showLinkTel']");
		var linkTelReg = /^0\d{2,3}-?\d{7,8}$/;//座机正则
		var mobileReg = /^1\d{10}$/;//手机正则
		var allLinkTel = "";
		var subFlag = true;//标识否是允许提交表单
		$.each(linkTelObjs,function(i){
			var linkTelVal = $(this).val();
			if(linkTelVal != "" && !linkTelReg.test(linkTelVal) && !mobileReg.test(linkTelVal)){
				subFlag = false;
				layer.alert("请填写合法的联系电话");
				return false;
			}else{
				if(i != 0){
					allLinkTel = allLinkTel + ",";
				}
				allLinkTel = allLinkTel + linkTelVal;
			}
		});
		if(!subFlag){
			return false;
		}else{
			$("#linkTel").val(allLinkTel);
		}
		/*
		var contractBeginTime = $("#contract_begin_time").val();
		if(contractBeginTime == "" || contractBeginTime == undefined){
			layer.alert("请输入合同有效期");
			return false;
		}
		var contractEndTime = $("#contract_end_time").val();
		if(contractEndTime == "" || contractEndTime == undefined){
			layer.alert("请输入合同有效期");
			return false;
		}
		*/
		var shopkeeperTypeVal = $("input[name='shopkeeperType']:checked").val();
		if(shopkeeperTypeVal == "" || shopkeeperTypeVal == undefined){
			layer.alert("请选择管理人关联方式");
			return false;
		}
		if(shopkeeperTypeVal == 1){//新建
			var shopkeeperName = $("#shopkeeper_name").val();
			if(shopkeeperName == ""){
				layer.alert("请填写管理人姓名");
				return false;
			}
			var shopkeeperMobile = $.trim($("#shopkeeper_mobile").val());
			if(shopkeeperMobile == ""){
				layer.alert("请填写管理人手机号");
				return false;
			}
			var mobileReg = /^1\d{10}$/;
		    if (!mobileReg.test(shopkeeperMobile)) {
		    	layer.alert("请填写合法的管理人手机号");
		    	return false;
		    }else{
		    	checkManagerMobile(shopkeeperMobile,shopkeeperTypeVal);
		    	if(!managerMobileOk){
		    		return false;
		    	}
		    }
		    var shopkeeperIdcardVal = $("#shopkeeper_idcard").val();
		    var checkMsg = checkIdcard(shopkeeperIdcardVal);
		    if("ok" != checkMsg){
		    	layer.alert("请填写合法的管理人身份证号");
		    	return false;
		    }
		}else{
			//判断是否关联管理人
			var shopkeeperIdVal = $("#shopkeeper_id").val();
			if(shopkeeperIdVal == "" || shopkeeperIdVal == null || shopkeeperIdVal == undefined){
				layer.alert("请关联已有管理人");
		    	return false;
			}
		}
		/*
		var bankCardNameVal = $.trim($("#bank_card_name").val());
		if(bankCardNameVal == "" || bankCardNameVal == undefined){
			layer.alert("请输入开户名");
	    	return false;
		}
		var bankNameVal = $.trim($("#bank_name").val());
		if(bankNameVal == "" || bankNameVal == undefined){
			layer.alert("请输入开户行");
	    	return false;
		}
		var bankCardCodeVal = $.trim($("#bank_card_code").val());
		if(bankCardCodeVal == "" || bankCardCodeVal == undefined){
			layer.alert("请输入账号");
	    	return false;
		}
		var bankCardTypeVal = $("input[name='bank_card_type']:checked").val();
		if(bankCardTypeVal != 1 && bankCardTypeVal !=2 && bankCardTypeVal != 3){
			layer.alert("请选择账户性质");
	    	return false;
		}
		var regName = $.trim($("#reg_name").val());
		if(regName == "" || regName == undefined){
			layer.alert("请输入营业执照注册名称");
	    	return false;
		}
		*/
		var confirmMoneyVal = $("#confirm_money").val();
		var positiveNumReg = /^([1-9]\d*|[0]{1,1})$/;
		if(!positiveNumReg.test(confirmMoneyVal)){
		  layer.alert("请输入正确的充值需确认到账金额（非负整数）");
		  return false;
		}
		//===================校验结束===================
			
		//判断修改商户信息时，是否把管理人首家店关联为其它人（修改时、管理人首家店、管理人被改变）
		if("${shopPd.id}"!="" && "${shopPd.id}"=="${shopkeeperPd.shop_id}" && "${shopPd.shopkeeper_id}"!=$("#shopkeeper_id").val()){
			$("#oldShopkeeperId").val("${shopPd.shopkeeper_id}");	
		}
			
		var confirmVal = "";
		confirmVal = "确定提交吗？";
		
		layer.confirm(confirmVal, {
		    btn: ["确定","取消"] //按钮
		}, function(){//确定
			$.ajax({
			      type : "POST",
			      async : true,
			      url : "${ctx}/shopController/saveOrUpdateShopBase",
			      data : $("#form-shop-save").serialize(),
			      cache : false,
			      dataType : "json",
			      beforeSend : function() {
			           // Handle the beforeSend event
			      },
			      success : function(data, textStatus) {
			          if (data.status==1) {// 处理成功
			        	  layer.msg("操作成功",{icon: 6,time:2000},function(){//关闭后的操作
			        		  parent.location.reload();
				        	  //layer_close();
			        	  });
			          } else {// 处理失败
			        	  layer.msg("操作失败",{icon: 5,time:2000});
			          }
			      },
			      error : function() {
					layer.alert("请求发送失败，请稍后重试",{icon: 5});
			      },
			      complete : function() {
		
			      }
			 });
		}, function(){//取消
		});
		
	}
</script>
</body>
</html>
