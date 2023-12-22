<%@ page import="org.project.Area"%>
<%@ page import="org.project.StartServlet"%>
<%@ page session="true" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Text Quest</title>
    <link rel="stylesheet" type="text/css" href="style/style.css">
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <style>
        body {
            margin-left: 20px;
        }
    </style>
</head>
<body>

<c:set var="BADLANDS" value ="<%=Area.BADLANDS%>"/>
<c:set var="FOREST" value ="<%=Area.FOREST%>"/>
<c:set var="CAVE" value ="<%=Area.CAVE%>"/>
<c:set var="DEEPFOREST" value ="<%=Area.DEEPFOREST%>"/>
<c:set var="WATERFALL" value ="<%=Area.WATERFALL%>"/>
<c:set var="PORTAL" value ="<%=Area.PORTAL%>"/>

<c:if test="${area == BADLANDS}">
    <h1>Пустоши</h1>
    <p>Вы находитесь в бескрайних пустошах, где песчаные дюны простираются до горизонта. Сухой и жаркий ветер несет с собой зерна песка, осыпая ваше лицо.</p>
    <p>Видимо впереди Вас ждет интересное путешествия. Пройдя 5 часов по солнцепеку в наконец увидели что-то вдали.</p>
    <p>Подойдя ближе, Вы увидели вход в пещеру, а справа от нее появились верхушки елок. Похоже там лес.</p>
</c:if>

<c:if test="${area == FOREST}">
    <h1>Лес</h1>
    <p>Вы вошли в густой лес, где деревья высоки и мрачны. Рядом слышны звуки падающей воды, возможно это водопад.</p>
    <p>Странные звуки донеслись из-за деревьев, и ветви создают густые тени на земле.</p>
    <p>В воздухе пахнет свежестью и влажностью. Что же там в глубине?</p>
</c:if>

<c:if test="${area == CAVE}">
    <h1>Пещера</h1>
    <p>Вы находитесь в темной пещере, где стены кажутся влажными, а в воздухе пахнет сыростью. Яркий свет вашего фонарика освещает непонятные рисунки на стенах.
    <p>Слышится шум капающей воды из глубин пещеры. В этом темном месте вам придется быть осторожным. Какое-то насекомое пытается укусить Вас.</p>
</c:if>

<c:if test="${area == DEEPFOREST}">
    <h1>Глубокий лес</h1>
    <p>Вы оказались в глубокой чаще леса, где солнечный свет едва проникает сквозь густые ветви. Вокруг вас слышны шорохи животных, а пение птиц создает атмосферу таинственности.</p>
    <p>На земле много следов, и вы чувствуете, что вас наблюдают. Неожиданно из кустов появляется огромный медведь и, судя по рычанию, очень голодный.</p>
</c:if>

<c:if test="${area == WATERFALL}">
    <h1>Водопад</h1>
    <p>Перед вами великолепный водопад, который создает грозный шум. Вода падает с высокой скалы, образуя внизу крошащиеся брызги. </p>
    <p>Вокруг вас зеленая растительность, и влажный воздух наполняет легкость. Здесь, у водопада, вы чувствуете силу природы.</p>
</c:if>

<c:if test="${area == PORTAL}">
    <h1>Портал</h1>
    <p>Вы перед загадочным порталом. Вокруг портала ничего необычного, но на стене вы замечаете изображение ключа. Находил ли Вы что-то похожее?</p>
</c:if>


