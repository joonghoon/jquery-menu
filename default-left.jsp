<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

	$(document).ready(function() {
		
		left.init();
		
	});
	
	var left = {
			
		//  left init()
		init : function() {
			
			//  메뉴정보 호출
			left.menuGetData();
		},
		
		
		//  메뉴정보 호출
		menuGetData : function() {
		
			var url = "/menuSearch.do"
			var data = {};
			data.userNm = "userNm";
			data.userId = "userId";
			
			if( !isNull(url) ) {
				
				ajaxInit(url, data, left.menuSet);	
			}
		},
		
		
		//  메뉴정보 html depth append
		menuSet : function( data ) {
			
			//  불러온 메뉴정보 반복
			$.each( data, function( index, value ) {
				
				var that = value;
				
				//  1depth 메인메뉴인 경우 1,2,3,4,5 단일로 끝나는 메인메뉴(1depth)
			    if( that.menuLevel == 1 ) {
			    	
					//  메인메뉴에 해당하는 태그 동적생성
			        $("#menuSet").append(   "<li class='has-sub "+ that.menuId +"depth'>" +
												"<a href='#' onclick='left.menu_1depth( "+that.menuUrl+" )'>" +
													"<span class='badge pull-right'></span>" +
													"<i class='fa fa-laptop'></i>" +
													"<span>" + that.menuNm + "</span>" +
												"</a>" +
											"</li>");
					
			    //  2depth 서브메뉴 1_1, 2_1, 3_1 같은 유형의 메뉴들 ex) 1 > 1_1, 1_2, 1_3    
			    } else if( that.menuLevel == 2 ) {
			    	
			        var setNum = that.menuId.split("_")[1];
					
			        //  첫 번째 서브메뉴 일 경우 ul 태그 생성
			        if( setNum == "1" ) {

						var tagId = "#menuSet ." + that.menuBe + "depth";

			            $(tagId).append(  "<ul class = 'sub-menu'>" +
					                          "<li>" +
												"<a href='#' onclick='left.menu_2depth( "+ that.menuUrl + " )' >" + that.menuNm + "</a>" +
					                          "</li>" +
                                          "</ul>"
			            );
			            
					//  해당 메뉴정보가 첫 번째가 아닐 경우 기존에 생성 된 ul태그 하위에 동적태그 생성
			        } else if( setNum != "1" ) { 

						var tagId = "#menuSet ." + that.menuBe + "depth .sub-menu";
						//  li태그 class active는 선택 됨
			            $(tagId).append(   "<li>" +
			            						"<a href='#' onclick='left.menu_2depth( "+ that.menuUrl + " )' >" + that.menuNm + "</a>" +
					                       "</li>");
			        }

			    } else if( that.menuLevel == 3 ) {

			    	//과제.
			        console.log("3depth : "+ that.menuId);
			    }
				
			});
		},
		
		//  1depth 클릭 시 URL정보가 있으면 해당 URL호출 ( 화면이동 )
		menu_1depth : function(data) {
			
		},
		
		menu_2depth : function(menuUrl) {
			
			$("#frm_left").attr("action", menuUrl);
			$("#frm_left").submit();
		},
		
		menu_3depth : function(menuId, menuUrl) {
			
		}
		
		/* pageSubmitFn : function(menu) {
			
			var url = $(menu).attr("id");
			
			if(url !== undefined && url !='') {
				$("#pageName").val(url);
				$("#frm_left").attr("action", url + ".do");
				$("#frm_left").submit();
			}
		} */
	}
	
</script>
    
<form id="frm_left" name="frm_left">

</form>

