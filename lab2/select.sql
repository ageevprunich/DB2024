-- 1. Отримати дані у гарному вигляді про всі моделі електровелосипедів
SELECT bikes.bike_brand, motor.motor_power, motor.motor_volt, motor.motor_type, motor.producing_country, 
battery.battery_cappacity, battery.battery_volt, battery.bms, battery.producing_country,
controller.controller_name,controller.controller_power, controller.controller_country FROM bikes
JOIN motor ON bikes.motor_id = motor.motor_id
JOIN battery ON bikes.battery_id = battery.battery_id
JOIN controller ON bikes.controller_id = controller.controller_id;
-- 2. Отримати всі данні з таблиці bikes
SELECT * FROM bikes;
--3. Вибрати велосипеди, вироблені в Україні:
SELECT * FROM bikes WHERE producing_country = 'Ukraine';
--4. Вибрати велосипеди з діапазоном пробігу більше 70 км:
SELECT * FROM bikes WHERE bike_range > 70;
--5. Вибрати велосипеди з батареями, виробленими в Китаї:
SELECT * FROM bikes 
JOIN battery ON bikes.battery_id = battery.battery_id 
WHERE battery.producing_country = 'China';
--6. Вибрати велосипеди з контролерами від Bosch:
SELECT * FROM bikes 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE controller.controller_name = 'Bosch';
--7. Вибрати велосипеди з потужністю двигуна 500 Вт:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
WHERE motor.motor_power = 500;
--8. Вибрати велосипеди з батареями ємністю 20 Аг:
SELECT * FROM bikes 
JOIN battery ON bikes.battery_id = battery.battery_id 
WHERE battery.battery_cappacity = 20;
--9. Вибрати велосипеди з контролерами, виробленими в Німеччині і потужністю більше 400 Вт:
SELECT * FROM bikes 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE controller.controller_country = 'Germany' AND controller.controller_power > 400;
--10. Вибрати велосипеди з моторами та батареями одного типу напруги:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
JOIN battery ON bikes.battery_id = battery.battery_id 
WHERE motor.motor_volt = battery.battery_volt;
--11. Вибрати велосипеди з редукторним мотором:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
WHERE motor.motor_type = 'reducer';
--12. Вибрати велосипеди з найбільшим діапазоном пробігу:
SELECT * FROM bikes ORDER BY bike_range DESC LIMIT 5;
--13. Знайти середній діапазон пробігу для велосипедів з батареями ємністю 20 Аг:
SELECT AVG(bike_range) AS avg_range FROM bikes 
JOIN battery ON bikes.battery_id = battery.battery_id 
WHERE battery.battery_cappacity = 20;
--14. Вибрати велосипеди з контролерами, виробленими в країнах, де виробляється найбільше велосипедів:
SELECT * FROM bikes 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE controller.controller_country IN (
    SELECT producing_country FROM bikes GROUP BY producing_country ORDER BY COUNT(*) DESC LIMIT 1);
