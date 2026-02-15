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

## Paso 6: Añadir Filtro de Sombra (Muy Recomendado)

**Para mejor legibilidad del texto y aspecto profesional:**

1. Instala el plugin **OBS Stroke Glow Shadow**: https://github.com/FiniteSingularity/obs-stroke-glow-shadow
2. Haz clic derecho en tu fuente del navegador de clasificación en OBS
3. Selecciona **Filtros** → **Añadir** → **Shadow**
4. Ajusta la configuración de sombra según tus preferencias

¡Esto mejora enormemente la visibilidad del texto sobre cualquier fondo!

---

## Funciones avanzadas

**Para conocer todas las funciones disponibles** (ajustes visuales, fuentes personalizadas, formatos de tiempo, alineación de rangos, efecto arcoíris en PB recientes, etc.), consulta el **[README.md](README.md)** completo!