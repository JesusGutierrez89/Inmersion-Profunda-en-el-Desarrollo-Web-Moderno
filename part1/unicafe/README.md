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

## Funcionalidad implementada en 1.6:
- ✅ Tres botones para dar feedback: good, neutral, bad
- ✅ Contadores independientes para cada tipo de feedback
- ✅ Estado de React usando useState hooks
- ✅ Visualización en tiempo real de las estadísticas

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
- 1.7: Añadir estadísticas calculadas (total, promedio, porcentaje positivo)
- 1.8: Mostrar estadísticas solo cuando hay feedback
- 1.9-1.11: Refactorización con componentes

## Tecnologías utilizadas:
- React 18.3.1
- Vite 5.3.4
- ESLint para linting
- useState hook para manejo de estado