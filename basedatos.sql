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

-- object: public.cultivo | type: TABLE --
-- DROP TABLE IF EXISTS public.cultivo CASCADE;
CREATE TABLE public.cultivo (
	codigo integer NOT NULL,
	nombre varchar(45),
	nombre_cientifico varchar(45),
	"ID_subgrupo" integer,
	"ID_ciclo_cultivo" integer NOT NULL,
	CONSTRAINT "CULTIVO_pk" PRIMARY KEY (codigo)

);
-- ddl-end --
-- ALTER TABLE public.cultivo OWNER TO postgres;
-- ddl-end --

-- object: public.ciclo_cultivo | type: TABLE --
-- DROP TABLE IF EXISTS public.ciclo_cultivo CASCADE;
CREATE TABLE public.ciclo_cultivo (
	"ID" integer NOT NULL,
	ciclo varchar(45),
	CONSTRAINT "CICLO_CULTIVO_pk" PRIMARY KEY ("ID")

);
-- ddl-end --
-- ALTER TABLE public.ciclo_cultivo OWNER TO postgres;
-- ddl-end --

-- object: ciclo_cultivo_fk | type: CONSTRAINT --
-- ALTER TABLE public.cultivo DROP CONSTRAINT IF EXISTS ciclo_cultivo_fk CASCADE;
ALTER TABLE public.cultivo ADD CONSTRAINT ciclo_cultivo_fk FOREIGN KEY ("ID_ciclo_cultivo")
REFERENCES public.ciclo_cultivo ("ID") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.grupo | type: TABLE --
-- DROP TABLE IF EXISTS public.grupo CASCADE;
CREATE TABLE public.grupo (
	"ID" integer NOT NULL,
	nombre varchar(45) NOT NULL,
	CONSTRAINT "GRUPO_pk" PRIMARY KEY ("ID")

);
-- ddl-end --
-- ALTER TABLE public.grupo OWNER TO postgres;
-- ddl-end --

-- object: public.subgrupo | type: TABLE --
-- DROP TABLE IF EXISTS public.subgrupo CASCADE;
CREATE TABLE public.subgrupo (
	"ID" integer NOT NULL,
	nombre smallint NOT NULL,
	"ID_grupo" integer,
	CONSTRAINT "SUBGRUPO_pk" PRIMARY KEY ("ID")

);
-- ddl-end --
-- ALTER TABLE public.subgrupo OWNER TO postgres;
-- ddl-end --

-- object: grupo_fk | type: CONSTRAINT --
-- ALTER TABLE public.subgrupo DROP CONSTRAINT IF EXISTS grupo_fk CASCADE;
ALTER TABLE public.subgrupo ADD CONSTRAINT grupo_fk FOREIGN KEY ("ID_grupo")
REFERENCES public.grupo ("ID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: subgrupo_fk | type: CONSTRAINT --
-- ALTER TABLE public.cultivo DROP CONSTRAINT IF EXISTS subgrupo_fk CASCADE;
ALTER TABLE public.cultivo ADD CONSTRAINT subgrupo_fk FOREIGN KEY ("ID_subgrupo")
REFERENCES public.subgrupo ("ID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.produccion | type: TABLE --
-- DROP TABLE IF EXISTS public.produccion CASCADE;
CREATE TABLE public.produccion (
	cantidad real NOT NULL,
	area_sembrada real,
	areal_cosechada real,
	codigo_cultivo integer NOT NULL,
	"ID_municipo" integer NOT NULL,
	"ID_estado" integer,
	anio_anio_periodo integer,
	periodo_anio_periodo char(5),
	CONSTRAINT produccion_pk PRIMARY KEY (codigo_cultivo,"ID_municipo")

);
-- ddl-end --
-- ALTER TABLE public.produccion OWNER TO postgres;
-- ddl-end --

-- object: public.estado | type: TABLE --
-- DROP TABLE IF EXISTS public.estado CASCADE;
CREATE TABLE public.estado (
	"ID" integer NOT NULL,
	estado varchar(45),
	CONSTRAINT "ESTADO_pk" PRIMARY KEY ("ID")

);
-- ddl-end --
-- ALTER TABLE public.estado OWNER TO postgres;
-- ddl-end --

-- object: cultivo_fk | type: CONSTRAINT --
-- ALTER TABLE public.produccion DROP CONSTRAINT IF EXISTS cultivo_fk CASCADE;
ALTER TABLE public.produccion ADD CONSTRAINT cultivo_fk FOREIGN KEY (codigo_cultivo)
REFERENCES public.cultivo (codigo) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: estado_fk | type: CONSTRAINT --
-- ALTER TABLE public.produccion DROP CONSTRAINT IF EXISTS estado_fk CASCADE;
ALTER TABLE public.produccion ADD CONSTRAINT estado_fk FOREIGN KEY ("ID_estado")
REFERENCES public.estado ("ID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.anio_periodo | type: TABLE --
-- DROP TABLE IF EXISTS public.anio_periodo CASCADE;
CREATE TABLE public.anio_periodo (
	anio integer NOT NULL,
	periodo char(5) NOT NULL,
	CONSTRAINT "ANIO_PERIDO_pk" PRIMARY KEY (anio,periodo)

);
-- ddl-end --
-- ALTER TABLE public.anio_periodo OWNER TO postgres;
-- ddl-end --

-- object: anio_periodo_fk | type: CONSTRAINT --
-- ALTER TABLE public.produccion DROP CONSTRAINT IF EXISTS anio_periodo_fk CASCADE;
ALTER TABLE public.produccion ADD CONSTRAINT anio_periodo_fk FOREIGN KEY (anio_anio_periodo,periodo_anio_periodo)
REFERENCES public.anio_periodo (anio,periodo) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.municipo | type: TABLE --
-- DROP TABLE IF EXISTS public.municipo CASCADE;
CREATE TABLE public.municipo (
	"ID" integer NOT NULL,
	nombre varchar(45),
	"ID_departamento" integer,
	CONSTRAINT "MUNICIPIO_pk" PRIMARY KEY ("ID")

);
-- ddl-end --
-- ALTER TABLE public.municipo OWNER TO postgres;
-- ddl-end --

-- object: municipo_fk | type: CONSTRAINT --
-- ALTER TABLE public.produccion DROP CONSTRAINT IF EXISTS municipo_fk CASCADE;
ALTER TABLE public.produccion ADD CONSTRAINT municipo_fk FOREIGN KEY ("ID_municipo")
REFERENCES public.municipo ("ID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.departamento | type: TABLE --
-- DROP TABLE IF EXISTS public.departamento CASCADE;
CREATE TABLE public.departamento (
	"ID" integer NOT NULL,
	nombre varchar(45),
	CONSTRAINT "DEPARTAMENTO_pk" PRIMARY KEY ("ID")

);
-- ddl-end --
-- ALTER TABLE public.departamento OWNER TO postgres;
-- ddl-end --

-- object: departamento_fk | type: CONSTRAINT --
-- ALTER TABLE public.municipo DROP CONSTRAINT IF EXISTS departamento_fk CASCADE;
ALTER TABLE public.municipo ADD CONSTRAINT departamento_fk FOREIGN KEY ("ID_departamento")
REFERENCES public.departamento ("ID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

