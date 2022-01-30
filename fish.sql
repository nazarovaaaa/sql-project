CREATE TABLE "Сотрудники" (
  "Ном_труд_книж" NUMBER(6) UNIQUE, 
  "Фамилия" VARCHAR2(20), 
  "Имя" VARCHAR2(20), 
  "Отчество" VARCHAR2(20), 
  "Стаж" NUMBER(3), 
  "Кол_рейс" NUMBER(6), 
  "Дата_прин_раб" TIMESTAMP NOT NULL, 
  "Тел" NUMBER(11) DEFAULT 89999999999, 
  "Таб_ном_раб" NUMBER(6) PRIMARY KEY, 
  "Должность" VARCHAR2(20) NOT NULL, 
  "Эл.почта" VARCHAR2(20) DEFAULT 'rybolov@ryb.ru', 
  CONSTRAINT "Сотрудники.ch1" CHECK ("Кол_рейс" >= 0), 
  CONSTRAINT "Сотрудники.ch2" CHECK ("Стаж" >= 0), 
  CONSTRAINT "Сотрудники.ch3" CHECK ("Ном_труд_книж" >= 0)
);
CREATE TABLE "Судно" (
  "Ном_судн" NUMBER(6) PRIMARY KEY, 
  "Тип_судн" char NOT NULL, 
  "Разм_судн" VARCHAR2(20) DEFAULT '1x1x1', 
  "Водоизм_судн" NUMBER(6), 
  "Скор_судн" NUMBER(6), 
  "Прочн_судн" NUMBER(6), 
  "Дальн_судн" NUMBER(6), 
  "Автоном_судн" NUMBER(6), 
  "Тип_движ" VARCHAR2(20), 
  "Тип_суд_двиг" VARCHAR2(20), 
  "Мощ_двиг" NUMBER(6), 
  "Расх_топл" NUMBER(6), 
  "Дата_изг" TIMESTAMP NOT NULL, 
  "Ремонт_судн" char NOT NULL, 
  "Таб_ном_раб" NUMBER(6), 
  "Назв_судн" VARCHAR2(20) UNIQUE, 
  CONSTRAINT "Судно_FK" FOREIGN KEY ("Таб_ном_раб") REFERENCES "Сотрудники", 
  CONSTRAINT "Судно.ch1" CHECK (
    LENGTH("Разм_судн")>= 5
  ), 
  CONSTRAINT "Судно.ch2" CHECK ("Водоизм_судн" > 0), 
  CONSTRAINT "Судно.ch3" CHECK ("Скор_судн" > 0), 
  CONSTRAINT "Судно.ch4" CHECK ("Прочн_судн" > 0), 
  CONSTRAINT "Судно.ch5" CHECK ("Дальн_судн" > 0), 
  CONSTRAINT "Судно.ch6" CHECK ("Автоном_судн" > 0)
);
CREATE TABLE "Рейс" (
  "Ном_судн" NUMBER(6), 
  "Пор_ном_рейс" NUMBER(6) PRIMARY KEY, 
  "Дат_и_вр_нач_рейс" TIMESTAMP, 
  "Дат_и_вр_кон_рейс" TIMESTAMP, 
  CONSTRAINT "Рейс.UQ1" UNIQUE (
    "Ном_судн", "Дат_и_вр_нач_рейс"
  ), 
  CONSTRAINT "Рейс.UQ2" UNIQUE (
    "Ном_судн", "Дат_и_вр_кон_рейс"
  ), 
  CONSTRAINT "Рейс.FK" FOREIGN KEY ("Ном_судн") REFERENCES "Судно"
);
CREATE TABLE "Рейс_команда" (
  "Таб_ном_раб" NUMBER(6), 
  "Пор_ном_рейс" NUMBER(6), 
  CONSTRAINT "Рейс_команда_PK" PRIMARY KEY (
    "Таб_ном_раб", "Пор_ном_рейс"
  ), 
  CONSTRAINT "Рейс_команда_FK1" FOREIGN KEY ("Таб_ном_раб") REFERENCES "Сотрудники", 
  CONSTRAINT "Рейс_команда_FK2" FOREIGN KEY ("Пор_ном_рейс") REFERENCES "Рейс"
);
CREATE TABLE "Район" (
  "Ном_район" NUMBER(6) PRIMARY KEY, 
  "Назв_район" VARCHAR2(20) NOT NULL UNIQUE, 
  "Преобл_пор_рыб" VARCHAR2(20) NOT NULL
);
CREATE TABLE "Точка" (
  "Назв_точ" VARCHAR2(20) NOT NULL UNIQUE, 
  "Пор_ном_точ" NUMBER(6) PRIMARY KEY, 
  "Ном_район" NUMBER(6) NOT NULL, 
  "Ном_точ_в_район" NUMBER(6), 
  CONSTRAINT "Точка_FK" FOREIGN KEY ("Ном_район") REFERENCES "Район", 
  CONSTRAINT "Точка_UQ" UNIQUE(
    "Ном_район", "Ном_точ_в_район"
  )
);
CREATE TABLE "Точки_рейс" (
  "Кол_рыб" NUMBER(6), 
  "Сорт_рыб" VARCHAR2(20), 
  "Кач_рыб" NUMBER(6), 
  "Пор_ном_точ" NUMBER(6), 
  "Пор_ном_рейс" NUMBER(6), 
  "Дат_и_вр_нач" TIMESTAMP NOT NULL, 
  "Дат_и_вр_кон" TIMESTAMP NOT NULL, 
  CONSTRAINT "Точки_рейс_PK" PRIMARY KEY (
    "Пор_ном_точ", "Пор_ном_рейс"
  ), 
  CONSTRAINT "Точки_рейс_FK1" FOREIGN KEY ("Пор_ном_точ") REFERENCES "Точка", 
  CONSTRAINT "Точки_рейс_FK2" FOREIGN KEY ("Пор_ном_рейс") REFERENCES "Рейс"
);
DROP 
  TABLE "Сотрудники";
DROP 
  TABLE "Судно";
DROP 
  TABLE "Рейс";
DROP 
  TABLE "Рейс_команда";
DROP 
  TABLE "Район";
DROP 
  TABLE "Точка";
DROP 
  TABLE "Точки_рейс";
