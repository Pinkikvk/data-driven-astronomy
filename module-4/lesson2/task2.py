import numpy as np
import psycopg2

def column_stats(table_name, column_name):
    conn = psycopg2.connect(dbname='db', user='grok')
    cursor = conn.cursor()
    cursor.execute(f'SELECT {column_name} FROM {table_name}')
    records = cursor.fetchall()
    
    array = np.array(records)
    return (np.mean(array), np.median(array))