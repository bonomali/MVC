<p>Заказ оформлен! Вам придет письмо на почту!</p>
<a href="index.html">На Главную</a>
<a href="admin.php">Админ панель</a>

<?php
    require('config.php');

    //Открываем соединение с БД
    $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . CHARSET;
    $opt = [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
    ];
    $pdo = new PDO($dsn, DB_USER, DB_PASS, $opt);

    if(isset($_POST['submit']))
    {
        // проверяем, не сущестует ли пользователя с таким email
        $stmt = $pdo->prepare("SELECT COUNT(id) FROM users WHERE email = :email");
        $stmt->execute(array('email' => $_POST['email']));
        $row  = $stmt->fetch();
        if($row['COUNT(id)'] > 0)
        {
            echo "<script>alert('Вы авторизированы!')</script>";
        } else {
            //Сохранение данных в users
            $stmt = $pdo->prepare("INSERT INTO users (email, name, phone) VALUES (?, ?, ?)");
            $stmt->execute(array($_POST['email'],$_POST['name'],$_POST['phone']));
            
            echo "<script>alert('Вы зарегистрированы!')</script>";
        }
        
        //Получение id пользователя
        $stmt = $pdo->prepare("SELECT id FROM users WHERE email = :email");
        $stmt->execute(array('email' => $_POST['email']));
        $user = $stmt->fetch();
        
        //Пишем адресс в строку
        $adress ='ул.' . $_POST['street'].' д.'.$_POST['home'].' корп.'.$_POST['part'].' этаж '.$_POST['floor'].' кв.'.$_POST['appt'];
        $callback = isset($_POST['callback']);

        //Добавляем заказ в БД
        $stmt = $pdo->prepare("INSERT INTO orders (adress, comment, payment, callback, user_id) VALUES (?, ?, ?, ?, ?)");
        $stmt->execute(array($adress, $_POST['comment'], $_POST['payment'], $callback, $user['id']));
        $orderId = $pdo->lastInsertId();//получаем id заказа

        //Считаем количество заказов
        $stmt = $pdo->prepare("SELECT COUNT(id) FROM orders WHERE user_id = ?");
        $stmt->execute(array($user['id']));
        $orderCount  = $stmt->fetch();

        //Пишем письмо
        $thanks = $orderCount['COUNT(id)'] > 1 ? "Это уже ваш {$orderCount['COUNT(id)']} заказ!" : "Это ваш первый заказ!";
        $payment = $_POST['payment'] = 'cash' ? 'Оплата наличными' : 'Оплата картой';
        $callbackStr = $callback ? 'Вам перезвонят' : 'Без обратного звонка';
        $header = 'Заказ №' . $orderId;
        $message = <<<MAIL
Заказ будет доставлен по адресу: $adress.
$payment.
$callbackStr.
Ваш заказ: 
DarkBeefBurger 500 рублей, 1 шт.

Итого: 500 руб.

Спасибо! $thanks 
MAIL;
        mail($_POST['email'], $header, $message);
    }

    //Закрываем соединение с БД
    $pdo = null;
    $stmt = null;
?>