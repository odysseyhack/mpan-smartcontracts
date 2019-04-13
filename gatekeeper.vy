
Query: event({
    sender: indexed(address), 
    queryType: uint256,
    queryId: int128,
    identifier: int128,
    attribute: uint256,
})

# query type 0: Info
# query type 1: MPC
QUERY_TYPE_INFO: constant(uint256) = 0
QUERY_TYPE_CALC: constant(uint256) = 1

NONE_ATTRIBUTE: constant(uint256) = 0

# Setup private variables (only callable from within the contract)
creator: address
gatekeeper_address: address
next_query_id: int128

#Mappings
allowed_clients: public(map(address, bool))


@public
def __init__():
    # Define owner as creator
    self.creator = msg.sender
    self.allowed_clients[msg.sender] = True
    self.next_query_id = 0

@public
def submit_calc_query(identifier: int128, attribute: uint256):
    # Do some check, but not now
    query_id: int128 = self.next_query_id
    self.next_query_id = query_id + 1
    log.Query(msg.sender, QUERY_TYPE_INFO, query_id, identifier, attribute)


@public
def submit_info_query(identifier: int128):
    # Do some check, but not now
    query_id: int128 = self.next_query_id
    self.next_query_id = query_id + 1
    log.Query(msg.sender, QUERY_TYPE_CALC, query_id, identifier, NONE_ATTRIBUTE)

   