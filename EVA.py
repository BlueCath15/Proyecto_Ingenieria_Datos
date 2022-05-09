import sqlite3
import psycopg2

try:
    conexion = psycopg2.connect(user="postgres",
                                password="2809",
                                database="proyecto",
                                host="localhost",
                                port="5432")
    print("Conexión correcta!")
    
    sql1 = """select *
         from departamento
         order by 1;"""
    
#Se ejecuta la sentencia para mostrar los nombres de los departamentos
    cursor = conexion.cursor()
    cursor.execute(sql1)
    country = cursor.fetchone()
    
    print("****DEPERATAMENTOS****")
    while country:
        print(country[0], country[1])
        country = cursor.fetchone()

    print("****MUNICIPIOS****")
    sql =  """select *
                from municipo 
                order by 1;"""
    cursor.execute(sql)
    municipio =  cursor.fetchone()
    for municipio in cursor:
        print(municipio)
        
    print("***GRUPOS***")	
    sql3 = """select *
		from grupo
		order by 1;"""
		
    cursor.execute(sql3)
    grupo = cursor.fetchone()
    while grupo:
        print(grupo)
        grupo = cursor.fetchone()
    print("***ESTADOS***")
    sql4 = """select *
            from estado
            order by 1;"""
            
    cursor.execute(sql4)
    estado = cursor.fetchone()
    while estado:
        print(estado)
        estado = cursor.fetchone()
        
    print("***CICLOS***")
    sql5 = """select *
            from ciclo_cultivo
            order by 1;"""
            
    cursor.execute(sql5)
    ciclo = cursor.fetchone()
    while ciclo:
        print(ciclo)
        ciclo = cursor.fetchone()
        
    print("***ANIO_PERIODO***")
    sql6 = """select *
            from anio_periodo
            order by 1;"""
            
    cursor.execute(sql6)
    anio_periodo = cursor.fetchone()
    while anio_periodo:
        print(anio_periodo)
        anio_periodo = cursor.fetchone()

    print("***CULTIVOS***")
    sql8 = """select *
            from cultivo
            order by 1;"""
            
    cursor.execute(sql8)
    cultivos = cursor.fetchone()
    while cultivos:
        print(cultivos)
        cultivos = cursor.fetchone()

    sql9 =  """ select * from subgrupo order by 1;"""
    cursor.execute(sql9)
    subgrupo =  cursor.fetchone()
    for subgrupo in cursor:
        print(subgrupo)

    print("****PRODUCIR****")
    sql7 = """select * from produccion order by 1;"""
    cursor.execute(sql7)
    producir = cursor.fetchone()
    while producir:
        print(producir)
        producir =  cursor.fetchone()

except psycopg2.Error as e:
    print("Ocurrió un error al consultar: ", e)

finally:
    cursor.close()
    conexion.close()