<div id="options-container">
    <form id="options-form">
        <c:if test="${health <= 0 || win == true}">
            <button type="button" class="result-button" onclick="restart()">Начать сначала</button>
        </c:if>
        <c:if test="${health > 0 && area != PORTAL}">
            <button type="button" class="button" onclick="selectOption('explore')">Исследовать</button>
            <button type="button" class="button" onclick="selectOption('searchFood')">Найти еду</button>
        </c:if>
        <c:if test="${health > 0 && area == BADLANDS}">
            <button type="button" class="button" onclick="selectOption('forest')">Идти к лесу</button>
            <button type="button" class="button" onclick="selectOption('cave')">Спуститься в пещеру</button>
        </c:if>

        <c:if test="${health > 0 && area == FOREST}">
            <button type="button" class="button" onclick="selectOption('deepForest')">Углубиться в чащу леса</button>
            <button type="button" class="button" onclick="selectOption('waterfall')">Идти к водопаду</button>
            <button type="button" class="button" onclick="selectOption('badlands')">Вернуться в пустоши</button>
        </c:if>
        <c:if test="${health > 0 && area == CAVE}">
            <button type="button" class="button" onclick="selectOption('badlands')">Вернуться в пустоши</button>
        </c:if>
        <c:if test="${health > 0 && area == DEEPFOREST}">
            <button type="button" class="button" onclick="selectOption('waterfall')">Идти к водопаду</button>
            <button type="button" class="button" onclick="selectOption('forest')">Идти к краю леса</button>
        </c:if>
        <c:if test="${health > 0 && area == WATERFALL}">
            <button type="button" class="button" onclick="selectOption('forest')">Идти к краю леса</button>
            <button type="button" class="button" onclick="selectOption('deepForest')">Идти в чащу леса</button>
            <c:if test="${portalFound == true}">
                <button  type="button" class="button" onclick="selectOption('portal')">Войти в портал</button>
            </c:if>
        </c:if>
        <c:if test="${health > 0 && area == PORTAL}">
            <button type="button" class="button" onclick="selectOption('waterfall')">Вернуться к водопаду</button>
            <c:if test="${keyFound == true}">
                <button type="button" class="button" onclick="selectOption('win')">Активировать портал</button>
            </c:if>
        </c:if>
    </form>
</div>

<div id="story-container">
    <p>Здоровье: <span class="hero-health <%= (int)session.getAttribute("health") < 30 ? "low-health" : "" %>"><%= session.getAttribute("health")%></span> </p>
    <c:if test="${keyFound == true}">
        <p>Вы нашли таинственный ключ. Неизвестно, что им можно открыть, но что-то очень ценное.</p>
    </c:if>
    <c:if test="${toolFound == true}">
        <p>Вы подобрали увесистую палку, на ней есть надпись "Made in China". Теперь есть чем отбиваться от хищников.</p>
    </c:if>
    <c:if test="${area == CAVE && toolFound == false}">
        <p>Вас поранили летучие мыши.</p>
    </c:if>
    <c:if test="${area == CAVE && toolFound == true}">
        <p>От летучих мышей удалось отбиться палкой.</p>
    </c:if>
    <c:if test="${area == DEEPFOREST && toolFound == false}">
        <p>Почуяв легкую добычу, медведь нападает и сильно ранит Вас. Вы истекаете кровью, но убегаете от медведя.</p>
    </c:if>
    <c:if test="${area == DEEPFOREST && toolFound == true}">
        <p>Медведь пробует напасть, но вы отбиваетесь палкой, получая несколько сильных царапин.</p>
    </c:if>
    <c:if test="${area == PORTAL && toolFound == true}">
        <p>Вы нашли вход в портал. Он светится разным цветами.</p>
    </c:if>
    <c:if test="${area == PORTAL && toolFound == false}">
        <p>Вы не знаете, что с ним делать, портал не светится. На стене нарисован какой-то ключ, но вы его никогда не видели. Может он спрятан в другом месте.</p>
    </c:if>
    <c:if test="${health <= 0}">
        <p class="lose-text" style="color: #dc3545;">К сожалению, вы умерли. Ваш труп никогда не найдут.</p>
    </c:if>
    <c:if test="${win == true}">
        <p class="win-text" style="color: #28a745;">Поздравляем! Это победа. Вы нашли выход и переместились к себе домой в уютную кровать.</p>
    </c:if>

    <br><br>
    <p style="font-weight: normal; font-style: italic;"><i>Игр сыграно: <%= org.project.StartServlet.gamesPlayed %></i></p>
    <p style="font-weight: normal; font-style: italic;"><i>Имя игрока: <%= session.getAttribute("userName") %></i></p>
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

    function selectOption(action) {
        $.ajax({
            url: 'start',
            type: 'POST',
            data: { action: action },
            success: function () {
                location.reload();
            }
        });
    }
</script>
</body>
</html>
