%lang starknet

@contract_interface
namespace IRegistry {
    func register_did(address: felt, did: felt) -> ();
    func get_did(address: felt) -> felt;
}

@storage_var
func did_registry(address: felt) -> felt:
end

@external
func register_did{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(address: felt, did: felt):
    let (existing_did) = did_registry.read(address)
    assert existing_did == 0, 'DID already registered for this address'
    did_registry.write(address, did)
    return ()
end

@view
func get_did{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(address: felt) -> felt:
    let (did) = did_registry.read(address)
    return (did)
end
