#[test_only]

module pet::pet_tests{
  use pet::dragon::{Self};
  use sui::test_scenario;


  #[test]
  fun test_rng(){
    let owner = @0x1;
    let scenario = &mut test_scenario::begin(&owner);
    test_scenario::next_tx(scenario, &owner);
    {
      let ctx = test_scenario::ctx(scenario);
      dragon::create_dragon(ctx);
    }
  }
}