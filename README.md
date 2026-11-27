curae

Aplicación móvil de orientación médica general y repositorio offline con tutoría impulsada por Inteligencia Artificial.

Equipo: Apex Syndicate
Campus: Lomas Verdes

Alineación: ODS 10 (Reducción de las desigualdades) y ODS 11 (Ciudades y comunidades sostenibles).

Descripción general

curae es una plataforma móvil ligera diseñada para democratizar el acceso a la orientación sanitaria básica y al contenido médico técnico. Está enfocada en atender a adultos mayores, migrantes, estudiantes de primera generación y comunidades con baja conectividad o recursos limitados.

Combina un sistema de almacenamiento local mediante SQLite para realizar consultas sin conexión a internet con Google Gemini, configurado bajo un rol de tutor interactivo que acompaña paso a paso al usuario para resolver dudas informativas de manera clara y estructurada.

Características principales

Tutor y guía inteligente

Asistente conversacional impulsado por Google Gemini que traduce términos y procesos médicos complejos a un lenguaje accesible.

Modo offline y baja conectividad

Caché local y base de conocimientos en SQLite que permiten consultar guías médicas sin depender de una conexión permanente.

Contenido médico técnico

Repositorio curado de conceptos básicos de salud, prevención y utilidad práctica.

Acceso inmediato

Instalación directa mediante APK en dispositivos Android, sin procesos de registro ni barreras técnicas.

Diseño inclusivo y accesible

* Tipografía sans-serif de alta legibilidad.
* Contraste mínimo de 4.5:1 y superior a 7:1 en modo adulto mayor.
* Soporte bilingüe.
* Estados visuales claros de retroalimentación.

Arquitectura del sistema

El sistema está compuesto por cuatro elementos principales:

1. Usuario: interactúa con la aplicación para realizar consultas y acceder al contenido disponible.
2. Aplicación Android: desarrollada en Flutter, administra la interfaz y el almacenamiento en caché offline.
3. Backend Python y SQLite: recibe las peticiones HTTP, consulta la base de conocimientos y estructura el contexto médico.
4. Google Gemini: procesa las consultas mediante instrucciones especializadas para proporcionar orientación informativa.

Flujo de comunicación

flowchart LR
    U[Usuario] <-->|Consulta y lectura| A[App Android - curae]
    A <-->|Cache offline| L[(Repositorio local)]
    A <-->|Peticion HTTP| B[Backend Python + SQLite]
    B <-->|Contexto y prompt tutor| G[API Google Gemini]

Stack tecnológico

Capa	Tecnología	Función
Cliente móvil	Flutter	Interfaz Android y manejo de caché offline
Backend	Python 3	Servidor HTTP y lógica de integración
Base de datos	SQLite	Almacenamiento de contenido médico
Servidor y sistema operativo	Arch Linux	Entorno de ejecución del servidor
Cloud	Firebase	Servicios complementarios de infraestructura
Inteligencia artificial	Google Gemini	Procesamiento de lenguaje natural y tutoría guiada
Entornos de desarrollo	Android Studio, VS Code y VSCodium	Desarrollo, compilación y pruebas

Estructura del repositorio

curae/
|
|-- android_app/
|   |-- lib/
|   |   |-- Vistas accesibles
|   |   |-- Modelos
|   |   |-- Logica offline
|   |
|   |-- pubspec.yaml
|
|-- backend/
|   |-- server.py
|   |-- base.db
|   |-- gemini_tutor.py
|
|-- docs/
|   |-- Documentacion tecnica
|   |-- Diagramas
|   |-- Manuales
|
|-- README.md

Instalación y despliegue

1. Configuración del backend en Arch Linux

Instalar SQLite:

sudo pacman -S sqlite

Acceder al directorio del backend:

cd curae/backend

Configurar la clave API de Google Gemini:

export GEMINI_API_KEY="TU_API_KEY_AQUI"

Iniciar el servidor:

python server.py

El servidor utiliza el puerto 8000 y debe configurarse para escuchar en la interfaz de red correspondiente, permitiendo conexiones locales o desde dispositivos móviles conectados a la misma red.

2. Instalación de la aplicación en Android

1. Descargar el archivo curae.apk desde la sección Releases del repositorio.
2. Activar la instalación de aplicaciones de orígenes desconocidos en Android, cuando sea necesario.
3. Instalar el archivo APK.
4. Abrir curae desde la pantalla de inicio.

Guía rápida de uso

Explorar contenido offline

Abrir la sección Contenido de Utilidad para consultar guías médicas básicas y términos técnicos sin necesidad de conexión a internet.

Consultar al tutor

Ingresar al chat con el asistente, escribir una duda médica general en español o inglés y presionar Enviar.

Profundizar en los conceptos

Solicitar al asistente explicaciones paso a paso y utilizar lenguaje sencillo para comprender conceptos médicos complejos.

Aviso médico

La información proporcionada por curae tiene fines estrictamente educativos e informativos. No constituye un diagnóstico médico ni sustituye la valoración, atención o tratamiento de un profesional de la salud.

Equipo de desarrollo

Apex Syndicate

Campus Lomas Verdes

Proyecto enfocado en la accesibilidad tecnológica, la inclusión digital y la democratización de la información sanitaria.

