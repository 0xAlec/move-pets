module pet::ability {
  use sui::tx_context::{TxContext};
  use sui::object::{Self, Info};

  struct Ability has key, store, copy, drop {
    type: u8,
    effect: u8,
    mana_cost: u8,
  }

  // Reads
  public fun get_mana_cost(ability: &Ability): u8 {
    ability.mana_cost
  }

  public fun get_type(ability: &Ability): u8 {
    ability.type
  }

  // Writes

  public fun create_ability(type: u8, stats: u8, _ctx: &mut TxContext): Ability {
    Ability{
      type,
      effect: stats,
      mana_cost: 0
    }
  }
}