import { useState } from 'react'

const App = () => {
  const anecdotes = [
    'Si duele, hazlo más a menudo.',
    '¡Agregar más personal a un proyecto de software que va tarde lo hace más tarde!',
    'El primer 90 por ciento del código representa el primer 10 por ciento del tiempo de desarrollo... El 10 por ciento restante del código representa el otro 90 por ciento del tiempo de desarrollo.',
    'Cualquier tonto puede escribir código que una computadora pueda entender. Los buenos programadores escriben código que los humanos puedan entender.',
    'La optimización prematura es la raíz de todos los males.',
    'Depurar es dos veces más difícil que escribir el código en primer lugar. Por lo tanto, si escribes el código tan inteligentemente como sea posible, por definición, no eres lo suficientemente inteligente para depurarlo.',
    'Programar sin un uso extremadamente intensivo de console.log es lo mismo que si un médico se negara a usar rayos X o análisis de sangre al diagnosticar pacientes.',
    'La única forma de ir rápido es ir bien.'
  ]

  const [selected, setSelected] = useState(0)
  const [votes, setVotes] = useState(new Array(anecdotes.length).fill(0))

  const handleNextAnecdote = () => {
    const randomIndex = Math.floor(Math.random() * anecdotes.length)
    setSelected(randomIndex)
  }

  const handleVote = () => {
    const copy = [...votes]
    copy[selected] += 1
    setVotes(copy)
  }

  return (
    <div>
      <div>
        {anecdotes[selected]}
      </div>
      <div>
        has {votes[selected]} votos
      </div>
      <button onClick={handleVote}>
        votar
      </button>
      <button onClick={handleNextAnecdote}>
        siguiente anécdota
      </button>
    </div>
  )
}

export default App