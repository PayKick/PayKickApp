<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>

<head>

    <!-- Meta -->
    <meta charset="utf-8">

    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Manage Users</title>

    <jsp:include page="common/styles.jsp"></jsp:include>

</head>

<body>
<jsp:include page="common/navigation.jsp"></jsp:include>

<!-- Main Content -->
<main class="valign-wrapper grey lighten-3">

    <div class="container valign" style="margin-top: 20px;">
        <h4 class="center-align">Users:</h4>
        <br>
        <div class="row">
            <div class="col s12 l6 offset-l3">
                <ul class="tabs transparent">
                    <c:choose>

                        <c:when test="${type == 'CLIENT'}">
                            <li class="tab col s4 l2"><a href="users?type=ALL&page=1" target="_self">ALL</a></li>
                            <li class="tab col s4 l2"><a class="active" href="" target="_self">CLIENTS</a></li>
                            <li class="tab col s4 l2"><a href="users?type=BOOKMAKER&page=1"
                                                         target="_self">BOOKMAKERS</a></li>
                        </c:when>
                        <c:when test="${type == 'BOOKMAKER'}">
                            <li class="tab col s4 l2"><a href="users?type=ALL&page=1" target="_self">ALL</a></li>
                            <li class="tab col s4 l2"><a href="users?type=CLIENT&page=1" target="_self">CLIENTS</a></li>
                            <li class="tab col s4 l2"><a class="active" href="" target="_self">BOOKMAKERS</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="tab col s4 l2"><a class="active" href="" target="_self">ALL</a></li>
                            <li class="tab col s4 l2"><a href="users?type=CLIENT&page=1" target="_self">CLIENTS</a></li>
                            <li class="tab col s4 l2"><a href="users?type=BOOKMAKER&page=1"
                                                         target="_self">BOOKMAKERS</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>

        <ul class="collapsible popout" data-collapsible="expandable">
            <c:forEach var="user" items="${requestScope.users}">
                <li id="u_${user.id}">
                    <c:choose>
                        <c:when test="${user.isBanned()}">
                            <div class="collapsible-header center-align">
                                <i class="material-icons red-text">
                                    <c:choose>
                                        <c:when test="${user.role=='CLIENT'}">person_pin</c:when>
                                        <c:otherwise>perm_identity</c:otherwise>
                                    </c:choose>
                                </i><span class="red-text"><strong><c:out
                                    value="${user.login}"></c:out></strong></span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="collapsible-header center-align">
                                <i class="material-icons green-text">
                                    <c:choose>
                                        <c:when test="${user.role=='CLIENT'}">person_pin</c:when>
                                        <c:otherwise>perm_identity</c:otherwise>
                                    </c:choose>
                                </i><span class="green-text"><strong><c:out
                                    value="${user.login}"></c:out></strong></span>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <!-- Statistics Modal Structure -->
                    <div id="modal-stats" class="modal my-stats">
                        <div class="modal-content">
                            <div class="row">
                                <div class="col s12">
                                    <ul class="tabs transparent">
                                        <li class="tab col s6"><a href="#chart">Chart</a></li>
                                        <li class="tab col s6"><a href="#diagram">Diagram</a></li>
                                    </ul>
                                </div>
                                <div class="col s12">
                                    <div id="chart" style="width: 100%;"></div>
                                    <div id="diagram" style="width: 100%;"></div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="collapsible-body center-align">
                        <table class="centered responsive-table">
                            <thead>
                            <tr>
                                <th>Full Name</th>
                                <th>Sex</th>
                                <th>Age</th>
                                <th>E-Mail</th>
                                <th>Balance</th>
                                <th>Role</th>
                                <th>Banned</th>
                            </tr>
                            </thead>
                            <tbody>

                            <tr>
                                <td>
                                    <c:out value="${user.fullName}"></c:out>
                                </td>
                                <td>
                                    <c:out value="${user.gender}"></c:out>
                                </td>
                                <td>
                                    <c:out value="${user.age}"></c:out>
                                </td>
                                <td>
                                    <c:out value="${user.email}"></c:out>
                                </td>
                                <td>$
                                    <c:out value="${user.balance}"></c:out>
                                </td>
                                <td>
                                    <div class="input-field col l1">
                                        <div name="changeRole_${user.id}" action="changeUserRole">
                                            <input type="hidden" name="userId"
                                                   value="<c:out value=" ${user.id} "></c:out>"/>
                                            <select id="${user.id}">
                                                <c:choose>
                                                    <c:when test="${user.role == 'CLIENT'}">
                                                        <option value="CLIENT" selected>CLIENT</option>
                                                        <option value="BOOKMAKER">BOOKMAKER</option>
                                                        <option value="ADMIN">ADMIN</option>
                                                    </c:when>
                                                    <c:when test="${user.role == 'BOOKMAKER'}">
                                                        <option value="CLIENT">CLIENT</option>
                                                        <option value="BOOKMAKER" selected>BOOKMAKER</option>
                                                        <option value="ADMIN">ADMIN</option>
                                                    </c:when>
                                                    <c:when test="${user.role == 'ADMIN'}">
                                                        <option value="CLIENT">CLIENT</option>
                                                        <option value="BOOKMAKER">BOOKMAKER</option>
                                                        <option value="ADMIN" selected>ADMIN</option>
                                                    </c:when>
                                                </c:choose>
                                            </select>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="switch">
                                        <label id="${user.id}"> No
                                            <c:choose>
                                                <c:when test="${user.isBanned()}">
                                                    <input id="checkIt" type="checkbox" checked>
                                                </c:when>
                                                <c:otherwise>
                                                    <input id="checkIt" type="checkbox">
                                                </c:otherwise>
                                            </c:choose> <span class="lever"></span> Yes
                                        </label>
                                    </div>
                                </td>
                            </tr>

                            </tbody>
                        </table>
                        <a class="waves-effect waves-light modal-trigger btn green" href="#modal-stats">
                            <div class="button1" id="${user.id}/${user.role}"><i
                                    class="material-icons right">timeline</i>Statistics
                            </div>
                            ></a>
                        <br>
                        <br>
                    </div>
                </li>
            </c:forEach>
        </ul>

        <ul class="pagination center-align">

            <c:choose>
                <c:when test="${page <= 1}">
                    <li class="disabled"><a href="#!"><i
                            class="material-icons">chevron_left</i></a></li>
                </c:when>
                <c:otherwise>
                    <li class="material-icons"><a href="users?type=${type}&page=${page-1}&itemsOnPage=${itemsOnPage}"><i
                            class="material-icons">chevron_left</i></a></li>
                </c:otherwise>
            </c:choose>

            <c:forEach var="i" begin="1" end="${requestScope.pages}">

                <c:choose>
                    <c:when test="${i == page}">
                        <li class="active green"><a href="#!">${i}</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="waves-effect">
                            <a href="users?type=${type}&page=${i}&itemsOnPage=${itemsOnPage}">
                                <c:out value="${i}"></c:out>
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:choose>
                <c:when test="${page == pages}">
                    <li class="disabled"><a href="#!"><i
                            class="material-icons">chevron_right</i></a></li>
                </c:when>
                <c:otherwise>
                    <li class="material-icons"><a href="users?type=${type}&page=${page+1}&itemsOnPage=${itemsOnPage}"><i
                            class="material-icons">chevron_right</i></a></li>
                </c:otherwise>
            </c:choose>

        </ul>
        <br>
    </div>
