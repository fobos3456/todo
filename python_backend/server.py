import os
import sqlite3
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import uvicorn

app = FastAPI(title="Curae Medical Tutor Python Backend")

# Modelo de petición desde la app Flutter
class ChatRequest(BaseModel):
    pregunta: str
    idioma: str = "es"

# Inicializar Base de Datos SQLite Local del Servidor Python
def init_python_db():
    conn = sqlite3.connect("curae_server.db")
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS consultas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            pregunta TEXT,
            respuesta TEXT,
            idioma TEXT,
            fecha DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    """)
    conn.commit()
    conn.close()

init_python_db()

@app.get("/")
def home():
    return {"status": "ok", "message": "Servidor Python Curae activo en localhost"}

@app.post("/api/chat")
def responder_chat(req: ChatRequest):
    pregunta = req.pregunta.strip()
    if not pregunta:
        raise HTTPException(status_code=400, detail="Pregunta vacía")

    # Lógica de respuesta inteligente en Python (conectable a Gemini / LLM local o reglas médicas)
    if req.idioma == "es":
        respuesta = (
            f" Orientación del Servidor Python sobre '{pregunta}':\n\n"
            "1. Procura mantener reposo y una hidratación adecuada.\n"
            "2. Evita ingerir fármacos no recetados para este malestar.\n"
            "3. Si el síntoma empeora o hay dolor agudo, acude al centro de salud."
        )
    else:
        respuesta = (
            f" Python Server Guidance on '{pregunta}':\n\n"
            "1. Ensure rest and proper fluid intake.\n"
            "2. Avoid unprescribed medication for this condition.\n"
            "3. If symptoms worsen or severe pain occurs, visit a medical clinic."
        )

    # Registrar la consulta en la base de datos SQLite del servidor Python
    try:
      conn = sqlite3.connect("curae_server.db")
      cursor = conn.cursor()
      cursor.execute(
          "INSERT INTO consultas (pregunta, respuesta, idioma) VALUES (?, ?, ?)",
          (pregunta, respuesta, req.idioma)
      )
      conn.commit()
      conn.close()
    except Exception as e:
      print(f"Error guardando en SQLite servidor: {e}")

    return {
        "respuesta": respuesta,
        "pregunta": pregunta,
        "servidor": "Python FastAPI + SQLite"
    }

if __name__ == "__main__":
    print("🚀 Iniciando Servidor Python Curae en http://localhost:8000")
    uvicorn.run(app, host="0.0.0.0", port=8000)
