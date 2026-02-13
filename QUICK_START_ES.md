# QUICK START: Leaderboard Speedrun

**Configuración automática en 5 minutos** para streamers!  
🌐 **Nuevo**: ¡Interfaz disponible en 5 idiomas!

---

## ⚠️ Prerequisitos

**PowerShell 7 es requerido** (Solo Windows 10/11)

1. **Instalar PowerShell 7**:
   - Abrir Microsoft Store (Windows 10/11)
   - Buscar "PowerShell" (aplicación oficial de Microsoft)
   - Hacer clic en "Instalar"
   - O descargar desde: https://github.com/PowerShell/PowerShell/releases

2. **Asociar archivos .ps1 con PowerShell 7**:
   - Clic derecho en `main.ps1`
   - Seleccionar "Abrir con" → "Elegir otra aplicación"
   - Marcar "Siempre usar esta aplicación para abrir archivos .ps1"
   - Seleccionar "PowerShell 7" de la lista
   - Si no es visible: hacer clic "Más aplicaciones" y desplazarse

---

## Método automático (v1.20+)

### Primer uso
1. **Doble clic** en `main.ps1`
2. **Menú principal** se muestra automáticamente
3. **Navegar** con ↑↓ para seleccionar "Añadir un nuevo preset"
4. **Presionar Enter** para confirmar
5. **Introducir** el nombre del juego (ej: "Elden Ring")
6. **Navegar** ↑↓ y **Enter** para seleccionar el juego de la lista
7. **Elegir** Juego completo o Niveles (si está disponible)
8. **Si Niveles**: seleccionar el nivel
9. **Navegar** ↑↓ y **Enter** para elegir la categoría (Any%, 100%, etc.)
10. **Opcional**: subcategorías (se pueden elegir varias)
11. **Dar un ID** al preset (sugerencia automática proporcionada)
12. **Activar automáticamente** el preset (si es el primero)

**Resultado**: ¡preset guardado + activado automáticamente + URL copiada!

### Interfaz del menú principal (v1.20)
El script muestra un menú con navegación intuitiva en tu idioma:

```
================================================
  Gestor de Presets SRC by karlitto__
================================================

Presets existentes:
• Elden Ring - Any% Glitchless ✓ [ACTIVO]
  ID: eldenring-any
• Dark Souls III - All Bosses
  ID: darksouls3-all

📍 Preset actualmente activo: Elden Ring - Any% Glitchless

¿Qué te gustaría hacer?
► Añadir un nuevo preset
  Ver detalles de un preset existente
  Cambiar preset activo
  Eliminar un preset
  Definir nombre del jugador
  Configuración de idioma
  Salir del programa

Usa ↑↓ para navegar, Enter para seleccionar
```

### 🌐 Soporte multiidioma (v1.20)
La interfaz está disponible en **5 idiomas**:
- **🇫🇷 Français** (predeterminado)
- **🇺🇸 English**
- **🇪🇸 Español**
- **🇧🇷 Português**
- **🇨🇳 中文**

**Cambiar idioma**:
1. Menú principal → **Opción 6** "Configuración de idioma"
2. Navega con ↑↓ para elegir tu idioma
3. Presiona **Enter** → ¡Cambio inmediato!
4. El idioma se **guarda automáticamente**

### Opciones disponibles

**1. Añadir nuevo preset**: Crear nuevo preset (mismo flujo que la primera vez)  
**2. Ver detalles**: Ver detalles completos de un preset  
**3. Cambiar preset activo**: Seleccionar qué preset está activo en OBS  
**4. Eliminar preset**: Eliminar un preset (confirmación simple s/N)  
**5. Definir nombre del jugador**: Mostrar tu posicion en el leaderboard  
**6. Configuración de idioma**: Cambiar idioma de la interfaz (5 idiomas disponibles)  
**7. Salir**: Cerrar el programa

**Navegación**: Usa **↑↓** para moverte entre opciones  
**Selección**: Presiona **Enter** para confirmar  
**Volver**: Presiona **⌫ Backspace** cuando esté disponible  
**Confirmaciones**: Diálogo simple **sí/no** (s/N) - ¡sin escritura compleja!

### Usar en OBS
- **URL simple**: `leaderboard.html` (¡siempre la misma!)
- **Fuente del navegador**: Ancho 400, Alto 280
- **Actualización automática**: cada 30 segundos
- **Sin parámetros**: lee automáticamente el preset activo

---

## Problemas comunes

### Script PowerShell bloqueado
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### "Failed to fetch" al probar en navegador
**Normal**: limitaciones CORS. **¡Funciona perfectamente en OBS!**

---

**Consejo para streamers**: ¡Solo una URL en OBS (`leaderboard.html`)! ¡Cambia juegos con el script → **Opción 3** durante el stream!

**Consejo multiidioma**: ¡Configura una vez en tu idioma, todo se guarda automáticamente!