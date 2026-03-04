import requests
import sqlite3
from datetime import datetime

latitude = 51.5085
longitude = -0.1257

url = (
    f"https://api.open-meteo.com/v1/forecast?"
    f"latitude={latitude}&"
    f"longitude={longitude}&"
    f"current_weather=true&"
    f"timezone=auto"
)

response = requests.get(url)

if response.status_code != 200:
    print("Erro ao acessar a API.")
    exit()

data = response.json()
current = data["current_weather"]

temperatura = current["temperature"]
vento = current["windspeed"]
codigo = current["weathercode"]
data_medicao = datetime.fromisoformat(current["time"])

conn = sqlite3.connect("dadosclima.db")
cursor = conn.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS local_clima (
    id_local INTEGER PRIMARY KEY AUTOINCREMENT,
    latitude REAL,
    longitude REAL,
    timezone TEXT
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS clima (
    id_clima INTEGER PRIMARY KEY AUTOINCREMENT,
    descricao TEXT,
    categoria TEXT,
    nivel_intensidade INTEGER
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS medicao (
    id_medicao INTEGER PRIMARY KEY AUTOINCREMENT,
    horario TEXT,
    temperatura REAL,
    velocidade_vento REAL,
    id_clima INTEGER,
    id_local INTEGER,
    FOREIGN KEY (id_clima) REFERENCES clima(id_clima),
    FOREIGN KEY (id_local) REFERENCES local_clima(id_local)
)
""")

conn.commit()

cursor.execute(
    "SELECT id_local FROM local_clima WHERE latitude=? AND longitude=?",
    (latitude, longitude)
)

resultado = cursor.fetchone()

if resultado:
    id_local = resultado[0]
else:
    cursor.execute(
        "INSERT INTO local_clima (latitude, longitude, timezone) VALUES (?, ?, ?)",
        (latitude, longitude, "auto")
    )
    conn.commit()
    id_local = cursor.lastrowid

descricao = f"Código {codigo}"

cursor.execute(
    "SELECT id_clima FROM clima WHERE descricao=?",
    (descricao,)
)

resultado = cursor.fetchone()

if resultado:
    id_clima = resultado[0]
else:
    cursor.execute(
        "INSERT INTO clima (descricao, categoria, nivel_intensidade) VALUES (?, ?, ?)",
        (descricao, "Não definido", 1)
    )
    conn.commit()
    id_clima = cursor.lastrowid


cursor.execute("""
    INSERT INTO medicao
    (horario, temperatura, velocidade_vento, id_clima, id_local)
    VALUES (?, ?, ?, ?, ?)
""", (
    data_medicao.strftime("%H:%M:%S"),
    temperatura,
    vento,
    id_clima,
    id_local
))

conn.commit()

print("Dados inseridos com sucesso!")

cursor.close()
conn.close()