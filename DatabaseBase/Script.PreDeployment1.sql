-- Создание базы данных с именем EducationInUniversityProject
CREATE DATABASE EducationInUniversityProject;
GO

-- Использование только что созданной базы данных
USE EducationInUniversityProject;
GO

-- Создание таблицы Location с автоинкрементом для LocationId
CREATE TABLE Location
(
    LocationId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,  -- LocationId автоматически увеличивается с каждым новым значением
    Address NVARCHAR(30),  -- Адрес местоположения
    LocationArea DECIMAL(8,2),  -- Площадь местоположения
    DateAdded DATE DEFAULT GETDATE(),  -- Дата добавления записи (по умолчанию текущая дата)
    DateChanged DATE DEFAULT GETDATE()  -- Дата последнего изменения записи (по умолчанию текущая дата)
);
GO

-- Создание таблицы University с автоинкрементом для UniversityId
CREATE TABLE University 
(
    UniversityId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,  -- UniversityId автоматически увеличивается с каждым новым значением
    LocationId INT,  -- Внешний ключ, ссылающийся на таблицу Location
    Faculty NVARCHAR(30) NOT NULL,  -- Факультет университета
    CountStudents INT,  -- Количество студентов в университете
    DateAdded DATE DEFAULT GETDATE(),  -- Дата добавления записи (по умолчанию текущая дата)
    DateChanged DATE DEFAULT GETDATE(),  -- Дата последнего изменения записи (по умолчанию текущая дата)
    -- Определение внешнего ключа, ссылающегося на LocationId в таблице Location
    CONSTRAINT FK_University_Location FOREIGN KEY(LocationId) REFERENCES Location(LocationId)
);
GO

-- Создание таблицы Lesson с автоинкрементом для LessonId
CREATE TABLE Lesson
(
    LessonId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,  -- LessonId автоматически увеличивается с каждым новым значением
    LessonName NVARCHAR(30),  -- Название урока
    DateAdded DATE DEFAULT GETDATE(),  -- Дата добавления записи (по умолчанию текущая дата)
    DateChanged DATE DEFAULT GETDATE()  -- Дата последнего изменения записи (по умолчанию текущая дата)
);
GO

-- Создание таблицы Teacher с автоинкрементом для TeacherId
CREATE TABLE Teacher 
(
    TeacherId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,  -- TeacherId автоматически увеличивается с каждым новым значением
    LessonId INT,  -- Внешний ключ, ссылающийся на таблицу Lesson
    UniversityId INT,  -- Внешний ключ, ссылающийся на таблицу University
    Name NVARCHAR(30),  -- Имя преподавателя
    Surname NVARCHAR(30),  -- Фамилия преподавателя
    BirthDay DATE,  -- Дата рождения преподавателя
    Salary DECIMAL(8,2),  -- Зарплата преподавателя
    DateAdded DATE DEFAULT GETDATE(),  -- Дата добавления записи (по умолчанию текущая дата)
    DateChanged DATE DEFAULT GETDATE(),  -- Дата последнего изменения записи (по умолчанию текущая дата)
    -- Определение внешнего ключа, ссылающегося на UniversityId в таблице University
    CONSTRAINT FK_Teacher_University FOREIGN KEY(UniversityId) REFERENCES University(UniversityId),
    -- Определение внешнего ключа, ссылающегося на LessonId в таблице Lesson
    CONSTRAINT FK_Teacher_Lesson FOREIGN KEY(LessonId) REFERENCES Lesson(LessonId)
);
GO

-- Создание таблицы Student с автоинкрементом для StudentId
CREATE TABLE Student
(
    StudentId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,  -- StudentId автоматически увеличивается с каждым новым значением
    UniversityId INT,  -- Внешний ключ, ссылающийся на таблицу University
    Name NVARCHAR(30),  -- Имя студента
    Surname NVARCHAR(30),  -- Фамилия студента
    BirthDay DATE,  -- Дата рождения студента
    AverageGrade DECIMAL(4,2),  -- Средний балл студента
    DateAdded DATE DEFAULT GETDATE(),  -- Дата добавления записи (по умолчанию текущая дата)
    DateChanged DATE DEFAULT GETDATE(),  -- Дата последнего изменения записи (по умолчанию текущая дата)
    -- Определение внешнего ключа, ссылающегося на UniversityId в таблице University
    CONSTRAINT FK_Student_University FOREIGN KEY(UniversityId) REFERENCES University(UniversityId)
);
GO

