import gleam/io
import gleam/list
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

// TODO: Needs history for en passant, castling, repetition, etc.
pub type GameState {
  GameState(pieces: List(Piece), turn: Color)
}

pub type PositionError {
  NoPieceAtPosition
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

// Utility to get the piece at a given position
pub fn get_piece_at_position(
  state: GameState,
  position: Position,
) -> Result(Piece, Nil) {
  list.find(state.pieces, fn(piece) {
    piece.position == position && piece.color == state.turn
  })
}

// Utility to check if a position is empty
pub fn is_position_empty(state: GameState, position: Position) -> Bool {
  case get_piece_at_position(state, position) {
    Ok(_) -> False
    Error(Nil) -> True
  }
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
  GameState(pieces, turn: White)
}

// TODO: Implement
pub fn game_over(state: GameState) -> Bool {
  False
}

pub fn move_piece(state: GameState, from: Position, to: Position) -> GameState {
  // Check if there is a piece at the from position
  case get_piece_at_position(state, from) {
    Ok(piece) -> {
      // TODO: Check if the piece can move to the to position
      // Move the piece
      let new_pieces =
        list.map(state.pieces, fn(p) {
          case p.position == from {
            True -> Piece(piece.color, piece.kind, to)
            False -> p
          }
        })
      GameState(new_pieces, state.turn)
    }
    // What to do if there is no piece at the from position
    Error(Nil) -> state
  }
}

pub fn play_game(state: GameState) -> GameState {
  // Main game loop
  case game_over(state) {
    // Checkmate, stalemate, repetition, etc.
    True -> state
    False -> {
      // TODO: input a move
      move_piece(state, board_position("e", 2), board_position("e", 4))
      // TODO: switch turn
    }
  }
}

pub fn main() {
  initialize_game()
  |> play_game
  |> io.debug
}
