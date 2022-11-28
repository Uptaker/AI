// COMPLETE DISASTER

matrix = resetMatrix()

function resetMatrix()  {
  return [
    {x: 1,
      y: 1,
      player: null
     },
     {x: 2,
      y: 1,
      player: null
     }, 
     {x: 3,
      y: 1,
      player: null
     }, 
     {x: 4,
      y: 1,
      player: null
     },
    
    {x: 1,
      y: 2,
      player: null
     },
     {x: 2,
      y: 2,
      player: null
     }, 
     {x: 3,
      y: 2,
      player: null
     }, 
     {x: 4,
      y: 2,
      player: null
     },
    
    {x: 1,
      y: 3,
      player: null
     },
     {x: 2,
      y: 3,
      player: null
     }, 
     {x: 3,
      y: 3,
      player: null
     }, 
     {x: 4,
      y: 3,
      player: null
     },
    
    {x: 1,
      y: 4,
      player: null
     },
     {x: 2,
      y: 4,
      player: 'bla'
     }, 
     {x: 3,
      y: 4,
      player: 'bla'
     }, 
     {x: 4,
      y: 4,
      player: 'bla'
     }
  ]
}

console.log('has L', isL(matrix))


let possibleStates = []

// let moved = 0
// for (let i = 0; i < 4; i++) {
//   for (let i = 0; i < 4; i++) {
//     if (moved >= 4) return
//     moved++
//   }
// }

function findBiggest(map) {
  entries = Object.entries(map)
  let biggestIndex = entries[0][0]
  let biggest = entries[0][1]
  for (let i = 0; i < entries.length; i++) {
    if (entries[i][1] > biggest) {
      biggestIndex = entries[i][0]
      biggest = entries[i][1]
    }
  }
  return biggestIndex
}

function findI(mapX, mapY) {
  let biggest = 0;
  let biggestMap = 'X'
  let entries = Object.entries(mapX)
  for (let i = 0; i < entries.length; i++) {
      if (entries[i][1] > biggest) {
        biggestMap = 'X'
        biggest = entries[i][1]
      }
  }

  entries = Object.entries(mapY)
  for (let i = 0; i < entries.length; i++) {
    if (entries[i][1] > biggest) {
      biggestMap = 'Y'
      biggest = entries[i][1]
    }
  }
    return biggestMap
}

function isL(states) {
  let mapOfX = {}
  let mapOfY = {}
  objects = states.filter(s => s.player != null)
  for (let i = 0; i < objects.length; i++) {
    if (!mapOfX[objects[i].x]) mapOfX[objects[i].x] = 0
    if (!mapOfY[objects[i].y]) mapOfY[objects[i].y] = 0
    mapOfX[objects[i].x] += 1
    mapOfY[objects[i].y] += 1   
  }
  // const uniqueX = new Set(objects.map(o => o.x))
  // const uniqueY = new Set(objects.map(o => o.y))
  const biggestXAmount = findBiggest(mapOfX)
  const biggestYAmount = findBiggest(mapOfY)

  console.log(mapOfY[biggestYAmount])
  if (mapOfX[biggestXAmount] !== 3 && mapOfY[biggestYAmount] !== 3) return false


  if (findI(mapOfX, mapOfY) ==- 'X') {
    delete mapOfY[Object.entries(mapOfX).find(m => m[0] !== biggestXAmount)[0]]  
  } else {
    delete mapOfX[Object.entries(mapOfY).find(m => m[0] !== biggestYAmount)[0]]
  }

  console.log('mapOfY', mapOfY)
  console.log('mapOfX', mapOfX)
  
  return (Object.entries(mapOfX).length == 2 && Object.entries(mapOfY).length == 2)
}