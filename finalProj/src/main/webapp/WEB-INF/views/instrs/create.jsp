<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<!-- 
요청URI : /instrs/createPost
요청파라미터 : {name속성=값,..}
요청방식 : post
 -->
<script type="text/javascript">
	//전역변수(경력사항 카운터)
	let cntCrerQlfc = 0;
	//전역변수(보유자격 카운터)
	let cntCotnLic = 0;
	$(function() {	
		//보유자격 마지막 요소를 삭제 시작///////////////////////////////
		$("#minusCotnLic").on("click",function(){
			
			if(cntCotnLic<1){
				alert("보유자격 한 개는 있어야 합니다.");
				return;
			}
			
			$("#clsCotnLic").children().last().remove();
			cntCotnLic--;
		});
		//보유자격 마지막 요소를 삭제 시작///////////////////////////////
		
		//보유자격 추가 시작///////////////////////////////
		$("#plusCotnLic").on("click",function(){
			cntCotnLic++;
			let strCotnLic = "<div class='card card-secondary'><div class='card-header'><h3 class='card-title'>보유자격</h3>";
				strCotnLic += "<div class='card-tools'><button type='button' class='btn btn-tool' data-card-widget='collapse' title='Collapse'>";
				strCotnLic += "<i class='fas fa-minus'></i></button></div></div>";
				strCotnLic += "<div class='card-body'><div class='form-group'><label for='inputEstimatedBudget'>보유자격증</label>";
				strCotnLic += "<input type='text' name='empVO.instrsVO.instrsWorkPflVOList[0].cotnQuaVOList["+cntCotnLic+"].cotnLic' id='cotnLic' class='form-control' placeholder='번호를 입력해주세요' />";
				strCotnLic += "</div></div></div>";
			
			$("#clsCotnLic").append(strCotnLic);
		});
		//보유자격 추가 끝///////////////////////////////
		
		//경력사항 마지막 요소 삭제 시작/////////////////////////////
		$("#minusCrerQlfc").on("click",function(){
			//.last() : 요소의 마지막 노드 반환
			//.remove() : 지정한 요소 포함, 하위 요소 모두 제거
			if(cntCrerQlfc<1){
				alert("경력사항 한 개는 있어야 합니다.");
				return;
			}
			$("#clsCrerQlfc").children().last().remove();
			cntCrerQlfc--;
		});
		//경력사항 마지막 요소 삭제 끝/////////////////////////////
		
		//경력사항 추가 시작 //////////////////////
		$("#plusCrerQlfc").on("click",function(){
			cntCrerQlfc++;
			let strCrerQlfc = "<div class='card card-primary'><div class='card-header'><h3 class='card-title'>경력사항</h3>";
				strCrerQlfc += "<div class='card-tools'><button type='button' class='btn btn-tool' data-card-widget='collapse' title='Collapse'>";
				strCrerQlfc += "<i class='fas fa-minus'></i></button></div></div>";
				strCrerQlfc += "<div class='card-body'><div class='form-group'><label for='crerStDt'>경력 시작일</label>"; 
				strCrerQlfc += "<input type='date' name='empVO.instrsVO.instrsWorkPflVOList[0].crerQlfcVOList["+cntCrerQlfc+"].crerStDt' class='form-control crerStDt'>~";
				strCrerQlfc += "<label for='crerEdDt'>경력 종료일</label>";
				strCrerQlfc += "<input type='date' name='empVO.instrsVO.instrsWorkPflVOList[0].crerQlfcVOList["+cntCrerQlfc+"].crerEdDt' class='form-control crerEdDt'>";
				strCrerQlfc += "</div><div class='form-group'><label for='crerCont'>경력내용</label>";
				strCrerQlfc += "<textarea name='empVO.instrsVO.instrsWorkPflVOList[0].crerQlfcVOList["+cntCrerQlfc+"].crerCont' class='form-control crerCont' rows='4'></textarea></div><div class='form-group'><label for='crer'>경력구분</label>"; 
				strCrerQlfc += "<select name='empVO.instrsVO.instrsWorkPflVOList[0].crerQlfcVOList["+cntCrerQlfc+"].crer' class='form-control custom-select crer'>";
				strCrerQlfc += "<option value='CRE01001'>프로젝트</option><option value='CRE01002' selected>강의</option></select></div></div></div>";
			
			$("#clsCrerQlfc").append(strCrerQlfc);
		});
		//경력사항 추가 끝 //////////////////////
		
		//이미지 미리보기 시작 //////////////////////
		$("#uploadFile").on("change", fileSelected);

		//e : onchange 이벤트 객체
		function fileSelected(e) {
			let files = e.target.files;
			//이미지 오브젝트 배열
			let fileArr = Array.prototype.slice.call(files);

			//fileArr : 파일들 -> f : 파일
			fileArr.forEach(function(f) {
				if (!f.type.match("image.*")) {
					alert("이미지 확장자만 가능합니다.");
					return;
				}

				let reader = new FileReader();
				//e : 리더가 이미지 읽을 때 이벤트
				reader.onload = function(e) {
					$("#atchFileId").attr("src", e.target.result);
				}
				reader.readAsDataURL(f);
			});
		}
		//이미지 미리보기 끝 //////////////////////
	});
