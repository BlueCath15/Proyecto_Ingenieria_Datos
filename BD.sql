-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.2
-- PostgreSQL version: 12.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: new_database | type: DATABASE --
-- -- DROP DATABASE IF EXISTS new_database;
-- CREATE DATABASE new_database;
-- -- ddl-end --
-- 

-- object: public."CULTIVO" | type: TABLE --
-- DROP TABLE IF EXISTS public."CULTIVO" CASCADE;
CREATE TABLE public."CULTIVO" (
	codigo integer NOT NULL,
	nombre varchar(45),
	nombre_cientifico varchar(45),
	"ID_CICLO_CULTIVO" integer NOT NULL,
	"ID_SUBGRUPO" integer,
	CONSTRAINT "CULTIVO_pk" PRIMARY KEY (codigo)

);
-- ddl-end --
-- ALTER TABLE public."CULTIVO" OWNER TO postgres;
-- ddl-end --

-- object: public."CICLO_CULTIVO" | type: TABLE --
-- DROP TABLE IF EXISTS public."CICLO_CULTIVO" CASCADE;
CREATE TABLE public."CICLO_CULTIVO" (
	"ID" integer NOT NULL,
	ciclo varchar(45),
	CONSTRAINT "CICLO_CULTIVO_pk" PRIMARY KEY ("ID")

);
-- ddl-end --
-- ALTER TABLE public."CICLO_CULTIVO" OWNER TO postgres;
-- ddl-end --

-- object: "CICLO_CULTIVO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."CULTIVO" DROP CONSTRAINT IF EXISTS "CICLO_CULTIVO_fk" CASCADE;
ALTER TABLE public."CULTIVO" ADD CONSTRAINT "CICLO_CULTIVO_fk" FOREIGN KEY ("ID_CICLO_CULTIVO")
REFERENCES public."CICLO_CULTIVO" ("ID") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."GRUPO" | type: TABLE --
-- DROP TABLE IF EXISTS public."GRUPO" CASCADE;
CREATE TABLE public."GRUPO" (
	"ID" integer NOT NULL,
	nombre varchar(45) NOT NULL,
	CONSTRAINT "GRUPO_pk" PRIMARY KEY ("ID")

);
-- ddl-end --
-- ALTER TABLE public."GRUPO" OWNER TO postgres;
-- ddl-end --

-- object: public."SUBGRUPO" | type: TABLE --
-- DROP TABLE IF EXISTS public."SUBGRUPO" CASCADE;
CREATE TABLE public."SUBGRUPO" (
	"ID" integer NOT NULL,
	"ID_GRUPO" integer,
	nombre smallint NOT NULL,
	CONSTRAINT "SUBGRUPO_pk" PRIMARY KEY ("ID")

);
-- ddl-end --
-- ALTER TABLE public."SUBGRUPO" OWNER TO postgres;
-- ddl-end --