<div id="sidebar" class="sidebar">
	<!-- begin sidebar scrollbar -->
	<div data-scrollbar="true" data-height="100%">
		<!-- begin sidebar user -->
		<ul class="nav">
			<li class="nav-profile">
				<div class="info">
					MuHan
					<small>초급 스터디 자료</small>
				</div>
			</li>
		</ul>
		
		<ul class="nav" id="menuSet">
			<!-- <li class="nav-header">Navigation</li>
			<li class="has-sub 1 active">
				<a href="javascript:;">
				    <b class="caret pull-right"></b>
				    <i class="fa fa-laptop"></i>
				    <span>1주차</span>
			    </a>
				<ul class="sub-menu">
				    <li class="active">
				    	<a href="#" id="jqgridP2" onclick="javascript:left.pageSubmitFn(this)">시작해봅시다</a>
				    </li>
				    <li>
				    	<a href="#" id="jqGridMenu_v2" onclick="javascript:left.pageSubmitFn(this)">jqGrid</a>
				    </li>
				</ul>
			</li>
			<li class="has-sub">
				<a href="#" id="login" onclick="javascript:left.pageSubmitFn(this)">
					<span class="badge pull-right"></span>
					<i class="fa fa-laptop"></i>
				    <span>로그인</span>
				</a>
				<ul class="sub-menu">			//중메뉴
				   <li class="active">
				    	<a href="#" id="signIn" onclick="javascript:left.pageSubmitFn(this)">Sign in</a>
				    </li>
				    <li>
				    	<a href="#" id="signUp" onclick="javascript:left.pageSubmitFn(this)">Sign up</a>
				    </li>
				</ul>
			</li>
			<li class="has-sub">
				<a href="#" id="schedule" onclick="javascript:left.pageSubmitFn(this)">
					<span class="badge pull-right"></span>
					<i class="fa fa-th"></i>
				    <span>일정관리</span>
				</a>			
			</li>
			
			<li class="has-sub">
				<a href="javascript:;">
					<span class="caret pull-right"></span>
					<i class="fa fa-file-o"></i>
				    <span>세미나 내용</span>
				</a>
				 <ul class="sub-menu">		
				   <li class="active">
				    	<a href="#" id="chkbox" onclick="javascript:left.pageSubmitFn(this)">check box</a>
				    </li>
				    <li>
				    	<a href="#" id="fileupload" onclick="javascript:left.pageSubmitFn(this)">file upload</a>
				    </li>
				</ul>
			</li>			
			<li class="has-sub">
				<a href="javascript:;">
					<span class="caret pull-right"></span>
					<i class="fa fa-file-o"></i>
				    <span>멤버별 게시판</span>
				</a>
				 <ul class="sub-menu">			
				   <li class="active">
				    	<a href="#" id="dal" onclick="javascript:left.pageSubmitFn(this)">김달주</a>
				    </li>
				    <li>
				    	<a href="#" id="sun" onclick="javascript:left.pageSubmitFn(this)">김선호</a>
				    </li>
				    <li>
				    	<a href="#" id="soo" onclick="javascript:left.pageSubmitFn(this)">장수경</a>
				    </li>
				    <li>
				    	<a href="#" id="jung" onclick="javascript:left.pageSubmitFn(this)">조중훈</a>
				    </li>
				    <li>
				    	<a href="#" id="jong" onclick="javascript:left.pageSubmitFn(this)">표종덕</a>
				    </li>
				</ul> 
			</li>
			
			<li class="has-sub">
				<a href="#" id="compare" onclick="javascript:left.pageSubmitFn(this)">
					<span class="badge pull-right"></span>
					<i class="fa fa-laptop"></i>
				    <span>Compare</span>
				</a>			
			</li>
			
			<li class="has-sub">
				<a href="javascript:;">
				    <b class="caret pull-right"></b>
				    <i class="fa fa-suitcase"></i>
				    <span>UI Elements</span> 
				</a>
				<ul class="sub-menu">
					<li><a href="ui_general.html">General</a></li>
					<li><a href="ui_typography.html">Typography</a></li>
					<li><a href="ui_tabs_accordions.html">Tabs & Accordions</a></li>
					<li><a href="ui_unlimited_tabs.html">Unlimited Nav Tabs</a></li>
					<li><a href="ui_modal_notification.html">Modal & Notification</a></li>
					<li><a href="ui_widget_boxes.html">Widget Boxes</a></li>
					<li><a href="ui_media_object.html">Media Object</a></li>
					<li><a href="ui_buttons.html">Buttons</a></li>
					<li><a href="ui_icons.html">Icons</a></li>
					<li><a href="ui_simple_line_icons.html">Simple Line Icons</a></li>
					<li><a href="ui_ionicons.html">Ionicons</a></li>
					<li><a href="ui_tree.html">Tree View</a></li>
					<li><a href="ui_language_bar_icon.html">Language Bar & Icon</a></li>
				</ul>
			</li>
	        begin sidebar minify button
			<li><a href="javascript:;" class="sidebar-minify-btn" data-click="sidebar-minify"><i class="fa fa-angle-double-left"></i></a></li>
	        end sidebar minify button -->
		</ul>
		<!-- end sidebar nav -->
	</div>
	<!-- end sidebar scrollbar -->
</div>

<div class="sidebar-bg"></div>
