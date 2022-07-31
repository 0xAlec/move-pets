module pet::ability {
  use sui::object::{Info};

  struct Ability has key, store {
    info: Info,
    attack: bool,
    defense: bool,
    util: bool,
    mana_cost: u8,
  }

  // Reads
  public fun get_mana_cost<Type>(ability: &Ability): u8 {
    ability.mana_cost
  }

  public fun is_attack(ability: &Ability): bool {
    ability.attack
  }

}