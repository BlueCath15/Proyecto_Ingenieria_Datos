-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 0.9.4
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: public.cultivo | type: TABLE --
-- DROP TABLE IF EXISTS public.cultivo CASCADE;
CREATE TABLE public.cultivo (
	codigo integer NOT NULL,
	nombre varchar(35) NOT NULL,
	nombre_cientifico varchar(35) NOT NULL,
	id_ciclo_cultivo integer NOT NULL,
	id_subgrupo integer,
	CONSTRAINT cultivo_pk PRIMARY KEY (codigo)
);
-- ddl-end --
ALTER TABLE public.cultivo OWNER TO postgres;
-- ddl-end --

-- object: public.ciclo_cultivo | type: TABLE --
-- DROP TABLE IF EXISTS public.ciclo_cultivo CASCADE;
CREATE TABLE public.ciclo_cultivo (
	id integer NOT NULL,
	ciclo_cultivo varchar(45) NOT NULL,
	CONSTRAINT ciclo_cultivo_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.ciclo_cultivo OWNER TO postgres;
-- ddl-end --

-- object: ciclo_cultivo_fk | type: CONSTRAINT --
-- ALTER TABLE public.cultivo DROP CONSTRAINT IF EXISTS ciclo_cultivo_fk CASCADE;
ALTER TABLE public.cultivo ADD CONSTRAINT ciclo_cultivo_fk FOREIGN KEY (id_ciclo_cultivo)
REFERENCES public.ciclo_cultivo (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.grupo | type: TABLE --
-- DROP TABLE IF EXISTS public.grupo CASCADE;
CREATE TABLE public.grupo (
	id integer NOT NULL,
	nombre varchar(45) NOT NULL,
	CONSTRAINT grupo_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.grupo OWNER TO postgres;
-- ddl-end --

-- object: public.subgrupo | type: TABLE --
-- DROP TABLE IF EXISTS public.subgrupo CASCADE;
CREATE TABLE public.subgrupo (
	id integer NOT NULL,
	id_grupo integer NOT NULL,
	nombre varchar(45) NOT NULL,
	CONSTRAINT subgrupo_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.subgrupo OWNER TO postgres;
-- ddl-end --

-- object: grupo_fk | type: CONSTRAINT --
-- ALTER TABLE public.subgrupo DROP CONSTRAINT IF EXISTS grupo_fk CASCADE;
ALTER TABLE public.subgrupo ADD CONSTRAINT grupo_fk FOREIGN KEY (id_grupo)
REFERENCES public.grupo (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: subgrupo_fk | type: CONSTRAINT --
-- ALTER TABLE public.cultivo DROP CONSTRAINT IF EXISTS subgrupo_fk CASCADE;
ALTER TABLE public.cultivo ADD CONSTRAINT subgrupo_fk FOREIGN KEY (id_subgrupo)
REFERENCES public.subgrupo (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.producir | type: TABLE --
-- DROP TABLE IF EXISTS public.producir CASCADE;
CREATE TABLE public.producir (
	codigo_municipio integer NOT NULL,
	codigo_cultivo integer NOT NULL,
	cantidad real NOT NULL,
	area_sembrada real,
	area_cosechada real,
	id_estado integer,
	anio_anio_periodo integer,
	periodo_anio_periodo varchar(45),
	CONSTRAINT producir_pk PRIMARY KEY (codigo_municipio,codigo_cultivo)
);
-- ddl-end --
ALTER TABLE public.producir OWNER TO postgres;
-- ddl-end --

-- object: public.municipio | type: TABLE --
-- DROP TABLE IF EXISTS public.municipio CASCADE;
CREATE TABLE public.municipio (
	codigo integer NOT NULL,
	nombre varchar(45) NOT NULL,
	codigo_departamento integer,
	CONSTRAINT municipio_pk PRIMARY KEY (codigo)
);
-- ddl-end --
ALTER TABLE public.municipio OWNER TO postgres;
-- ddl-end --

-- object: municipio_fk | type: CONSTRAINT --
-- ALTER TABLE public.producir DROP CONSTRAINT IF EXISTS municipio_fk CASCADE;
ALTER TABLE public.producir ADD CONSTRAINT municipio_fk FOREIGN KEY (codigo_municipio)
REFERENCES public.municipio (codigo) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: cultivo_fk | type: CONSTRAINT --
-- ALTER TABLE public.producir DROP CONSTRAINT IF EXISTS cultivo_fk CASCADE;
ALTER TABLE public.producir ADD CONSTRAINT cultivo_fk FOREIGN KEY (codigo_cultivo)
REFERENCES public.cultivo (codigo) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: public.estado | type: TABLE --
-- DROP TABLE IF EXISTS public.estado CASCADE;
CREATE TABLE public.estado (
	id integer NOT NULL,
	estado_fisico varchar(45) NOT NULL,
	CONSTRAINT estado_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.estado OWNER TO postgres;
-- ddl-end --

-- object: estado_fk | type: CONSTRAINT --
-- ALTER TABLE public.producir DROP CONSTRAINT IF EXISTS estado_fk CASCADE;
ALTER TABLE public.producir ADD CONSTRAINT estado_fk FOREIGN KEY (id_estado)
REFERENCES public.estado (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.anio_periodo | type: TABLE --
-- DROP TABLE IF EXISTS public.anio_periodo CASCADE;
CREATE TABLE public.anio_periodo (
	anio integer NOT NULL,
	periodo varchar(45) NOT NULL,
	CONSTRAINT anio_periodo_pk PRIMARY KEY (anio,periodo)
);
-- ddl-end --
ALTER TABLE public.anio_periodo OWNER TO postgres;
-- ddl-end --

-- object: anio_periodo_fk | type: CONSTRAINT --
-- ALTER TABLE public.producir DROP CONSTRAINT IF EXISTS anio_periodo_fk CASCADE;
ALTER TABLE public.producir ADD CONSTRAINT anio_periodo_fk FOREIGN KEY (anio_anio_periodo,periodo_anio_periodo)
REFERENCES public.anio_periodo (anio,periodo) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.departamento | type: TABLE --
-- DROP TABLE IF EXISTS public.departamento CASCADE;
CREATE TABLE public.departamento (
	codigo integer NOT NULL,
	nombre varchar(45) NOT NULL,
	CONSTRAINT departamento_pk PRIMARY KEY (codigo)
);
-- ddl-end --
ALTER TABLE public.departamento OWNER TO postgres;
-- ddl-end --

-- object: departamento_fk | type: CONSTRAINT --
-- ALTER TABLE public.municipio DROP CONSTRAINT IF EXISTS departamento_fk CASCADE;
ALTER TABLE public.municipio ADD CONSTRAINT departamento_fk FOREIGN KEY (codigo_departamento)
REFERENCES public.departamento (codigo) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


