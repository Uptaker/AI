export enum Type {
  X = 'X', O = 'O', BLANK = ''
}

export enum AiMode {
  DUMB, MINIMAX
}


export interface Position {
  row: number,
  column: number,
  type?: Type,
  score?: number
}

export interface Status {
  tie: boolean
  winner?: Position[]
}

export const deepCopy = (input: Record<string, unknown>) => JSON.parse(JSON.stringify(input))

export function flatten<T>(arr: T[][]): T[] {
  return [].concat.apply([], arr)
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