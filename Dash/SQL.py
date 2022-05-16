def CantidadporMunicipio():
    return """select departamento.nombre, avg(produccion.cantidad)::numeric(10,2)
                from produccion inner join municipio on (id_municipio = municipio.id) inner join departamento on (departamento.id = id_departamento)
                group by 1
                order by 1;"""
            
def Rendimiento():
    return """select cantidad/area_cosechada as rendimiento, departamento.nombre as departamento, cultivo.nombre as cultivo
                from (produccion left join departamento left join municipio on(departamento.id = municipio.id_departamento) on (id_municipio = municipio.id) left join cultivo on (codigo_cultivo = cultivo.codigo))
                where area_cosechada > 0 and periodo_anio_periodo = '2019A';"""

def Areasembradatransitorios():
    return """select periodo_anio_periodo as periodo, cultivo.nombre as nombre, sum(area_sembrada) as area
                from produccion inner join cultivo on(codigo_cultivo = cultivo.codigo)
                where periodo_anio_periodo = '2019A' or periodo_anio_periodo = '2019B' 
				or periodo_anio_periodo = '2020A' or periodo_anio_periodo = '2020B'
				and cultivo.id_ciclo_cultivo = 1
                group by periodo_anio_periodo, cultivo.nombre
                order by cultivo.nombre asc"""

def Areasembradapermanentes():
    return """select periodo_anio_periodo as periodo, cultivo.nombre as nombre, sum(area_sembrada) as area
                from produccion inner join cultivo on(codigo_cultivo = cultivo.codigo)
                where periodo_anio_periodo = '2019A' or periodo_anio_periodo = '2019B' 
				or periodo_anio_periodo = '2020A' or periodo_anio_periodo = '2020B'
				and cultivo.id_ciclo_cultivo = 2
                group by periodo_anio_periodo, cultivo.nombre
                order by cultivo.nombre asc"""

def DiferenciaAreas():
    return """select sum(area_sembrada-area_cosechada) as area, subgrupo.nombre, produccion.anio_anio_periodo as anio
                from (produccion left join departamento left join municipio on(departamento.id = municipio.id_departamento) 
                    on(id_municipio = municipio.id) left join cultivo on(codigo_cultivo = cultivo.codigo) 
                    left join subgrupo on(subgrupo.id = cultivo.id_subgrupo) left join grupo on(subgrupo.id_grupo = grupo.id))
                where anio_anio_periodo = '2020' or periodo_anio_periodo = '2019'
                group by subgrupo.nombre, produccion.anio_anio_periodo
                order by area desc;"""
                
def DiferenciaAreasgrupo():
    return """select sum(area_sembrada-area_cosechada) as area, grupo.nombre, produccion.anio_anio_periodo as anio
                from (produccion left join cultivo on(codigo_cultivo = cultivo.codigo) 
                left join subgrupo on(subgrupo.id = cultivo.id_subgrupo) left join grupo on(subgrupo.id_grupo = grupo.id))
                where anio_anio_periodo = '2020' or periodo_anio_periodo = '2019'
                group by grupo.nombre, produccion.anio_anio_periodo
                order by area desc;"""

def Variacion():
    return """select departamento.nombre as departamento, grupo.nombre as cultivo, avg(((area_sembrada-area_1.a1)*100/area_1.a1)) as promedio
                from (select area_sembrada a1
                    from produccion
                    where periodo_anio_periodo = '2019A' and area_sembrada > 0) as area_1, (produccion left join departamento left join municipio on(departamento.id = municipio.id_departamento) 
                                    on(id_municipio = municipio.id) left join cultivo on(codigo_cultivo = cultivo.codigo) 
                                    left join subgrupo on(subgrupo.id = cultivo.id_subgrupo) left join grupo on(subgrupo.id_grupo = grupo.id))
                where periodo_anio_periodo = '2019B' and area_sembrada > 0
                group by departamento.nombre, grupo.nombre
                order by departamento.nombre;"""

def Diferencia():
    return """select sum(area_sembrada - area_cosechada) as diferencia, cultivo.nombre
                from (produccion inner join cultivo on (cultivo.codigo =  codigo_cultivo))
                group by cultivo.nombre
                order by cultivo.nombre;"""

def pastel():
    return """SELECT d.nombre, avg(cantidad)::numeric(10,2) promedio, RANK()OVER (
                    ORDER BY avg(cantidad) desc) ranking
                FROM departamento d INNER JOIN municipio m ON (d.id = m.id_departamento)
                JOIN produccion p ON (m.id = p.id_municipio) 
                GROUP BY d.nombre;"""

def tendencia():
    return """select avg(cantidad)::numeric(10,2) as promedio, grupo.nombre as grupo
                from produccion left join cultivo on (cultivo.codigo = codigo_cultivo) left join   subgrupo on (cultivo.id_subgrupo =  subgrupo.id) left join  grupo on (subgrupo.id_grupo =  grupo.id)
                group by grupo.nombre;"""