-- Создание таблицы StudentLessons для связи студентов с уроками
CREATE TABLE StudentLessons 
(
    StudentId INT NOT NULL,  -- Внешний ключ, ссылающийся на таблицу Student
    LessonId INT NOT NULL,  -- Внешний ключ, ссылающийся на таблицу Lesson
    DateAdded DATE DEFAULT GETDATE(),  -- Дата добавления записи (по умолчанию текущая дата)
    DateChanged DATE DEFAULT GETDATE(),  -- Дата последнего изменения записи (по умолчанию текущая дата)
    PRIMARY KEY(StudentId, LessonId),  -- Первичный ключ, состоящий из комбинации StudentId и LessonId
    -- Определение внешнего ключа, ссылающегося на StudentId в таблице Student
    CONSTRAINT FK_StudentLesson_Student FOREIGN KEY(StudentId) REFERENCES Student(StudentId),
    -- Определение внешнего ключа, ссылающегося на LessonId в таблице Lesson
    CONSTRAINT FK_StudentLesson_Lesson FOREIGN KEY(LessonId) REFERENCES Lesson(LessonId)
);
GO

-- Вставка данных в таблицу Location
INSERT INTO Location (Address, LocationArea)
VALUES ('123 Main St', 1000.00),  -- Запись 1
       ('456 Elm St', 850.50);  -- Запись 2
GO

-- Вставка данных в таблицу University
INSERT INTO University (LocationId, Faculty, CountStudents)
VALUES (2, 'FCIM', 1000),  -- Университет 1
       (1, 'CIM', 850);  -- Университет 2
GO

-- Вставка данных в таблицу Lesson
INSERT INTO Lesson (LessonName)
VALUES ('Mathematics'),  -- Урок 1
       ('Physics'),  -- Урок 2
       ('Literature');  -- Урок 3
GO

-- Вставка данных в таблицу Teacher
INSERT INTO Teacher (LessonId, UniversityId, Name, Surname, BirthDay, Salary)
VALUES (1, 1, 'John', 'Doe', '1980-05-15', 50000.00),  -- Преподаватель 1
       (2, 1, 'Jane', 'Smith', '1975-11-22', 55000.00),  -- Преподаватель 2
       (3, 2, 'Alice', 'Johnson', '1982-07-30', 52000.00);  -- Преподаватель 3
GO

-- Вставка данных в таблицу Student
INSERT INTO Student (UniversityId, Name, Surname, BirthDay, AverageGrade)
VALUES (1, 'Tom', 'Brown', '2000-02-28', 8.0),  -- Студент 1
       (1, 'Emily', 'White', '2001-04-16', 8.2),  -- Студент 2
       (2, 'Michael', 'Green', '1999-12-10', 9.8);  -- Студент 3
GO

-- Вставка данных в таблицу StudentLessons
INSERT INTO StudentLessons (StudentId, LessonId)
VALUES (1, 1),  -- Студент 1 на Урок 1
       (1, 2),  -- Студент 1 на Урок 2
       (2, 1),  -- Студент 2 на Урок 1
       (3, 2),  -- Студент 3 на Урок 2
       (3, 3);  -- Студент 3 на Урок 3
GO

-- Запрос для получения названий уроков и количества студентов, которые посещают больше 2-х уроков
SELECT l.LessonName, COUNT(sl.StudentId) AS StudentCount
FROM StudentLessons sl
JOIN Lesson l ON sl.LessonId = l.LessonId
GROUP BY l.LessonName
HAVING COUNT(sl.StudentId) > 2;
GO

-- Запрос для получения информации о преподавателях и их зарплате, группируя их по TeacherId
SELECT T.Name, T.Surname, T.Salary, T.BirthDay
FROM Teacher T
JOIN Lesson L ON T.LessonId = L.LessonId
GROUP BY T.TeacherId, T.Name, T.Surname, T.Salary, T.BirthDay
HAVING COUNT(L.LessonId) > 0;
GO

-- Запрос для получения имен, фамилий и среднего балла студентов, которые имеют средний балл больше 8
SELECT s.Name,      -- Имя студента
       s.Surname,   -- Фамилия студента
       s.AverageGrade  -- Средний балл студента
FROM Student s
JOIN University U ON s.UniversityId = U.UniversityId  -- Соединение таблицы Student с таблицей University по UniversityId
GROUP BY s.Name, s.Surname, s.AverageGrade  -- Группировка результатов по имени, фамилии и среднему баллу студента
HAVING s.AverageGrade > 8;  -- Фильтрация групп, чтобы отобразить только тех студентов, у которых средний балл больше 8
GO