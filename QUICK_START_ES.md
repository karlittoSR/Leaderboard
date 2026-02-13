# Guía de Inicio Rápido

**Obtén tu clasificación speedrun en OBS en 5 minutos**

---

## Paso 1: Instalar PowerShell 7

1. Descarga desde: https://github.com/PowerShell/PowerShell/releases/
2. Elige la **última versión estable** (etiqueta verde)
3. Descarga e instala el archivo `.msi` para tu sistema

## Paso 2: Corregir Acceso

1. Descarga todos los archivos: `configure.ps1`, `leaderboard.html`, `config.json`, `FIX_ACCESS.bat`
2. Colócalos en la misma carpeta
3. **Haz doble clic en `FIX_ACCESS.bat`** - corrige todo automáticamente

## Paso 3: Añadir Tu Juego

1. Haz doble clic en `configure.ps1` o continúa con la última opción de `FIX_ACCESS.bat`.
2. Selecciona **"Añadir un nuevo preset"**
3. Escribe el nombre de tu juego (ej: "Elden Ring")
4. Elige tu juego de la lista
5. Selecciona la categoría (Any%, 100%, etc.)
6. Dale un nombre y actívalo
7. Puedes cerrar el programa.

## Paso 4: Establecer Tu Nombre (Opcional)

1. Selecciona **"Definir mi nombre"**
2. Introduce exactamente tu nombre de usuario de speedrun.com
3. Esto habilita la función de PB temporal - omite si no es necesario

## Paso 5: Añadir a OBS

1. Añade una **Fuente del Navegador**
2. **Archivo Local** → busca `leaderboard.html`
3. **Ancho**: 400px
4. **Alto**: 250px
5. **¡Listo!**

Tu clasificación se actualizará automáticamente y mostrará tu posición en la parte inferior en una fila separada cuando estés fuera del top 3.

---

**¿Necesitas más funciones?** Consulta el README.md completo para el sistema de PB temporal, múltiples presets y configuración avanzada.