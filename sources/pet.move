module pet::dragon {
  use sui::object::{Self, Info, ID};
  use sui::transfer;
  use sui::tx_context::{Self, TxContext};
  use std::hash;
  use std::vector;
  use std::debug;

  struct Dragon has key {
    info: Info,
    attack: u64, 
    defense: u64,
  }

  // Reads

  public fun get_attack(d: &Dragon): u64 {
    d.attack
  }

  public fun get_defense(d: &Dragon): u64 {
    d.defense
  }

  // Writes

  public fun new_dragon(ctx: &mut TxContext): Dragon {
    let info = object::new(ctx);
    let id = object::info_id(&info);
    let attack = generate_random(id);
    let defense = generate_random(id);
    Dragon{
      info,
      attack,
      defense,
    }
  }

  public entry fun create_dragon(ctx: &mut TxContext) {
    transfer::transfer(new_dragon(ctx), tx_context::sender(ctx));
  }

  // Utils

  fun generate_random(id: &ID): u64 {
    let id_bytes = object::id_to_bytes(id);
    let hash = hash::sha2_256(id_bytes);
    let length = vector::length<u8>(&hash);
    debug::print<u64>(&length);
    1 + length % 100
  }
}