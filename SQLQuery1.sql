CREATE DATABASE Restaurant
USE Restaurant

CREATE TABLE Meals
(
 Id INT PRIMARY KEY IDENTITY,
 [Name] NVARCHAR(50) NOT NULL,
 Price MONEY NOT NULL 
)

CREATE TABLE Categories
(
 Id INT PRIMARY KEY IDENTITY,
 CtgName NVARCHAR(50) UNIQUE
)

ALTER TABLE Meals
ADD CategoryId INT FOREIGN KEY REFERENCES Categories(Id)

CREATE TABLE Ingredients
(
 Id INT PRIMARY KEY IDENTITY,
 IngrName NVARCHAR(50) UNIQUE
)

CREATE TABLE MealIngredients
(
 MealId INT FOREIGN KEY REFERENCES Meals(Id),
 IngrId INT FOREIGN KEY REFERENCES Ingredients(Id),
)

INSERT INTO Categories
VALUES
('Breakfast'),
('Lunch'),
('Dinner'),
('Dessert'),
('Snacks')

INSERT INTO Meals
VALUES
('Omelette',8,1),
('Granola',12,1),
('Tomato Soup',5,2),
('Caesar Wrap',11,2),
('Pizza Casserole',18,3),
('Lasagna',15,3),
('Tiramisu',9,4),
('Eclair',10,4)

INSERT INTO Ingredients
VALUES
('Egg'),
('Oil'),
('Tomato'),
('Oat'),
('Nuts'),
('Chicken'),
('Sausages'),
('Flour'),
('Pasta'),
('Vanilla'),
('Coffee'),
('Dough')

INSERT INTO MealIngredients
VALUES
(1,1),
(1,3),
(2,4),
(2,5),
(3,2),
(3,3),
(4,6),
(4,3),
(5,7),
(5,9),
(6,2),
(6,8),
(7,10),
(7,11),
(8,12)

SELECT *, (SELECT COUNT(*) FROM MealIngredients AS MI WHERE MI.MealId = M.Id) AS IngrCount FROM Meals AS M

SELECT 
Id ,CtgName ,
(SELECT MIN(PRICE) FROM Meals AS M WHERE M.CategoryId= C.Id) AS CheapestMeal,(SELECT MAX(PRICE) FROM Meals AS M WHERE M.CategoryId = C.ID) AS MostExpensive FROM Categories AS C

SELECT * ,(SELECT C.CtgName FROM Categories AS C WHERE C.Id=M.CategoryId) AS CategName FROM Meals AS M

SELECT * FROM Categories AS C WHERE NOT EXISTS(SELECT * FROM Meals AS M WHERE C.Id=M.CategoryId)
