module pet::item {
  use sui::object::{Self, Info};
  use std::option::{Self, Option};
  use pet::ability::{Ability};
  use sui::tx_context::{TxContext};

  struct Attack {}
  struct Defense {}
  struct Util {}

  struct ItemStats has store, copy{
    attack: u8,
    defense: u8,
    mana: u8,
    mana_cost: u8,
  }

  struct Item<phantom T> has key, store {
    info: Info,
    stats: ItemStats,
    ability: Option<Ability>,
  }

  // Reads
  public fun get_attack<T>(i: &Item<T>): u8 {
    i.stats.attack
  }

  public fun get_defense<T>(i: &Item<T>): u8 {
    i.stats.defense
  }

  public fun get_mana<T>(i: &Item<T>): u8 {
    i.stats.mana
  }
  
  public fun get_mana_cost<T>(i: &Item<T>): u8 {
    i.stats.mana_cost
  }

  public fun get_ability<T>(i: &Item<T>): &Ability {
    option::borrow<Ability>(&i.ability)
  }

  // Writes

  public fun create_item<T>(stats: ItemStats, ability: Option<Ability>, ctx: &mut TxContext): Item<T> {
    Item<T>{
      info: object::new(ctx),
      stats,
      ability
    }
  }
}