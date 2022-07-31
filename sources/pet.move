module pet::dragon {
  use sui::object::{Self, Info, ID};
  use sui::transfer;
  use sui::tx_context::{Self, TxContext};
  use std::hash;
  use std::vector;
  use std::debug;
  use sui::typed_id::{Self, TypedID};
  use sui::bag::{Self, Bag};
  use pet::ability::{Self, Ability};
  use pet::item::{Self, Item};
  use std::option::{Self, Option};


  struct Dragon has key {
    info: Info,
    attack: u8, 
    defense: u8,
    mana: u8,
    // Optional Abilities
    atk_ability: Option<TypedID<Ability>>,
    def_ability: Option<TypedID<Ability>>,
    util_ability: Option<TypedID<Ability>>,
    inventory: TypedID<Bag>,
  }

  // Reads

  public fun get_attack(d: &Dragon): u8 {
    d.attack
  }

  public fun get_defense(d: &Dragon): u8 {
    d.defense
  }

  // Equips item: Adds item to inventory and increments stats accordingly
  public entry fun equip_item<T>(d: &mut Dragon, i: Item<T>, inventory: &mut Bag, ctx: &mut TxContext){
    // Increment stats

    d.attack = d.attack + item::get_attack(&i);
    d.defense = d.defense + item::get_defense(&i);
    d.mana = d.mana + item::get_mana(&i);

    // Equip ability
    let item_ability = item::get_ability(&i);
    let ability_ref = typed_id::new(item_ability);
    
    if (ability::is_attack(item_ability)){
      option::fill(&mut d.atk_ability, ability_ref)
    };

    // Add item to inventory
    bag::add(inventory, i, ctx);
  }

  // Writes

  public fun new_dragon(ctx: &mut TxContext): Dragon {
    // Generate stats
    let info = object::new(ctx);
    let id = object::info_id(&info);
    let attack = generate_random(id, 1, 100);
    let defense = generate_random(id, 1, 100);

    // Create inventory
    let inventory = bag::new_with_max_capacity(ctx, 5);
    let inventory_id = typed_id::new(&inventory);
    bag::transfer_to_object_id(inventory, &info);

    Dragon{
      info,
      attack,
      defense,
      mana: 50,
      atk_ability: option::none(),
      def_ability: option::none(),
      util_ability: option::none(),
      inventory: inventory_id,
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