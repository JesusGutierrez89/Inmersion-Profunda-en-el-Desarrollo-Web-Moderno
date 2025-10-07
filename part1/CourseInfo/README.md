# Ejercicio 1.1-1.2: CourseInfo

Este proyecto contiene los ejercicios 1.1 y 1.2 del curso Full Stack Open Helsinki.

## Descripción

Una aplicación React que muestra información del curso utilizando componentes y props.

### Ejercicio 1.1: Information of course, step1
- Refactorizar el componente App usando tres nuevos componentes: Header, Content y Total
- El componente Header se encarga del nombre del curso
- Content renderiza las partes y su número de ejercicios  
- Total muestra el número total de ejercicios

### Ejercicio 1.2: Information of course, step2
- Refactorizar el componente Content para usar un componente Part que renderiza el nombre y número de ejercicios de una parte

## Características

✅ **Componentes implementados:**
- `Header`: Muestra el título del curso
- `Content`: Contiene las tres partes del curso
- `Part`: Muestra una parte individual del curso
- `Total`: Muestra el total de ejercicios

✅ **Funcionalidades:**
- Muestra información en inglés y español
- Calcula automáticamente el total de ejercicios
- Usa props para pasar datos entre componentes

## Estructura de componentes

```
App
├── Header (course)
├── Content
│   ├── Part (part1, exercises1)
│   ├── Part (part2, exercises2)
│   └── Part (part3, exercises3)
└── Total (total)
```

## Instalación y uso

```bash
# Instalar dependencias
npm install

# Ejecutar en modo desarrollo
npm run dev

# Construir para producción
npm run build
```

## Tecnologías utilizadas

- React 19.1.1
- Vite 5.4.20
- ESLint para linting

## Estado del proyecto

✅ Ejercicio 1.1 - Completado
✅ Ejercicio 1.2 - Completado

---

*Curso: Full Stack Open - Universidad de Helsinki*
*Estudiante: Jesús Gutiérrez*
*Fecha: Octubre 2025*

## React Compiler

The React Compiler is not enabled on this template because of its impact on dev & build performances. To add it, see [this documentation](https://react.dev/learn/react-compiler/installation).

## Expanding the ESLint configuration

If you are developing a production application, we recommend using TypeScript with type-aware lint rules enabled. Check out the [TS template](https://github.com/vitejs/vite/tree/main/packages/create-vite/template-react-ts) for information on how to integrate TypeScript and [`typescript-eslint`](https://typescript-eslint.io) in your project.
