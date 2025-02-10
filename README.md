# record_voice_app

Reproductor de audio Flutter que utiliza Firebase Storage para almacenar y reproducir archivos de audio con gestión de estado mediante Riverpod.

## Características Principales 🚀
- Reproducción de audio desde Firebase Storage
- Control de reproducción (Play/Pause/Stop)
- Barra de progreso interactiva
- Gestión de estado con Riverpod
- Manejo de errores y carga
- Soporte para Android e iOS
- Integración con Firebase


## Requisitos Previos 📋
- Flutter SDK 3.0+
- Cuenta de Firebase
- Android Studio/Xcode (para configuración de plataformas)
- Dispositivos

### 🚀 Instalación y Configuración

### 1️⃣ Clonar el repositorio
git clone https://github.com/danielserna23/record_voice_app.git



### 2️⃣ Instalar dependencias

  flutter pub get


### 3️⃣ Configurar Firebase

🔹 Crear un Proyecto en Firebase 

   - Ve a la [consola de Firebase](https://console.firebase.google.com/) e inicia sesión con tu cuenta de Google.
   - Haz clic en "Añadir proyecto".
   - Ingresa un nombre para tu proyecto (por ejemplo, "reproductor-audio-firebase") y sigue los pasos para crearlo.

### 4️⃣ Configurar Firebase Storage

   - En la consola de Firebase, ve a Storage y habilita el almacenamiento.
   -  Define las reglas de seguridad para permitir el acceso: (Para pruebas debe ser sin autenticación)

```
   rules_version = '2';
    service firebase.storage {
        match /b/{bucket}/o {
            match /{allPaths=**} {
            allow read, write: if request.time < timestamp.date(2025, 3, 11);
            }
        }
    }
 ```   

   - Ejecuta el siguiente comando en la terminal para inicializar Firebase en tu proyecto:
    ```   
        flutterfire configure
    ```   

   - Ejecuta la aplicación:
    ```   
        flutter run
    ```   

