# Unicafe - Full Stack Open Exercises

## Descripción
Aplicación de feedback para recopilar comentarios de usuarios sobre la calidad del servicio en un café.
Proyecto completo de React con Vite para los ejercicios 1.6-1.11 del curso Full Stack Open.

## Instalación y ejecución

```bash
# Instalar dependencias
npm install

# Ejecutar en modo desarrollo
npm run dev

# Construir para producción
npm run build
```

## Funcionalidad implementada:

### 1.6:
- ✅ Tres botones para dar feedback: good, neutral, bad
- ✅ Contadores independientes para cada tipo de feedback
- ✅ Estado de React usando useState hooks
- ✅ Visualización en tiempo real de las estadísticas

### 1.7:
- ✅ **Estadísticas calculadas expandidas:**
  - `all`: Total de todos los feedbacks
  - `average`: Promedio ponderado (good=1, neutral=0, bad=-1)
  - `positive`: Porcentaje de feedback positivo
- ✅ **Manejo de división por cero** con operador OR
- ✅ **Cálculos dinámicos** que se actualizan en tiempo real

### 1.8:
- ✅ **Refactorización con componente Statistics:**
  - Extraído componente `Statistics` separado
  - Estado permanece en componente raíz `App`
  - Statistics recibe props: `good`, `neutral`, `bad`
  - Separación de responsabilidades mejorada
- ✅ **Arquitectura modular:** Componentes reutilizables
- ✅ **Mantenimiento de funcionalidad:** Todas las estadísticas funcionan igual

### 1.9:
- ✅ **Renderizado condicional de estadísticas:**
  - Solo muestra estadísticas cuando hay feedback (total > 0)
  - Sin feedback: muestra "No feedback given"
  - Con feedback: muestra todas las estadísticas completas
- ✅ **Lógica if/else limpia:** Mejora en la estructura del código
- ✅ **Variable total optimizada:** Evita cálculos repetidos
- ✅ **UX mejorada:** Interface más clara y precisa

### 1.10:
- ✅ **Refactorización con componentes Button y StatisticLine:**
  - Componente `Button`: Reutilizable para todos los botones
    * Props: `handleClick` (función) y `text` (string)
  - Componente `StatisticLine`: Muestra una estadística individual
    * Props: `text` (etiqueta) y `value` (valor)
  - Statistics usa múltiples StatisticLine para cada estadística
  - App usa múltiples Button para cada acción
- ✅ **Código más modular:** Componentes pequeños y reutilizables
- ✅ **Estado en App:** Mantiene el estado en el componente raíz
- ✅ **Funcionalidad preservada:** Todo funciona exactamente igual

## Estructura del proyecto:
```
unicafe/
├── src/
│   ├── App.jsx          # Componente principal
│   └── main.jsx         # Punto de entrada
├── public/
│   └── vite.svg         # Icono de Vite
├── package.json         # Dependencias y scripts
├── vite.config.js       # Configuración de Vite
├── eslint.config.js     # Configuración de ESLint
└── index.html           # Template HTML
```

## Estructura del componente:
- Estados separados: `good`, `neutral`, `bad`
- Manejadores de eventos para incrementar contadores
- Interfaz simple con botones y visualización de estadísticas

## Próximos pasos:
- 1.11: Refactorización usando un solo estado objeto

## Tecnologías utilizadas:
- React 18.3.1
- Vite 5.3.4
- ESLint para linting
- useState hook para manejo de estado