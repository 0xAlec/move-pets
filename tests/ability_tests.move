#[test_only]

module pet::ability_tests{
  use pet::ability::{Self};
  use std::option::{Self};
  use pet::dragon::{Self, Dragon};
  use pet::item::{Self};
  use sui::bag::{Bag};
  use sui::test_scenario;

  #[test]
  fun test_ability(){
    let owner = @0x1;
    let scenario = &mut test_scenario::begin(&owner);
    test_scenario::next_tx(scenario, &owner);
    {
      let ctx = test_scenario::ctx(scenario);
      dragon::create_dragon(ctx);
    };
    test_scenario::next_tx(scenario, &owner);
    { 
      let hero = test_scenario::take_owned<Dragon>(scenario);
      let inventory = test_scenario::take_child_object<Dragon, Bag>(scenario, &hero);
      let ctx = test_scenario::ctx(scenario);
      // Create attack ability - Scorch
      let scorch = ability::create_ability(0, 10, ctx);
      // Create corresponding item
      let flamethrower = item::create_item(10,0,0,5,option::some(scorch),ctx);
      dragon::equip_item(&mut hero, flamethrower, &mut inventory, ctx);
      assert!(dragon::get_attack(&hero)==10, 0);
      test_scenario::return_owned(scenario, hero);
      test_scenario::return_owned(scenario, inventory);
    }
  }
}