--15. Отримати середній діапазон пробігу для кожного бренду велосипедів:
SELECT bike_brand, AVG(bike_range) AS avg_range FROM bikes GROUP BY bike_brand;
--16. Вибрати велосипеди з моторами, виробленими в країнах, що не є частиною "Великої Вісімки" (G8):
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
WHERE motor.producing_country NOT IN ('USA', 'UK', 'Germany', 'France', 'Italy', 'Canada', 'Japan', 'Russia');
--17. Отримати кількість велосипедів з різними типами моторів:
SELECT motor_type, COUNT(*) AS total_bikes FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
GROUP BY motor_type;
--18. Вибрати велосипеди з найпотужнішими моторами:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
ORDER BY motor.motor_power DESC LIMIT 5;
--19. Знайти загальну сумарну потужність моторів для кожної країни-виробника:
SELECT producing_country, SUM(motor_power) AS total_power FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
GROUP BY producing_country;
--20. Вибрати велосипеди, вироблені в країнах, де потужність контролерів вище середньої:
SELECT * FROM bikes 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE controller.controller_power > (
    SELECT AVG(controller_power) FROM controller
);
--21. Підрахувати кількість велосипедів з різними видами батарей:
SELECT bms, COUNT(*) AS total_bikes FROM bikes 
JOIN battery ON bikes.battery_id = battery.battery_id 
GROUP BY bms;
--22. Вибрати велосипеди з моторами прямого типу і потужністю більше 400 Вт:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
WHERE motor.motor_type = 'straight' AND motor.motor_power > 400;
--23. Знайти середній діапазон пробігу для велосипедів кожного типу мотора:
SELECT motor_type, AVG(bike_range) AS avg_range FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
GROUP BY motor_type;
--24. Вибрати велосипеди з контролерами потужністю, яка знаходиться в заданому діапазоні (наприклад, 300-500 Вт):
SELECT * FROM bikes 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE controller.controller_power BETWEEN 300 AND 500;
--25. Знайти кількість велосипедів, вироблених кожним виробником батарей:
SELECT producing_country, COUNT(*) AS total_bikes FROM bikes 
JOIN battery ON bikes.battery_id = battery.battery_id 
GROUP BY producing_country;
--26. Вибрати велосипеди з батареями, ємність яких більше 20 Аг та напруга більше 36 В:
SELECT * FROM bikes 
JOIN battery ON bikes.battery_id = battery.battery_id 
WHERE battery.battery_cappacity > 20 AND battery.battery_volt > 36;
--27. Вибрати велосипеди з моторами, які використовують технологію редуктора та вироблені в країні, що починається на "C":
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
WHERE motor.motor_type = 'reducer' AND motor.producing_country LIKE 'C%';
--28. Знайти середню потужність контролерів для кожної країни:
SELECT controller_country, AVG(controller_power) AS avg_power FROM controller GROUP BY controller_country;
--29. Вибрати велосипеди з контролерами від Huawei та потужністю більше 400 Вт:
SELECT * FROM bikes 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE controller.controller_name = 'HUAWEI' AND controller.controller_power > 400;
--30. Вибрати велосипеди з контролерами потужністю, яка не перевищує потужність двигуна:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE controller.controller_power <= motor.motor_power;
--31. Знайти кількість велосипедів кожного бренду:
SELECT bike_brand, COUNT(*) AS total_bikes FROM bikes GROUP BY bike_brand;
--32. Вибрати велосипеди з моторами, виробленими в США та Німеччині:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
WHERE motor.producing_country IN ('USA', 'Germany');
--33. Знайти відсоток велосипедів, вироблених в Україні, відносно загальної кількості велосипедів:
SELECT (COUNT(*) * 100 / (SELECT COUNT(*) FROM bikes)) AS percentage FROM bikes WHERE producing_country = 'Ukraine';
--34. Вибрати велосипеди, де максимальна потужність контролера перевищує середню потужність контролера:
SELECT * FROM bikes 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE controller.controller_power > (
    SELECT AVG(controller_power) FROM controller
);
--35. Вибрати велосипеди з моторами, виробленими в країнах, що починаються з літери "U" і мають потужність більше 500 Вт:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
WHERE motor.producing_country LIKE 'U%' AND motor.motor_power > 500;
--36. Знайти мінімальний діапазон пробігу серед усіх велосипедів:
SELECT MIN(bike_range) AS min_range FROM bikes;
--37. Знайти кількість велосипедів, вироблених в кожній країні за алфавітом:
SELECT producing_country, COUNT(*) AS total_bikes FROM bikes GROUP BY producing_country ORDER BY producing_country;
--38. SELECT * FROM bikes 
JOIN battery ON bikes.battery_id = battery.battery_id 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE battery.producing_country = controller.controller_country;
--39. Вибрати велосипеди з батареями, виробленими в Японії або Німеччині:
SELECT * FROM bikes 
JOIN battery ON bikes.battery_id = battery.battery_id 
WHERE battery.producing_country IN ('Japan', 'Germany');
--40. Знайти кількість велосипедів кожного бренду, де діапазон пробігу більше 50 км:
SELECT bike_brand, COUNT(*) AS total_bikes 
FROM bikes 
WHERE bike_range > 50 
GROUP BY bike_brand;
--41. Вибрати велосипеди з батареями, що мають потужність більше 36 Вт:
SELECT * FROM bikes 
JOIN battery ON bikes.battery_id = battery.battery_id 
WHERE battery.battery_volt > 36;
--42. Знайти максимальну потужність контролера:
SELECT MAX(controller_power) AS max_power FROM controller;
--43. Вибрати велосипеди з контролерами, які мають потужність більше 300 Вт та вироблені в Німеччині:
SELECT * FROM bikes 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE controller.controller_power > 300 AND controller.controller_country = 'Germany';
--44. Знайти кількість велосипедів з моторами прямого типу і потужністю менше 500 Вт:
SELECT COUNT(*) AS total_bikes 
FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
WHERE motor.motor_type = 'straight' AND motor.motor_power < 500;
--45. Вибрати велосипеди з контролерами, виробленими в Китаї та США:
SELECT * FROM bikes 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE controller.controller_country IN ('China', 'USA');
--46. Вибрати велосипеди з моторами, потужність яких менше 400 Вт або більше 700 Вт:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
WHERE motor.motor_power < 400 OR motor.motor_power > 700;
--47. Вибрати всі бренди велосипедів:
SELECT DISTINCT bike_brand FROM bikes;
--48. Вибрати всі батареї:
SELECT * FROM battery;
--49. Вибрати всі контролери:
SELECT * FROM controller;
--50. Вибрати всі мотори:
SELECT * FROM motor;
--51. Знайти кількість батарей:
SELECT COUNT(*) AS total_batteries FROM battery;
--52. Знайти кількість контролерів:
SELECT COUNT(*) AS total_controllers FROM controller;
--53. Знайти кількість моторів:
SELECT COUNT(*) AS total_motors FROM motor;
--54. Знайти середню потужність контролерів:
SELECT AVG(controller_power) AS avg_power FROM controller;
--55. Знайти середню потужність моторів:
SELECT AVG(motor_power) AS avg_power FROM motor;
--56. Знайти найбільшу ємність батарей:
SELECT MAX(battery_cappacity) AS max_capacity FROM battery;
--57. Знайти найменшу потужність контролерів:
SELECT MIN(controller_power) AS min_power FROM controller;
--58. Вибрати велосипеди з найбільшою ємністю батарей:
SELECT * FROM bikes 
JOIN battery ON bikes.battery_id = battery.battery_id 
ORDER BY battery.battery_cappacity DESC
LIMIT 10;
--59. Вибрати велосипеди з найбільшою потужністю моторів:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
ORDER BY motor.motor_power DESC
LIMIT 10;
--60. Вибрати контролери з найбільшою потужністю:
SELECT * FROM controller 
ORDER BY controller_power DESC
LIMIT 10;
--61. Вибрати батареї з найменшою напругою:
SELECT * FROM battery 
ORDER BY battery_volt ASC
LIMIT 10;
--62. Вибрати велосипеди з найбільшим пробігом:
SELECT * FROM bikes 
ORDER BY bike_range DESC
LIMIT 10;
--63. Знайти країни, які виробляють найбільше моторів:
SELECT producing_country, COUNT(*) AS total_motors FROM motor 
GROUP BY producing_country 
ORDER BY total_motors DESC
LIMIT 5;
--64. Знайти країни, які виробляють найбільше батарей:
SELECT producing_country, COUNT(*) AS total_batteries FROM battery 
GROUP BY producing_country 
ORDER BY total_batteries DESC
LIMIT 5;
--65. 
SELECT producing_country, COUNT(*) AS total_bikes FROM bikes 
GROUP BY producing_country 
ORDER BY total_bikes DESC
LIMIT 5;
--66. Знайти країни, які виробляють найбільше контролерів:
SELECT controller_country, COUNT(*) AS total_controllers FROM controller 
GROUP BY controller_country 
ORDER BY total_controllers DESC
LIMIT 5;
--67. Знайти країни, які виробляють найменше велосипедів:
SELECT producing_country, COUNT(*) AS total_bikes FROM bikes 
GROUP BY producing_country 
ORDER BY total_bikes ASC
LIMIT 5;
--68. Знайти країни, які виробляють найменше моторів
SELECT producing_country, COUNT(*) AS total_motors FROM motor 
GROUP BY producing_country 
ORDER BY total_motors ASC
LIMIT 5;
--69. Знайти країни, які виробляють найменше батарей:
SELECT producing_country, COUNT(*) AS total_batteries FROM battery 
GROUP BY producing_country 
ORDER BY total_batteries ASC
LIMIT 5;
--70. Знайти країни, які виробляють найменше контролерів:
SELECT controller_country, COUNT(*) AS total_controllers FROM controller 
GROUP BY controller_country 
ORDER BY total_controllers ASC
LIMIT 5;
--71. Пошук велосипедів з певним брендом:
SELECT * FROM bikes WHERE bike_brand = 'Cube';
--72. Пошук велосипедів з певним типом мотора:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
WHERE motor.motor_type = 'straight';
--73. Пошук велосипедів з певною ємністю батареї:
SELECT * FROM bikes 
JOIN battery ON bikes.battery_id = battery.battery_id 
WHERE battery.battery_cappacity = 20;
--74. Пошук велосипедів з певною країною виробництва:
SELECT * FROM bikes WHERE producing_country = 'Germany';
--75. Пошук моторів з певною потужністю:
SELECT * FROM motor WHERE motor_power >= 500;
--76. Пошук моторів з певною країною виробництва:
SELECT * FROM motor WHERE producing_country = 'China';
--77. Пошук батарей з певною напругою:
SELECT * FROM battery WHERE battery_volt = 36;
--78. Пошук батарей з певною країною виробництва:
SELECT * FROM battery WHERE producing_country = 'USA';
--79. Пошук контролерів з певною потужністю:
SELECT * FROM controller WHERE controller_power >= 500;
--80. Пошук контролерів з певною країною виробництва
SELECT * FROM controller WHERE controller_country = 'Japan';
--81. Вибрати велосипеди з моторами від певного бренду:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
WHERE motor.motor_brand = 'Bosch';
--82. Вибрати велосипеди з батареями від певного бренду:
SELECT * FROM bikes 
JOIN battery ON bikes.battery_id = battery.battery_id 
WHERE battery.battery_brand = 'Tesla';
--83. Вибрати велосипеди з контролерами від певного бренду:
SELECT * FROM bikes 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE controller.controller_brand = 'Shimano';
--84. Вибрати велосипеди з моторами від певної країни виробництва:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
WHERE motor.producing_country = 'Germany';
--85. Вибрати велосипеди з батареями від певної країни виробництва:
SELECT * FROM bikes 
JOIN battery ON bikes.battery_id = battery.battery_id 
WHERE battery.producing_country = 'USA';
--86. Вибрати велосипеди з контролерами від певної країни виробництва:
SELECT * FROM bikes 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE controller.controller_country = 'Japan';
--87. Вибрати велосипеди з моторами певного типу:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
WHERE motor.motor_type = 'straight';
--89. Вибрати велосипеди з контролерами певного типу:
SELECT * FROM bikes 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE controller.controller_power > 500;
--90. Пошук велосипедів з батареями певної ємності:
SELECT * FROM bikes 
JOIN battery ON bikes.battery_id = battery.battery_id 
WHERE battery.battery_cappacity = 20;
--91. Пошук велосипедів з контролерами певної потужності:
SELECT * FROM bikes 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE controller.controller_power >= 500;
--92. Пошук велосипедів з моторами певної потужності:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
WHERE motor.motor_power >= 500;
--93. Пошук велосипедів з батареями від певного виробника:
SELECT * FROM bikes 
JOIN battery ON bikes.battery_id = battery.battery_id 
WHERE battery.producing_country = 'China';
--94. Пошук велосипедів з контролерами від певного виробника:
SELECT * FROM bikes 
JOIN controller ON bikes.controller_id = controller.controller_id 
WHERE controller.producing_country = 'Germany';
--95. Пошук велосипедів з моторами від певного виробника:
SELECT * FROM bikes 
JOIN motor ON bikes.motor_id = motor.motor_id 
WHERE motor.producing_country = 'Korea';
--96. Пошук бренда велосипеда який починається на А
SELECT DISTINCT bike_brand 
FROM bikes 
WHERE bike_brand LIKE 'A%';
--97. Пошук контроллера велосипеда який починається на I
SELECT DISTINCT controller_name
FROM controller 
WHERE controller_name LIKE 'I%';
--98. Пошук батареї велосипеда, виробник якї починається на G
SELECT DISTINCT producing_country
FROM battery 
WHERE producing_country LIKE 'G%';
--99. Пошук бмс-плати батареї велосипеда який починається на k
SELECT DISTINCT bms
FROM battery
WHERE bms LIKE 'k%';
--100. Пошук мотора велосипеда, виробник якого починається на U
SELECT DISTINCT producing_country
FROM motor
WHERE producing_country LIKE 'U%';