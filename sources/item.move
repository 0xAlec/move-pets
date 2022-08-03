module pet::item {
  use sui::object::{Self, Info};
  use std::option::{Self, Option};
  use pet::ability::{Ability};
  use sui::tx_context::{TxContext};

  struct Item has key, store {
    info: Info,
    attack: u8,
    defense: u8,
    mana: u8,
    mana_cost: u8,
    ability: Option<Ability>,
  }

  // Reads
  public fun get_attack(i: &Item): u8 {
    i.attack
  }

  public fun get_defense(i: &Item): u8 {
    i.defense
  }

  public fun get_mana(i: &Item): u8 {
    i.mana
  }
  
  public fun get_mana_cost(i: &Item): u8 {
    i.mana_cost
  }

  public fun get_ability(i: &Item): Option<Ability> {
    i.ability
  }

  // Writes
  public fun create_item(attack: u8, defense: u8, mana: u8, mana_cost: u8, ability: Option<Ability>, ctx: &mut TxContext): Item {
    Item{
      info: object::new(ctx),
      attack,
      defense,
      mana,
      mana_cost,
      ability
    }
  }
}