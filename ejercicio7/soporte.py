from IPython.core.interactiveshell import InteractiveShell # Nos permite mostar más de una salida por celda
InteractiveShell.ast_node_interactivity = "all" # Nos permite mostar más de una salida por celda

import requests
import pandas as pd
import numpy as np
import datetime



class Extraccion:

    def __init__(self):

        self = self
        
    def api_nacional(self, año_inicio, año_final, df_vacio):

        self.año_inicio = año_inicio
        self.año_final = año_final
        self.df_vacio = df_vacio

        for año in range(año_inicio, año_final):
            
            response = requests.get(f'https://apidatos.ree.es/es/datos/generacion/evolucion-renovable-no-renovable?start_date={año}-01-01T00:00&end_date={año}-12-31T23:59&time_trunc=year')

            response.status_code

            response.reason

            df_renovables = pd.json_normalize(response.json()['included'][0]['attributes']['values'])
            df_renovables ['tipo_energía'] = "Renovable"

            df_vacio = pd.concat([df_vacio, df_renovables], axis = 0)

            df_no_renovables = pd.json_normalize(response.json()['included'][1]['attributes']['values']) 
            df_no_renovables ['tipo_energía'] = "No_renovable"

            df_vacio = pd.concat([df_vacio, df_no_renovables], axis = 0)
            
        return df_vacio
    

    def api_ccaa(self,año_inicio,año_final, diccionario, df_vacio):

        self.diccionario = diccionario
        self.año_inicio = año_inicio
        self.año_final = año_final
        self.df_vacio = df_vacio

        for año in range(año_inicio,año_final):

            for k, v in diccionario.items():
                    
                response = requests.get(f'https://apidatos.ree.es/es/datos/generacion/evolucion-renovable-no-renovable?start_date={año}-01-01T00:00&end_date={año}-12-31T23:59&time_trunc=year&geo_trunc=electric_system&geo_limit=ccaa&geo_ids={v}')

                response.status_code
                
                response.reason
            
                if len(response.json()['included']) == 2:
                    renovables_ccaa = pd.json_normalize(response.json()['included'][0]['attributes']['values']) #renovables
                    renovables_ccaa ['tipo_energía'] = "Renovable"
                    renovables_ccaa ['comunidad'] = k 
                    renovables_ccaa ['id_comunidad'] = v
                
                    df_vacio = pd.concat([df_vacio, renovables_ccaa], axis = 0)

                    no_renovables_ccaa = pd.json_normalize(response.json()['included'][1]['attributes']['values']) #excepción
                    no_renovables_ccaa ['tipo_energía'] = "No_renovable"
                    no_renovables_ccaa ['comunidad'] = k 
                    no_renovables_ccaa ['id_comunidad'] = v

                    df_vacio = pd.concat([df_vacio, no_renovables_ccaa], axis = 0)

                else:
                    no_renovables_ccaa1 = pd.json_normalize(response.json()['included'][0]['attributes']['values']) #excepción
                    no_renovables_ccaa1 ['tipo_energía'] = "No_renovable"
                    no_renovables_ccaa1 ['comunidad'] = k 
                    no_renovables_ccaa1 ['id_comunidad'] = v

                    df_vacio = pd.concat([df_vacio, no_renovables_ccaa1], axis = 0)

        return df_vacio
    



cod_comunidades = {'Ceuta': 8744,
                    'Melilla': 8745,
                    'Andalucía': 4,
                    'Aragón': 5,
                    'Cantabria': 6,
                    'Castilla - La Mancha': 7,
                    'Castilla y León': 8,
                    'Cataluña': 9,
                    'País Vasco': 10,
                    'Principado de Asturias': 11,
                    'Comunidad de Madrid': 13,
                    'Comunidad Foral de Navarra': 14,
                    'Comunitat Valenciana': 15,
                    'Extremadura': 16,
                    'Galicia': 17,
                    'Illes Balears': 8743,
                    'Canarias': 8742,
                    'Región de Murcia': 21,
                    'La Rioja': 20}



class Limpieza:
    
    def __init__(self, df):
        
        self= self
        self.df = df
    
    def redondeo(self, columna):

        self.columna = columna
        self.df[columna] = [round(float(values),2) for values in self.df[columna]]
        return self.df
    
    
    def eliminar_columna (self, columna):
        self.columna = columna

        self.df.drop([columna], axis= 1, inplace= True)
        return self.df
    
    def cambiar_datetime(self, columna):
        self.columna = columna

        self.df['fecha'] = self.df[columna].str.split("T", expand = True, n=1).get(0)
        self.df["fecha"] = pd.to_datetime(self.df["fecha"])
        self.df.drop([columna], axis = 1, inplace= True)
        return self.df
        