-- object: "GRUPO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."SUBGRUPO" DROP CONSTRAINT IF EXISTS "GRUPO_fk" CASCADE;
ALTER TABLE public."SUBGRUPO" ADD CONSTRAINT "GRUPO_fk" FOREIGN KEY ("ID_GRUPO")
REFERENCES public."GRUPO" ("ID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "SUBGRUPO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."CULTIVO" DROP CONSTRAINT IF EXISTS "SUBGRUPO_fk" CASCADE;
ALTER TABLE public."CULTIVO" ADD CONSTRAINT "SUBGRUPO_fk" FOREIGN KEY ("ID_SUBGRUPO")
REFERENCES public."SUBGRUPO" ("ID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."PRODUCCION" | type: TABLE --
-- DROP TABLE IF EXISTS public."PRODUCCION" CASCADE;
CREATE TABLE public."PRODUCCION" (
	"ID_MUNICIPIO" integer NOT NULL,
	"codigo_CULTIVO" integer NOT NULL,
	cantidad real NOT NULL,
	area_sembrada real,
	areal_cosechada real,
	"ID_ESTADO" integer,
	"anio_ANIO_PERIDO" integer,
	"periodo_ANIO_PERIDO" char(5),
	CONSTRAINT "PRODUCCION_pk" PRIMARY KEY ("codigo_CULTIVO","ID_MUNICIPIO")

);
-- ddl-end --
-- ALTER TABLE public."PRODUCCION" OWNER TO postgres;
-- ddl-end --

-- object: public."ESTADO" | type: TABLE --
-- DROP TABLE IF EXISTS public."ESTADO" CASCADE;
CREATE TABLE public."ESTADO" (
	"ID" integer NOT NULL,
	estado varchar(45),
	CONSTRAINT "ESTADO_pk" PRIMARY KEY ("ID")

);
-- ddl-end --
-- ALTER TABLE public."ESTADO" OWNER TO postgres;
-- ddl-end --

-- object: "CULTIVO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PRODUCCION" DROP CONSTRAINT IF EXISTS "CULTIVO_fk" CASCADE;
ALTER TABLE public."PRODUCCION" ADD CONSTRAINT "CULTIVO_fk" FOREIGN KEY ("codigo_CULTIVO")
REFERENCES public."CULTIVO" (codigo) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "ESTADO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PRODUCCION" DROP CONSTRAINT IF EXISTS "ESTADO_fk" CASCADE;
ALTER TABLE public."PRODUCCION" ADD CONSTRAINT "ESTADO_fk" FOREIGN KEY ("ID_ESTADO")
REFERENCES public."ESTADO" ("ID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."ANIO_PERIDO" | type: TABLE --
-- DROP TABLE IF EXISTS public."ANIO_PERIDO" CASCADE;
CREATE TABLE public."ANIO_PERIDO" (
	anio integer NOT NULL,
	periodo char(5) NOT NULL,
	CONSTRAINT "ANIO_PERIDO_pk" PRIMARY KEY (anio,periodo)

);
-- ddl-end --
-- ALTER TABLE public."ANIO_PERIDO" OWNER TO postgres;
-- ddl-end --

-- object: "ANIO_PERIDO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PRODUCCION" DROP CONSTRAINT IF EXISTS "ANIO_PERIDO_fk" CASCADE;
ALTER TABLE public."PRODUCCION" ADD CONSTRAINT "ANIO_PERIDO_fk" FOREIGN KEY ("anio_ANIO_PERIDO","periodo_ANIO_PERIDO")
REFERENCES public."ANIO_PERIDO" (anio,periodo) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."MUNICIPIO" | type: TABLE --
-- DROP TABLE IF EXISTS public."MUNICIPIO" CASCADE;
CREATE TABLE public."MUNICIPIO" (
	"ID" integer NOT NULL,
	nombre varchar(45),
	"ID_DEPARTAMENTO" integer,
	CONSTRAINT "MUNICIPIO_pk" PRIMARY KEY ("ID")

);
-- ddl-end --
-- ALTER TABLE public."MUNICIPIO" OWNER TO postgres;
-- ddl-end --

-- object: "MUNICIPIO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."PRODUCCION" DROP CONSTRAINT IF EXISTS "MUNICIPIO_fk" CASCADE;
ALTER TABLE public."PRODUCCION" ADD CONSTRAINT "MUNICIPIO_fk" FOREIGN KEY ("ID_MUNICIPIO")
REFERENCES public."MUNICIPIO" ("ID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."DEPARTAMENTO" | type: TABLE --
-- DROP TABLE IF EXISTS public."DEPARTAMENTO" CASCADE;
CREATE TABLE public."DEPARTAMENTO" (
	"ID" integer NOT NULL,
	nombre varchar(45),
	CONSTRAINT "DEPARTAMENTO_pk" PRIMARY KEY ("ID")

);
-- ddl-end --
-- ALTER TABLE public."DEPARTAMENTO" OWNER TO postgres;
-- ddl-end --

-- object: "DEPARTAMENTO_fk" | type: CONSTRAINT --
-- ALTER TABLE public."MUNICIPIO" DROP CONSTRAINT IF EXISTS "DEPARTAMENTO_fk" CASCADE;
ALTER TABLE public."MUNICIPIO" ADD CONSTRAINT "DEPARTAMENTO_fk" FOREIGN KEY ("ID_DEPARTAMENTO")
REFERENCES public."DEPARTAMENTO" ("ID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


