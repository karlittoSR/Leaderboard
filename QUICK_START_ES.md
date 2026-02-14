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

## Funciones adicionales
- Menú de ajustes visuales en el gestor de presets para cambiar diseño, fuentes, espaciado, efectos, banderas/trofeos y carrusel.
- Nueva opción `fontStyle` para elegir la familia de fuente del overlay.
- Alineación y prefijo del rango configurables (`rankAlign`, `rankPrefixMode`).
- Mejor gestión de nombres con `maxNameWidthVisible` y texto desplazable para nombres largos.
- El PB temporal puede mostrarse incluso si tu cuenta aún no aparece en el leaderboard (usando `playerName` / `playerCountry`).
- Efecto arcoíris para nuevos PB de los últimos 5 días, con `rainbowIntensity` ajustable.
- Ancho de la barra separadora bajo tu fila personal configurable (`pbSeparatorWidth`).
- Formato de tiempo opcional `1h25m25s225ms` además de `1:25:25.255`.
- Opción en el script para restablecer fácilmente `config.json` a los valores por defecto si algo se rompe.
- Traducciones revisadas para FR/EN/ES/PT/ZH, incluido el nuevo menú de parámetros/visuales.
- Mejor visualización de banderas con espaciado consistente, icono de globo por defecto y soporte de `flagOverrides`.

**¿Necesitas más funciones?** Consulta el README.md completo para el sistema de PB temporal, múltiples presets y configuración avanzada.