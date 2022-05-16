from winreg import QueryValueEx
import dash
import dash_core_components as dcc
import dash_html_components as html
import plotly.graph_objects as go
import plotly.express as px
import numpy as np
import pandas as pd
from Connection import Connection
import SQL as sql

## template= "plotly_dark"

external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']
# Inicializacion app dash
app = dash.Dash(__name__, external_stylesheets=external_stylesheets)

con = Connection()
con.openConnection()
query = pd.read_sql_query(sql.CantidadporMunicipio(), con.connection)
con.closeConnection()
dfCM = pd.DataFrame(query, columns=["nombre", "avg"])
figCM= px.bar(dfCM, x="nombre", y="avg", color = "nombre", template= "simple_white")

con.openConnection()
query = pd.read_sql_query(sql.Rendimiento(), con.connection)
con.closeConnection()
dfProm = pd.DataFrame(query, columns=["rendimiento", "departamento", "cultivo"])
figProm = px.sunburst(dfProm,path=["departamento", "cultivo"], values="rendimiento", template= "simple_white")

con.openConnection()
query = pd.read_sql_query(sql.Areasembradatransitorios(), con.connection)
con.closeConnection()
dfAspP =pd.DataFrame(query, columns=["periodo", "nombre", "area"])
figBarAsT = px.bar(dfAspP,y="area", x="nombre", color="periodo",barmode="group", template= "simple_white")

con.openConnection()
query = pd.read_sql_query(sql.Areasembradapermanentes(), con.connection)
con.closeConnection()
dfAspP =pd.DataFrame(query, columns=["periodo", "nombre", "area"])
figBarAsP = px.bar(dfAspP,x="nombre", y="area", color="periodo",barmode="group", template= "simple_white")

con.openConnection()
query = pd.read_sql_query(sql.DiferenciaAreas(), con.connection)
con.closeConnection()
dfDA =pd.DataFrame(query, columns=["area", "nombre", "anio"])
figDA = px.bar(dfDA,x = "anio", y="area", color="nombre",barmode="group", template= "simple_white")

con.openConnection()
query = pd.read_sql_query(sql.DiferenciaAreasgrupo(), con.connection)
con.closeConnection()
dfDG =pd.DataFrame(query, columns=["area", "nombre", "anio"])
figDG = px.bar(dfDG, x = "anio", y="area", color="nombre",barmode="group", template= "simple_white")

con.openConnection()
query = pd.read_sql_query(sql.Variacion(), con.connection)
con.closeConnection()
df19 = pd.DataFrame(query, columns=["departamento", "cultivo", "promedio"])
fig19 = px.bar(df19, x = "cultivo", y = "promedio", color="departamento", barmode="group", template= "simple_white")

con.openConnection()
query = pd.read_sql_query(sql.Diferencia(), con.connection)
con.closeConnection()
dfdf = pd.DataFrame(query, columns=["diferencia", "nombre"])
figdf =  px.bar(dfdf, x = "nombre", y = "diferencia", barmode="group", template= "simple_white")

con.openConnection()
query =  pd.read_sql_query(sql.tendencia(), con.connection)
con.closeConnection()
dften = pd.DataFrame(query, columns=["promedio", "nombre"])
print(query)
figf =  px.bar(dften,x = "nombre" ,y="promedio", template= "simple_white")

con.openConnection()
query =  pd.read_sql_query(sql.pastel(), con.connection)
con.closeConnection()
dfpastel = pd.DataFrame(query, columns=["nombre", "promedio", "ranking"])
figpastel = px.pie(dfpastel, values="promedio", names="nombre", template= "simple_white")


# Layo
app.layout = html.Div(
    children=[
        html.H1(
            children='Análisis EVA', 
            style={
                'textAlign': 'center'
            }
        ),
        html.H4(
            children='Mediante la base de datos se planea reconocer la participación de de los sectores productivos del país, teniendo en cuenta el comportamiento de sus actividades agrícolas. Asimismo, se debe tener en cuenta el tiempo en el que se ha ejecutado la producción, los rendimientos según ubicación, áreas de siembra en uso y tipos de cultivos, para así comprender de manera eficaz la base de datos y los resultados que proporciona a la misma',
            style= {
                'textAign': 'justify',
                'font-size':'14px'
            },
        ),
        html.Div(
            children=[
                html.H1(children='Cantidad por municipio'),
                dcc.Graph(
                    id='Cantidad por Municipio',
                    figure=figCM
                ),
            ]
        ),
        html.Div(
            children=[
                html.H1(children= 'Producción promedio'),
                dcc.Graph(
                    id='Produccion promedio',
                    figure = figProm
                ),
            ]
        ),
        html.Div(
            children=[
                html.H1(children='Variación'),
                dcc.Graph(
                    id='Variacion porcentual',
                    figure=fig19
                ),
            ]
        ),
        html.Div(
            children=[
                html.H1(children='Área sembrada por tipos de cultivos'),
                html.Div(
                    children=[
                        html.H2(children='Transitorios'),
                        dcc.Graph(
                            id='Area Sembrada Transitorios',
                            figure=figBarAsT
                        ),
                    ]
                ),
                html.Div(
                    children=[
                        html.H2(children='Permanentes'),
                        dcc.Graph(
                            id='Area Sembrada Permanentes',
                            figure=figBarAsP
                        ),
                    ]
                ),
            ]
        ),
        html.Div(
            children=[
                html.H2(children='Tendencia'),
                dcc.Graph(
                    id='Tendencia de cultivo',
                    figure=figf
                )
            ]
        ),
        html.Div(
            children=[
                html.H1(children='Diferencias de áreas'),
                html.Div(
                    children = [
                        html.H3(children='Diferencias'),
                            dcc.Graph(
                                id='Dirferencias entre cultivos',
                                figure=figdf
                        ),
                    ]
                ),
                html.Div(
                    children=[
                        html.H2(children='Diferencia de área por sub grupos'),
                        dcc.Graph(
                            id='diferencia de area',
                            figure=figDA
                        ),
                    ]
                ),
                html.Div(
                    children=[
                        html.H2(children='Diferencia de área por grupo'),
                        dcc.Graph(
                            id='diferencia de area por grupo',
                            figure=figDG
                        ),
                    ]
                ),
            ]
        ),
        html.Div(
            children=[
                html.H3(children='Niveles de producción agrícola'),
                dcc.Graph(
                    id='producción de los departamentos',
                    figure=figpastel
                )
            ]
        ),
    ]   
)

if __name__ == '__main__':
    app.run_server(debug=True)
