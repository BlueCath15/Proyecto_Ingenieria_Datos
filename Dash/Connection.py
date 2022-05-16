import psycopg2


class Connection:
    
    def __init__(self):
        self.connection = None
    
    def openConnection(self):
        try:
            self.connection = psycopg2.connect(host = "proyectoid.postgres.database.azure.com", 
                                        dbname = "pf",
                                        user = "josemtorres@proyectoid",
                                        password = "C4t4C4th3J0s3",
                                        sslmode = "require")
        except Exception as e:
            print (e)

    def closeConnection(self):
        self.connection.close()
