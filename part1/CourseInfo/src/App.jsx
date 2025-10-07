const App = () => {
  // Constantes en inglés
  const course = 'Half Stack application development'
  const part1 = 'Fundamentals of React'
  const part2 = 'Using props to pass data'
  const part3 = 'State of a component'
  
  // Traducciones al español
  const courseEsp = 'Desarrollo de aplicaciones Full Stack'
  const part1Esp = 'Fundamentos de React'
  const part2Esp = 'Uso de props para pasar datos'
  const part3Esp = 'Estado de un componente'
  
  // Ejercicios
  const exercises1 = 10
  const exercises2 = 7
  const exercises3 = 14

  const totalNumberOfExercises = exercises1 + exercises2 + exercises3

  return (
    <div>
      <Header course={course} />
      <Content 
        part1={part1} 
        exercises1={exercises1}
        part2={part2}
        exercises2={exercises2}
        part3={part3}
        exercises3={exercises3}
      />
      <Total total={totalNumberOfExercises} />
      
      <hr />
      
      <Header course={courseEsp} />
      <Content 
        part1={part1Esp} 
        exercises1={exercises1}
        part2={part2Esp}
        exercises2={exercises2}
        part3={part3Esp}
        exercises3={exercises3}
      />
      <TotalEsp total={totalNumberOfExercises} />
    </div>
  )
}

const Header = (props) => {
  return (
    <h1>{props.course}</h1>
  )
}

const Content = (props) => {
  return (
    <div>
      <Part part={props.part1} exercises={props.exercises1} />
      <Part part={props.part2} exercises={props.exercises2} />
      <Part part={props.part3} exercises={props.exercises3} />
    </div>
  )
}

const Part = (props) => {
  return (
    <p>
      {props.part} {props.exercises}
    </p>
  )
}

const Total = (props) => {
  return (
    <p>Number of exercises {props.total}</p>
  )
}

const TotalEsp = (props) => {
  return (
    <p>Número de ejercicios {props.total}</p>
  )
}

export default App