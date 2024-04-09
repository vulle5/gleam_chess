import gleam/io
import gleam/string

pub type Color {
  White
  Black
}

pub type Kind {
  King
  Queen
  Rook
  Bishop
  Knight
  Pawn
}

pub opaque type Position {
  Position(rank: String, file: Int)
}

pub type Piece {
  Piece(color: Color, kind: Kind, position: Position)
}

pub type GameState {
  GameState(pieces: List(Piece), turn: Color)
}

pub fn board_position(rank: String, file: Int) -> Position {
  let unique_rank = case string.lowercase(rank) {
    "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" -> rank
    _ -> "a"
  }
  let unique_file = case file {
    1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 -> file
    _ -> 1
  }
  Position(unique_rank, unique_file)
}

pub fn initialize_game() -> GameState {
  let pieces: List(Piece) = [
    Piece(White, Rook, board_position("a", 1)),
    Piece(White, Knight, board_position("b", 1)),
    Piece(White, Bishop, board_position("c", 1)),
    Piece(White, Queen, board_position("d", 1)),
    Piece(White, King, board_position("e", 1)),
    Piece(White, Bishop, board_position("f", 1)),
    Piece(White, Knight, board_position("g", 1)),
    Piece(White, Rook, board_position("h", 1)),
    Piece(White, Pawn, board_position("a", 2)),
    Piece(White, Pawn, board_position("b", 2)),
    Piece(White, Pawn, board_position("c", 2)),
    Piece(White, Pawn, board_position("d", 2)),
    Piece(White, Pawn, board_position("e", 2)),
    Piece(White, Pawn, board_position("f", 2)),
    Piece(White, Pawn, board_position("g", 2)),
    Piece(White, Pawn, board_position("h", 2)),
    Piece(Black, Rook, board_position("a", 8)),
    Piece(Black, Knight, board_position("b", 8)),
    Piece(Black, Bishop, board_position("c", 8)),
    Piece(Black, Queen, board_position("d", 8)),
    Piece(Black, King, board_position("e", 8)),
    Piece(Black, Bishop, board_position("f", 8)),
    Piece(Black, Knight, board_position("g", 8)),
    Piece(Black, Rook, board_position("h", 8)),
    Piece(Black, Pawn, board_position("a", 7)),
    Piece(Black, Pawn, board_position("b", 7)),
    Piece(Black, Pawn, board_position("c", 7)),
    Piece(Black, Pawn, board_position("d", 7)),
    Piece(Black, Pawn, board_position(" e", 7)),
    Piece(Black, Pawn, board_position("f", 7)),
    Piece(Black, Pawn, board_position("g", 7)),
    Piece(Black, Pawn, board_position("h", 7)),
  ]
  GameState(pieces, White)
}

pub fn main() {
  let state = initialize_game()
  io.debug(state)
}
