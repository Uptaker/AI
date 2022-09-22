export enum Type {
  X = 'X', O = 'O', BLANK = ''
}

export type State = Type.X | Type.O | Type.BLANK

export const winCombos = [
  [[0, 0], [0, 1], [0, 2]],
  [[1, 0], [1, 1], [1, 2]],
  [[2, 0], [2, 1], [2, 2]],
  [[0, 0], [1, 0], [2, 0]],
  [[0, 1], [1, 1], [2, 1]],
  [[0, 2], [1, 2], [2, 2]],
  [[0, 0], [1, 1], [2, 2]],
  [[2, 2], [1, 1], [0, 0]],
]

export const blankState = () => [[Type.BLANK, Type.BLANK, Type.BLANK], [Type.BLANK, Type.BLANK, Type.BLANK], [Type.BLANK, Type.BLANK, Type.BLANK]] as State[][]