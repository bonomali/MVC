-- phpMyAdmin SQL Dump
-- version 4.4.15.7
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1:3306
-- Время создания: Авг 09 2017 г., 02:26
-- Версия сервера: 5.5.50
-- Версия PHP: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `burgers`
--

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL,
  `adress` varchar(128) NOT NULL,
  `comment` text,
  `payment` varchar(16) DEFAULT 'in cash',
  `callback` tinyint(1) NOT NULL DEFAULT '1',
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`id`, `adress`, `comment`, `payment`, `callback`, `user_id`) VALUES
(1, 'улица Волгоградская дом 4 квартира 34 1 1 3 2', 'dasfsdg', 'cash', 1, 1),
(2, 'улица Волгоградская дом 4 квартира 34 1 1 3 2', 'dasfsdg', 'cash', 1, 1),
(3, 'улица Волгоградская дом 4 квартира 34 123 123 123 123', 'adsfdsf', 'cash', 1, 1),
(4, 'улица Волгоградская дом 4 квартира 34 123 123 123 123', 'adsfdsf', 'cash', 1, 2),
(5, 'ул.Волгоградская д.42 корп.1 2 этаж кв.34', 'с соком', 'cash', 1, 1),
(6, 'ул.улица Волгоградская дом 4 квартира 34 д.234 корп.324 этаж 34 кв.234', '234', 'no_cash', 1, 1),
(7, 'ул.улица Волгоградская дом 4 квартира 34 д.12 корп.3 этаж 13 кв.12', '123', 'cash', 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL,
  `email` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `phone` varchar(32) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `email`, `name`, `phone`) VALUES
(1, 'maizbest@gmail.com', 'Степанов Максим', '+7 (851) 402 27 52'),
(2, 'maizbest@yandex.ru', 'Степанов Максим', '+7 (851) 402 27 52');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
