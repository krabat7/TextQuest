<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Text Quest - Добро пожаловать</title>
    <link rel="stylesheet" type="text/css" href="style/style.css">
    <style>
        p, h1{
            text-indent: 20px;
        }
        form {
            margin-left: 20px;
        }
    </style>
</head>
<body>
<h1> Добро пожаловать в Text Quest!</h1>
<p>
    Давным-давно, в мистическом мире, полном загадок и опасностей, вы оказались в самом центре приключений.
    Вас ждут неизведанные локации, таинственные события и важные решения.
</p>
<p> Вам предстоит пройти через пустоши, леса, пещеры и водопады, столкнуться с неожиданными опасностями и найти путь к победе.</p>
<p> Подготовьтесь к увлекательному текстовому квесту, где каждое ваше решение влияет на развитие сюжета!</p>
<p>
    Начните свое приключение, и помните, что каждый выбор может быть решающим. Удачи!
</p>
<form action="/start" method="get">
    <label for="name">Введите ваше имя: </label>
    <input type="text" id="name" name="name" required>
    <button type="submit" class="button">Начать приключение</button>
</form>
</body>
</html>