</main>

<jsp:include page="common/footer.jsp"></jsp:include>
<jsp:include page="common/scripts.jsp"></jsp:include>

<script>

    $('select').on('change', function() {
        var userID = $(this).attr("id");
        var role = $(this).val();

        $.ajax({
            type: "POST",
            url: "updateUser",
            data: {
                "type": "ROLE",
                "userID":userID,
                "role":role
            },
            success: function (data) {
                var response = JSON.parse(data);

                var status = response.status;
                var message = response.message;

                if (status == 'FAIL') {
                    Materialize.toast(message,5000);
                }
            }
        });
    });

    $(".switch label").on('change',function(){
        var userID = $(this).attr("id");
        var isBanned = $("#checkIt").is(':checked');

        $.ajax({
            type: "POST",
            url: "updateUser",
            data: {
                "type": "BANN",
                "userID":userID,
                "bann":isBanned
            },
            success: function (data) {
                var response = JSON.parse(data);

                var status = response.status;
                var message = response.message;

                if (status == 'FAIL') {
                    Materialize.toast(message,5000);
                }
            }
        });
    });


//    $("li.player a").on('click', function () {
//        var removeBtnId = $(this).attr("id");
//
//        $('#' + removeBtnId).slideUp(300);
//        var values = removeBtnId.split("_");
//        var playerID = values[2];
//
//        $.ajax({
//            type: "POST",
//            url: "removePlayer",
//            data: {
//                "playerID": playerID
//            }
//        });
//
//    });
</script>

</body>

</html>