</script>
<form name="frm"
	action="/instrs/createPost?${_csrf.parameterName}=${_csrf.token}"
	method="post" enctype="multipart/form-data">
	<div class="row">
		<div class="col-md-3">

			<div class="card card-primary card-outline">
				<div class="card-body box-profile">
					<div class="text-center">
						<img class="profile-user-img img-fluid img-circle"
							src="/resources/adminlte/dist/img/user4-128x128.jpg"
							alt="User profile picture" id="atchFileId" />
						<div class="custom-file">
							<input type="file" class="custom-file-input" name="uploadFile"
								id="uploadFile" /> <label class="custom-file-label"
								for="uploadFile">프로필</label>
						</div>
					</div>
					<h3 class="profile-username text-center">
						<input id="kornFlnm" name="kornFlnm"
							class="form-control form-control-sm" type="text"
							required="required" placeholder="한글성명을 입력해주세요" />
					</h3>
					<p class="text-muted text-center">
					<div class="form-group">
						<div class="form-check">
							<input class="form-check-input" type="radio" name="entRelorDiv"
								id="entRelorDiv1" value="ENT01001" /> <label
								class="form-check-label" for="entRelorDiv1">개인고객</label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="entRelorDiv"
								id="entRelorDiv2" value="ENT01002" checked /> <label
								class="form-check-label" for="entRelorDiv2">직원</label>
						</div>
					</div>
					</p>
					<ul class="list-group list-group-unbordered mb-3">
						<li class="list-group-item"><b>회원번호</b> <a
							class="float-right"> <input id="mbrNo" name="mbrNo"
								class="form-control form-control-sm" type="number"
								placeholder="회원번호" style="width: 100px;" />
						</a></li>
						<li class="list-group-item"><b>현직무구분</b> <a
							class="float-right"> <select name="empVO.curJobDiv"
								id="curJobDiv" class="form-control form-control-sm">
									<option value="CUR01001" selected="selected">강사</option>
									<option value="CUR01002">관리직원</option>
							</select>
						</a></li>
						<li class="list-group-item"><b>현근무센터번호</b> <a
							class="float-right"> <input id="curWorkCtrNo"
								name="empVO.curWorkCtrNo" class="form-control form-control-sm"
								type="number" placeholder="번호" style="width: 60px;" />
						</a></li>
						<li class="list-group-item"><b>구성원구분</b> <a
							class="float-right"> <input id="memsDiv"
								name="empVO.instrsVO.memsDiv"
								class="form-control form-control-sm" type="text"
								placeholder="구성원구분" style="width: 100px;" />
						</a></li>
					</ul>
					<button type="submit" class="btn btn-primary btn-block">
						<b>강사등록</b>
					</button>
				</div>

			</div>


			<div class="card card-primary">
				<div class="card-header">
					<h3 class="card-title">About Me</h3>
				</div>

				<div class="card-body">
					<strong><i class="fas fa-book mr-1"></i> Education</strong>
					<p class="text-muted">B.S. in Computer Science from the
						University of Tennessee at Knoxville</p>
					<hr>
					<strong><i class="fas fa-map-marker-alt mr-1"></i>
						Location</strong>
					<p class="text-muted">Malibu, California</p>
					<hr>
					<strong><i class="fas fa-pencil-alt mr-1"></i> Skills</strong>
					<p class="text-muted">
						<span class="tag tag-danger">UI Design</span> <span
							class="tag tag-success">Coding</span> <span class="tag tag-info">Javascript</span>
						<span class="tag tag-warning">PHP</span> <span
							class="tag tag-primary">Node.js</span>
					</p>
					<hr>
					<strong><i class="far fa-file-alt mr-1"></i> Notes</strong>
					<p class="text-muted">Lorem ipsum dolor sit amet, consectetur
						adipiscing elit. Etiam fermentum enim neque.</p>
				</div>

			</div>

		</div>

		<div class="col-md-9">
			<div class="card">
				<div class="card-header p-2">
					<ul class="nav nav-pills">
						<li class="nav-item"><a class="nav-link active"
							href="#settings" data-toggle="tab">강사프로필</a></li>
					</ul>
				</div>
				<div class="card-body">
					<div class="tab-content">
						<!-- //////////////// 강사프로필 시작 ////////////////// -->
						<div class="tab-pane active" id="settings">
							<form class="form-horizontal">
								<section class="content">
									<div class="row">
										<!-- ///////경력사항 시작//////// -->
										<div class="col-md-6" id="clsCrerQlfc">
											<button type="button" id="plusCrerQlfc" class="btn btn-default">
												<i class="fa fa-plus"></i>
											</button>
											<button type="button" id="minusCrerQlfc" class="btn btn-default">
												<i class="fa fa-minus"></i>
											</button>
											<div class="card card-primary">
												<div class="card-header">
													<h3 class="card-title">경력사항</h3>
													<div class="card-tools">
														<button type="button" class="btn btn-tool"
															data-card-widget="collapse" title="Collapse">
															<i class="fas fa-minus"></i>
														</button>
													</div>
												</div>
												<div class="card-body">
													<div class="form-group">
														<label for="crerStDt">경력 시작일</label> 
														<input type="date" name="empVO.instrsVO.instrsWorkPflVOList[0].crerQlfcVOList[0].crerStDt" class="form-control crerStDt">~
														<label for="crerEdDt">경력 종료일</label> 
														<input type="date" name="empVO.instrsVO.instrsWorkPflVOList[0].crerQlfcVOList[0].crerEdDt" class="form-control crerEdDt">
													</div>
													<div class="form-group">
														<label for="crerCont">경력내용</label>
														<textarea name="empVO.instrsVO.instrsWorkPflVOList[0].crerQlfcVOList[0].crerCont" class="form-control crerCont"
															rows="4"></textarea>
													</div>
													<div class="form-group">
														<label for="crer">경력구분</label> 
														<select name="empVO.instrsVO.instrsWorkPflVOList[0].crerQlfcVOList[0].crer" class="form-control custom-select crer">
															<c:forEach var="comDetCodeInfoVO" items="${comDetCodeInfoVOList}">
																<c:if test="${comDetCodeInfoVO.comCode=='CRE01'}">
																<option value="${comDetCodeInfoVO.comDetCode}"
																	<c:if test="${comDetCodeInfoVO.comDetCode=='CRE01002'}">selected</c:if>
																>${comDetCodeInfoVO.comDetCodeNm}</option>
																</c:if>
															</c:forEach>
														</select>
													</div>
												</div>
											</div>
										</div>
										<!-- ///////경력사항 끝//////// -->
										<!-- ///////보유자격 시작//////// -->
										<div class="col-md-6" id="clsCotnLic">
											<button type="button" id="plusCotnLic" class="btn btn-default">
												<i class="fa fa-plus"></i>
											</button>
											<button type="button" id="minusCotnLic" class="btn btn-default">
												<i class="fa fa-minus"></i>
											</button>
											<div class="card card-secondary">
												<div class="card-header">
													<h3 class="card-title">보유자격</h3>
													<div class="card-tools">
														<button type="button" class="btn btn-tool"
															data-card-widget="collapse" title="Collapse">
															<i class="fas fa-minus"></i>
														</button>
													</div>
												</div>
												<div class="card-body">
													<div class="form-group">
														<label for="inputEstimatedBudget">보유자격증</label>
														<input type="text" name="empVO.instrsVO.instrsWorkPflVOList[0].cotnQuaVOList[0].cotnLic" id="cotnLic"
															class="form-control" placeholder="번호를 입력해주세요" />
													</div>
												</div>
											</div>
										</div>
										<!-- ///////보유자격 끝//////// -->
									</div>
									<div class="row">
										<div class="col-12">
											<a href="#" class="btn btn-secondary">Cancel</a> <input
												type="submit" value="Create new Project"
												class="btn btn-success float-right">
										</div>
									</div>
								</section>
							</form>
						</div>
						<!-- //////////////// 강사프로필 끝 ////////////////// -->
					</div>

				</div>
			</div>
		</div>
	</div>
	<sec:csrfInput />
</form>