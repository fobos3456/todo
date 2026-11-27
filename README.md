# <div align="center">

# 

# curae

# 

# Aplicación móvil de orientación médica general y repositorio offline con tutoría impulsada por Inteligencia Artificial.

# 

# Equipo: Apex Syndicate · Campus: Lomas Verdes  

# Alineación:\* ODS 10 (Reducción de las desigualdades) \& ODS 11 (Ciudades y comunidades sostenibles)

# 

# </div>

# 

# \---

# 

# 📋 Descripción General

# 

# curae es una plataforma móvil ligera diseñada para democratizar el acceso a la orientación sanitaria básica y contenido médico técnico. Está enfocada en atender a adultos mayores, migrantes, estudiantes de primera generación y comunidades con baja conectividad o recursos limitados.

# 

# Combina un sistema de almacenamiento local en SQLite para consultas sin internet con Google Gemini, configurado bajo un rol de tutor interactivo que acompaña paso a paso al usuario para resolver dudas informativas de manera clara y estructurada.

# 

# \---

# 

# Características Principales

# 

# \-Tutor y Guía Inteligente: Asistente conversacional impulsado por Google Gemini que traduce términos y procesos médicos complejos a un lenguaje accesible.

# \-Modo Offline y Baja Conectividad:\* Caché local y base de conocimientos en SQLite que permiten leer guías médicas sin depender de conexión permanente.

# \-Contenido Médico Técnico: Repositorio curado de conceptos básicos de salud, prevención y utilidad práctica.

# \-Acceso Inmediato: Instalación directa vía APK en Android sin procesos de registro ni barreras técnicas.

# \-Diseño Inclusivo y Accesible:

# &#x20; - Tipografía sans-serif de alta legibilidad.

# &#x20; - Contraste mínimo de \*4.5:1 y superior a 7:1 en modo adulto mayor.

# &#x20; - Soporte bilingüe con estados visuales claros de retroalimentación.

# 

# \---

# 

# Arquitectura del Sistema

# 

# mermaid

# flowchart LR

# &#x20;   U\[👤 Usuario] <-->|1. Consulta / Lectura| A\[📱 App Android - curae]

# &#x20;   A <-->|2. Caché Offline| L\[(🗄️ Repositorio Local)]

# &#x20;   A <-->|3. Petición HTTP| B\[🐍 Backend Python + SQLite]

# &#x20;   B <-->|4. Contexto + Prompt Tutor| G\[✨ API Google Gemini]

# 

# 

# 1.Capa de Presentación: Interfaz móvil en Flutter para Android con gestión de caché local.

# 2\. Capa de Lógica e Integración: Servidor en Python encargado de enrutar consultas y estructurar el contexto médico.

# 3\. Almacenamiento: Base de datos SQLite desplegada sobre Arch Linux, complementada con servicios de Firebase.

# 4\. Servicios de IA: Integración con Google Gemini mediante prompts especializados en orientación sanitaria.

# 

# \---

# 

# Stack Tecnológico

# 

# | Capa | Tecnología | Función |

# | :--- | :--- | :--- |

# | Cliente Móvil | Flutter | Interfaz de usuario Android y manejo de caché offline |

# | Backend | Python 3 | Servidor HTTP local y lógica de integración |

# | Base de Datos | SQLite (sqlite3) | Almacenamiento ligero de contenido médico |

# | Servidor / SO | Arch Linux | Entorno de ejecución del servidor y base de datos |

# | Cloud | Firebase | Servicios complementarios de infraestructura |

# | Inteligencia Artificial | Google Gemini | Procesamiento de lenguaje natural y tutoría guiada |

# | IDEs | Android Studio, VS Code, VSCodium | Desarrollo, compilación y pruebas |

# 

# \---

# 

# Estructura del Repositorio

# 

# text

# curae/

# ├── android\_app/                Código fuente de la aplicación móvil (Flutter)

# │   ├── lib/                    Vistas accesibles, modelos y lógica offline

# │   └── pubspec.yaml            Dependencias del proyecto

# ├── backend/                    Servidor local y base de conocimientos

# │   ├── server.py               Servidor HTTP en Python

# │   ├── base.db                 Base de datos SQLite

# │   └── gemini\_tutor.py         Integración y prompts de Google Gemini

# ├── docs/                       Documentación técnica, diagramas y manuales

# └── README.md                   Documentación principal del proyecto

# 

# 

# \---

# 

# Instalación y Despliegue

# 

# 1\. Configurar el Backend en Arch Linux

# 

# Instala SQLite y levanta el servidor local:

# 

# bash

# 1\. Instalar la herramienta de línea de comandos de SQLite

# sudo pacman -S sqlite

# 

# 2\. Entrar al directorio del backend

# cd curae/backend

# 

# 3\. Exportar tu clave de API de Google Gemini

# export GEMINI\_API\_KEY="TU\_API\_KEY\_AQUI"

# 

# 4\. Iniciar el servidor local en el puerto 8000

# python server.py

# 

# 

# > \[!NOTE]

# > El servidor escuchará por defecto en http://0.0.0, permitiendo conexiones locales (localhost) o desde dispositivos móviles dentro de la misma red local.

# 

# 2\. Instalar la App en Android

# 

# 1\. Descarga el archivo curae.apk desde la sección de Releases del repositorio.

# 2\. En tu dispositivo Android, activa \*Instalar aplicaciones de orígenes desconocidos.

# 3\. Instala el APK y abre curae directamente desde tu pantalla de inicio.

# 

# \---

# 

# Guía Rápida de Uso

# 

# 1.Explorar contenido offline:\* Abre la sección Contenido de Utilidad para consultar guías médicas básicas y términos técnicos sin gastar datos.

# 2.Consultar al tutor: Ingresa al chat con el guía, escribe tu duda médica general en español o inglés y presiona Enviar.

# 3.Profundizar: Si algún concepto resulta complejo, pide al asistente que lo explique paso a paso con palabras más sencillas.

# 

# \---

# 

# > \[!CAUTION]

# > Aviso Médico: La información proporcionada por curae tiene fines estrictamente educativos e informativos. No constituye diagnóstico médico ni sustituye la valoración de un profesional de la salud.

