<%@ page import="org.project.Area"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Text Quest</title>
  <link rel="stylesheet" type="text/css" href="WEB-INF/style.css">
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <script src="<c:url value="/WEB-INF/jquery-3.6.0.min.js"/>"></script>
</head>
<body>

<c:set var="BADLANDS" value ="<%=Area.BADLANDS%>"/>
<c:set var="FOREST" value ="<%=Area.FOREST%>"/>
<c:set var="CAVE" value ="<%=Area.CAVE%>"/>
<c:set var="DEEPFOREST" value ="<%=Area.DEEPFOREST%>"/>
<c:set var="WATERFALL" value ="<%=Area.WATERFALL%>"/>
<c:set var="PORTAL" value ="<%=Area.PORTAL%>"/>

<c:if test="${area == BADLANDS}">
  <h1>BADLANDS</h1>
</c:if>

<c:if test="${area == FOREST}">
  <h1>FOREST</h1>
</c:if>

<c:if test="${area == CAVE}">
  <h1>CAVE</h1>
</c:if>

<c:if test="${area == DEEPFOREST}">
  <h1>DEEPFOREST</h1>
</c:if>

<c:if test="${area == WATERFALL}">
  <h1>WATERFALL</h1>
</c:if>

<c:if test="${area == PORTAL}">
  <h1>PORTAL</h1>
</c:if>

<div id="options-container">
  <form id="options-form">
    <c:if test="${health <= 0 || win = true}">
      <button type="button" class="result-button" onclick="restart()">Начать сначала</button>
    </c:if>
    <c:if test="${health > 0 || area != PORTAL}">
      <button type="button" class="button" onclick="selectOption('explore')>Исследовать</button>
      <button type="button" class="button" onclick="selectOption('searchFood')">Найти еду</button>
    </c:if>
    <c:if test="${health > 0 || area == BADLANDS}">
      <button type="button" class="button" onclick="selectOption('forest')>Идти к лесу</button>
      <button type="button" class="button" onclick="selectOption('cave')">Спуститься в пещеру</button>
    </c:if>
    <c:if test="${health > 0 || area != FOREST}">
      <button type="button" class="button" onclick="selectOption('deepForest')>Углубиться в чащу леса</button>
      <button type="button" class="button" onclick="selectOption('waterfall')">Идти к водопаду</button>
      <button type="button" class="button" onclick="selectOption('badlands')">Вернуться в пустоши</button>
    </c:if>
    <c:if test="${health > 0 || area != CAVE}">
      <button type="button" class="button" onclick="selectOption('badlands')>Вернуться в пустоши</button>
    </c:if>
    <c:if test="${health > 0 || area != DEEPFOREST}">
      <button type="button" class="button" onclick="selectOption('waterfall')>Идти к водопаду</button>
      <button type="button" class="button" onclick="selectOption('forest')">Идти к краю леса</button>
    </c:if>
    <c:if test="${health > 0 || area != WATERFALL}">
      <button type="button" class="button" onclick="selectOption('forest')>Идти к водопаду</button>
      <button type="button" class="button" onclick="selectOption('deepForest')">Идти в чащу леса</button>
      <c:if test="${portalFound = true}">
        <button  type="button" class="button" onclick="selectOption('portal')">Войти в портал</button>
      </c:if>
    </c:if>
    <c:if test="${health > 0 || area == PORTAL}">
      <button type="button" class="button" onclick="selectOption('waterfall')>Вернуться к водопаду</button>
      <c:if test="${portalFound = true}">
        <button type="button" class="button" onclick="selectOption('win')">Активировать портал</button>
      </c:if>
    </c:if>
  </form>
</div>

<div id="story-container">
  <p>"Здоровье": <span class="hero-health <%= (int)session.getAttribute("health") < 30 ? "low-health" : "" %>"><%= session.getAttribute("health")%></span> </p>
  <c:if test="${keyFound == true}">
    <p>Вы нашли таинственный ключ. Неизвестно что им можно открыть, но что-то очень ценное.</p>
  </c:if>
  <c:if test="${toolFound == true}">
    <p>Вы подобрали увесистую палку, на ней есть надпись "Made in China". Теперь есть, чем отбиваться от хищников.</p>
  </c:if>
  <c:if test="${area == CAVE && totalFound = false}">
    <p>Вас поранили летучие мыши</p>
  </c:if>
  <c:if test="${area == CAVE && totalFound = true}">
    <p>От летучих мышей удалось отбиться палкой</p>
  </c:if>
  <c:if test="${area == DEEPFOREST && totalFound = false}">
    <p>Почуяв легкую добычу, медведь нападает и сильно ранит Вас. Вы истикаете кровью, но убегаете от медведя.</p>
  </c:if>
  <c:if test="${area == DEEPFOREST && totalFound = true}">
    <p>Медведь пробует напасть, но вы отбиваетесь палкой, получая несколько сильных царапин.</p>
  </c:if>
  <c:if test="${area == PORTAL && totalFound = true}">
    <p>Вы нашли вход в портал. Он светится разным цветами.</p>
  </c:if>
  <c:if test="${area == PORTAL && totalFound = false}">
    <p>Вы не знаете, что с ним делать, портал не светится. На стене нарисован какой-то ключ, но вы его никогда не видели. Может он спрятан в другом месте.</p>
  </c:if>
  <c:if test="${health <= 0}">
    <p>Вы умерли. Ваш труп никогда не найдут.</p>
  </c:if>
  <c:if test="${win = true}">
    <p>Это победа. Вы нашли выход и переместились к себе домой в уютную кровать.</p>
  </c:if>
</div>
<script>
  function restart(){
    $.ajax({
      url: '/restart',
      type: 'POST',
      async: false,
      success: function (){
        location.reload();
      }
    })
  }

  function selectOption(){
    $.ajax({
      //MOE
      url: 'index',
      type: 'POST',
      data: {action: action},
      success: function (){
        location.reload();
      }
    })
  }
</script>
</body>
</html>
