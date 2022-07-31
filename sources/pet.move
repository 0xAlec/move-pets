module pet::dragon {
  use sui::object::{Self, Info, ID};
  use sui::transfer;
  use sui::tx_context::{Self, TxContext};
  use std::hash;
  use std::vector;
  use std::debug;

  struct Dragon has key {
    info: Info,
    attack: u8, 
    defense: u8,
  }

  // Reads

  public fun get_attack(d: &Dragon): u8 {
    d.attack
  }

  public fun get_defense(d: &Dragon): u8 {
    d.defense
  }

  // Writes

  public fun new_dragon(ctx: &mut TxContext): Dragon {
    let info = object::new(ctx);
    let id = object::info_id(&info);
    let attack = generate_random(id, 1, 100);
    let defense = generate_random(id, 1, 100);
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

  fun generate_random(id: &ID, lo: u8, hi: u8): u8 {
    let id_bytes = object::id_to_bytes(id);
    let hash = hash::sha2_256(id_bytes);
    let length = vector::length<u8>(&hash);
    debug::print<u64>(&length);
    lo + (length as u8) % hi
  }
}