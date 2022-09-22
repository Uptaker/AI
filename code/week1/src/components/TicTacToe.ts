export enum Type {
  X = 'X', O = 'O', BLANK = ''
}

export interface Position {
  row: number,
  column: number,
  type?: Type
}

export const winCombos = [
  [[0, 0], [0, 1], [0, 2]],
  [[1, 0], [1, 1], [1, 2]],
  [[2, 0], [2, 1], [2, 2]],
  [[0, 0], [1, 0], [2, 0]],
  [[0, 1], [1, 1], [2, 1]],
  [[0, 2], [1, 2], [2, 2]],
  [[0, 0], [1, 1], [2, 2]],
  [[2, 0], [1, 1], [0, 2]]
]

export function getBlankState() {
  let state = [[], [], []] as Position[][]
  for (let i = 0; i < 3; i++) {
    for (let j = 0; j < 3; j++) state[i].push({row: i, column: j, type: Type.BLANK})
  }
  return state
}