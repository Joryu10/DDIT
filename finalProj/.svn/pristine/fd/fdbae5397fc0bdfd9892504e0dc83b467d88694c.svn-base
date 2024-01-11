<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en" class>
<head>
	<script src="/resources/sbadmin/vendor/jquery/jquery.min.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/sbadmin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/sbadmin/css/sb-admin-2.min.css" rel="stylesheet">
	<!-- sweetalert2 -->
	<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
</head>

<body id="page-top" class="sidebar-mini sidebar-closed sidebar-collapse">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar /// aside.jsp 시작 ///// -->
        <tiles:insertAttribute name="aside" />
        <!-- End of Sidebar  /// aside.jsp 끝 /////-->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar ///// header.jsp 시작 /////// -->
                <tiles:insertAttribute name="header" />
                <!-- End of Topbar /////header.jsp 끝///// -->

                <!-- Begin Page Content -->
                <div class="container-fluid">
					<tiles:insertAttribute name="body" />
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer /// footer.jsp 시작 ///// -->
            <tiles:insertAttribute name="footer" />
            <!-- End of Footer /// footer.jsp 끝 /////-->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">로그아웃 버튼을 클릭하면 로그아웃 됩니다.</div>
                <div class="modal-footer">
                	<form action="/logout" method="post">
	                    <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>                    
	                    <button type="submit" class="btn btn-primary">로그아웃</button>
	                    <sec:csrfInput />
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Default Modal-->
    <div class="modal fade" id="defaultModal" tabindex="-1" role="dialog" aria-labelledby="defaultModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="defaultModalLabel">Modal</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" id="defaultModalBody"></div>
                <div class="modal-footer" id="defaultModalFooter">
	                <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>                    
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/sbadmin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/sbadmin/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/sbadmin/js/sb-admin-2.min.js"></script>

	<!-- sweetalert2 -->
	<script type="text/javascript" src="/resources/js/sweetalert2.min.js"></script>

	<!-- ionicons -->
	<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
	<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>

</html>