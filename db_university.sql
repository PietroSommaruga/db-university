-- Selezionare tutti gli studenti nati nel 1990 (160)
SELECT * FROM `students` where `date_of_birth` >= "1990-01-01" AND `date_of_birth` <= "1990-12-31" ORDER BY `date_of_birth`;

-- Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT * FROM `courses` WHERE `cfu` > "10"

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni
SELECT * FROM `students` WHERE (YEAR(CURRENT_DATE) - YEAR(`date_of_birth`)) >= 30

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT * FROM `courses` WHERE `year`= "1" AND `period` = "I semestre"

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT * FROM `exams` WHERE `date` = "2020-06-20" AND HOUR(`hour`) >= 14

-- 6. Selezionare tutti i corsi di laurea magistrale (38)
SELECT * FROM `degrees` WHERE `level` = "magistrale"

-- 7. Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(`id`) as `numero_dipartimenti` FROM `departments`

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT * FROM `teachers` WHERE `phone` IS NULL


-- ----------------------------------------------------------------------------

-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(*) AS "NUOVI STUDENTI 2021" FROM `students` WHERE `enrolment_date` LIKE "2021%" --(nuovi?)
SELECT COUNT(id) AS "NUOVI STUDENTI" FROM `students` GROUP BY YEAR(`enrolment_date`)

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(id) FROM `teachers` GROUP BY `office_address`

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT AVG(`vote`) ,`student_id` FROM `exam_student` GROUP BY `student_id`

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT `department_id` AS "DIPARTIMENTO", COUNT(department_id) AS "CORSI DI LAUREA" FROM `degrees` GROUP BY `department_id`

-- ---------------------------------------------------------------------------------------
-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`id`, `students`.`name`, `students`.`surname`, `students`.`email`, `degrees`.`name` FROM `students` INNER JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id` WHERE `degrees`.`name` LIKE '%economia%'

-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
SELECT `degrees`.`id`, `degrees`.`name`, `degrees`.`level`, `degrees`.`website`, `departments`.`name` FROM `degrees` INNER JOIN `departments` ON `degrees`.`department_id` = `departments`.`id` WHERE `degrees`.`level` = 'triennale' AND `departments`.`name` LIKE '%neuro%'

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `courses`.`name` AS "nome corso", `teachers`.`name`, `teachers`.`surname` FROM `course_teacher` JOIN `courses` ON `course_teacher`.`course_id` = `courses`.`id` JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id` WHERE `teachers`.`id` = 44


-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il
-- relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `students`.`id`, `students`.`name`,`students`.`surname`, `departments`.`name` AS "dipartimento", `degrees`.`name` AS "corso", `degrees`.`level` FROM `students` INNER JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id` INNER JOIN `departments` ON `degrees`.`department_id` = `departments`.`id` ORDER BY `students`.`id`

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT `degrees`.`name`, `degrees`.`level`, `courses`.`name`, `courses`.`description`, `courses`.`period`, `courses`.`year`, `courses`.`cfu`, `teachers`.`name`, `teachers`.`surname` FROM `degrees` JOIN `courses` ON `degrees`.`id` = `courses`.`degree_id` JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id` JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id` ORDER BY `degrees`.`name`

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT `teachers`.`name`, `teachers`.`surname`, `degrees`.`name` FROM `departments` JOIN `degrees` ON `departments`.`id` = `degrees`.`department_id` JOIN `courses` ON `degrees`.`id` = `courses`.`degree_id` JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id` JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id` WHERE `departments`.`name` LIKE "dipartimento di matematica"

-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per
-- superare ciascuno dei suoi esam